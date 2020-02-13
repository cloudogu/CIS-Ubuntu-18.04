#!/bin/bash
awk -F: '{print $3}' /etc/passwd | sort -n | uniq -c | while read -r uid; do
  [ -z "$uid" ] && break
  set - $uid
  if [ $1 -gt 1 ]; then
    users=$(awk -F: '($3 == n) { print $1 }' n="$2" /etc/passwd |
      xargs)
    echo "Duplicate UID \"$2\": \"$users\""
  fi
done
