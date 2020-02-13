#!/bin/bash
awk -F: '{print $4}' /etc/passwd | while read -r gid; do
  if ! grep -E -q "^.*?:[^:]*:$gid:" /etc/group; then
    echo "The group ID \"$gid\" does not exist in /etc/group"
  fi
done
