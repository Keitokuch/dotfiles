#!/usr/bin/env bash
set -euo pipefail

CONFIG_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
DEPLOY_DIR="$CONFIG_PATH/deploy"
BACKUP_DIR="$CONFIG_PATH/oldconfigs"

OS=""
OSVER=""
EXPANDED_SOURCES=()

log() {
    printf '>>> %s\n' "$*"
}

warn() {
    printf 'WARN: %s\n' "$*" >&2
}

usage() {
    cat <<EOF
Usage: $0 [group ...]

Deploy all groups when no group is provided. Available groups:
$(list_groups | sed 's/^/  /')
EOF
}

list_groups() {
    local deploy_file
    for deploy_file in "$DEPLOY_DIR"/*.deploy; do
        [[ -e "$deploy_file" ]] || return 0
        basename "$deploy_file" .deploy
    done
}

parse_ostype() {
    case "$OSTYPE" in
        linux*)
            if [[ ! -f /etc/os-release ]]; then
                printf 'Failed: linux distro not recognized.\n' >&2
                return 1
            fi
            # shellcheck disable=SC1091
            . /etc/os-release
            OS="${ID:-linux}"
            OSVER="${VERSION_ID:-}"
            ;;
        darwin*)
            OS="macos"
            OSVER=""
            ;;
        *)
            printf 'Failed: OS type %s not supported.\n' "$OSTYPE" >&2
            return 1
            ;;
    esac
}

expand_value() {
    local value="$1"
    value="${value//\$OS/$OS}"
    value="${value/#\~/$HOME}"
    printf '%s' "$value"
}

backup_path() {
    local name="$1"
    printf '%s/%s_%s.old' "$BACKUP_DIR" "$name" "$(date +%Y%m%d-%H%M%S)"
}

backup_existing() {
    local dst="$1"
    local backup

    [[ -e "$dst" || -L "$dst" ]] || return 0

    mkdir -p "$BACKUP_DIR"
    backup="$(backup_path "$(basename "$dst")")"

    if [[ -L "$dst" ]]; then
        rm -- "$dst"
        return 0
    fi

    if [[ -e "$backup" ]]; then
        backup="${backup}.$$"
    fi

    mv -- "$dst" "$backup"
    log "backed up $dst to $backup"
}

expand_sources() {
    local src="$1"

    EXPANDED_SOURCES=()
    if [[ "$src" == *"*"* || "$src" == *"?"* || "$src" == *"["* ]]; then
        # shellcheck disable=SC2206
        EXPANDED_SOURCES=( "$CONFIG_PATH"/$src )
    else
        EXPANDED_SOURCES=( "$CONFIG_PATH/$src" )
    fi
}

link_source() {
    local src_abs="$1"
    local dst="$2"
    local target
    local current_link

    if [[ "$dst" == */ ]]; then
        if [[ -e "${dst%/}" && ! -d "${dst%/}" ]]; then
            backup_existing "${dst%/}"
        fi
        mkdir -p "$dst"
        target="${dst%/}/$(basename "$src_abs")"
    else
        mkdir -p "$(dirname "$dst")"
        target="$dst"
    fi

    if [[ -L "$target" ]]; then
        current_link="$(readlink "$target")"
        if [[ "$current_link" == "$src_abs" ]]; then
            log "already linked ${src_abs#$CONFIG_PATH/} -> $target"
            return 0
        fi
    fi

    backup_existing "$target"
    ln -s "$src_abs" "$target"
    log "linked ${src_abs#$CONFIG_PATH/} -> $target"
}

deploy_rule() {
    local raw_src="$1"
    local raw_dst="$2"
    local src
    local dst
    local src_abs

    src="$(expand_value "$raw_src")"
    dst="$(expand_value "$raw_dst")"

    expand_sources "$src"
    if [[ ${#EXPANDED_SOURCES[@]} -eq 0 || ! -e "${EXPANDED_SOURCES[0]}" ]]; then
        warn "source '$src' did not match any files"
        return 1
    fi

    if [[ ${#EXPANDED_SOURCES[@]} -gt 1 && "$dst" != */ ]]; then
        warn "source '$src' matched multiple files but destination '$dst' is not a directory"
        return 1
    fi

    for src_abs in "${EXPANDED_SOURCES[@]}"; do
        [[ -e "$src_abs" ]] || continue
        link_source "$src_abs" "$dst"
    done
}

run_after_hook() {
    local group="$1"
    local hook="$DEPLOY_DIR/$group.deploy.after"

    if [[ -f "$hook" ]]; then
        log "running $(basename "$hook")"
        (
            cd "$CONFIG_PATH"
            # shellcheck disable=SC1090
            . "$hook"
        )
    fi
}

deploy_group() {
    local group="$1"
    local deploy_file="$DEPLOY_DIR/$group.deploy"
    local line_no=0
    local src
    local dst
    local extra

    if [[ ! -f "$deploy_file" ]]; then
        warn "deploy group '$group' not found"
        return 1
    fi

    log "deploying $group"
    while read -r src dst extra || [[ -n "${src:-}" ]]; do
        line_no=$((line_no + 1))

        [[ -n "${src:-}" ]] || continue
        [[ "$src" != \#* ]] || continue

        if [[ -z "${dst:-}" || -n "${extra:-}" ]]; then
            warn "$deploy_file:$line_no must contain exactly '<source> <destination>'"
            return 1
        fi

        deploy_rule "$src" "$dst"
    done < "$deploy_file"

    run_after_hook "$group"
}

main() {
    local group
    local -a groups
    groups=()

    if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
        usage
        return 0
    fi

    parse_ostype
    mkdir -p "$BACKUP_DIR"

    if [[ $# -gt 0 ]]; then
        groups=( "$@" )
    else
        while IFS= read -r group; do
            [[ -n "$group" ]] && groups+=( "$group" )
        done < <(list_groups)
    fi

    for group in "${groups[@]}"; do
        group="${group%.deploy}"
        deploy_group "$group"
    done
}

main "$@"
