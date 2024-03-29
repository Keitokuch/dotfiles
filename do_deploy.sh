#!/usr/bin/env bash
CONFIG_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
OLD=./oldconfigs

mkdir -p $OLD

parse_ostype() {
    if [[ "$OSTYPE" == "linux-gnu" ]]; then
        ostype=linux
        if [ -f /etc/os-release ]; then
            . /etc/os-release
            OS=$ID
            OSVER=$VERSION_ID
        else
            echo "Failed: linux distro not recognized."
            return 1
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        OS=macos
        ostype=darwin
    else
        echo "Failed: OS type $OSTYPE not supported."
        return 1
    fi
}

deploy_one() {
    deploy_file=$1
    if [[ ! -f $deploy_file ]]; then
        echo "Deploy config $deploy_file not found"
        return
    fi
    while read src dst
    do
        dst=${dst/#~/$HOME}
        src=${src/\$OS/$OS}
        dst=${dst/\$OS/$OS}
        dstdir=`dirname "$dst"`
        dstname=`basename "$dst"`
        [[ -L $dst ]] && rm $dst
        [[ -f $dst ]] && cp $dst "$OLD/${dstname}_$(date -Idate).old"
        if [[ $dst == */ ]]; then
            mkdir -p $dst 
        else
            [[ -d $dst ]] && mv $dst "$OLD/${dstname}_$(date -Idate).old"
            mkdir -p $dstdir
        fi
        ln -sf $CONFIG_PATH/${src} ${dst}
        echo "softlink ${src} to ${dst}"
    done <$deploy_file
    after_file=$deploy_file.after
    cd $CONFIG_PATH
    [[ -f deploy/$after_file ]] && . deploy/$after_file && echo ">>> exec $after_file"
    cd deploy
}

do_deploy() {
    parse_ostype
    cd $CONFIG_PATH/deploy
    if [[ $# -gt 0 ]]; then
        while (( $# > 0 ))
        do
            deploy_one $1.deploy
            shift
        done
    else
        echo ">>> deploying all configs"
        ls
        for deploy_file in *.deploy; do
            deploy_one $deploy_file
        done
    fi
}

do_deploy $@
