#!/bin/bash
cut -d: -f1 /etc/group | sort | uniq -d | while read -r grp; do
    echo "Duplicate group name \"$grp\" exists in /etc/group"
done
