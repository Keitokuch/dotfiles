#!/usr/bin/env bash

if [[ ! -r /proc/stat ]]; then
    printf "n/a"
    exit 0
fi

awk '
    {
        used = $2 + $4
        total = $2 + $4 + $5
        if (NR == 1) {
            used_start = used
            total_start = total
        } else if (total > total_start) {
            printf "%.1f%%", (used - used_start) * 100 / (total - total_start)
        } else {
            printf "n/a"
        }
    }
' <(grep 'cpu ' /proc/stat) <(sleep "${CPU_USAGE_INTERVAL:-3}"; grep 'cpu ' /proc/stat)
