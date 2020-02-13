#!/bin/bash
cut -d: -f1 /etc/passwd | sort | uniq -d | while read -r usr; do
    echo "Duplicate login name \"$usr\" in /etc/passwd"
done
