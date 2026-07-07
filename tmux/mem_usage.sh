#!/usr/bin/env bash

if command -v free >/dev/null 2>&1; then
    free -m | awk 'NR == 2 { printf "%.0f%% %.1fGB", $3 * 100 / $2, $2 / 1024 }'
elif command -v vm_stat >/dev/null 2>&1 && command -v sysctl >/dev/null 2>&1; then
    page_size=$(vm_stat | awk '/page size of/ { print $8 }')
    used_pages=$(vm_stat | awk '
        /Pages active/ { gsub("\\.", "", $3); active = $3 }
        /Pages wired down/ { gsub("\\.", "", $4); wired = $4 }
        /Pages occupied by compressor/ { gsub("\\.", "", $5); compressed = $5 }
        END { print active + wired + compressed }
    ')
    total_bytes=$(sysctl -n hw.memsize)
    awk -v used_pages="$used_pages" -v page_size="$page_size" -v total_bytes="$total_bytes" '
        BEGIN {
            used_bytes = used_pages * page_size
            printf "%.0f%% %.1fGB", used_bytes * 100 / total_bytes, total_bytes / 1024 / 1024 / 1024
        }
    '
else
    printf "n/a"
fi
