#!/usr/bin/env bats

@test "6.2.1 Ensure password fields are not empty (Scored)" {
    run bash -c 'awk -F: '\''($2 == "" ) { print $1 " does not have a password "}'\'' /etc/shadow'
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "6.2.2 Ensure no legacy \"+\" entries exist in /etc/passwd (Scored)" {
    run bash -c "grep '^\+:' /etc/passwd"
    [ "$status" -ne 0 ]
    [[ "$output" == "" ]]
}

@test "6.2.3 Ensure all users' home directories exist (Scored)" {
    run bash -c 'grep -E -v '\''^(halt|sync|shutdown)'\'' /etc/passwd | awk -F: '\''($7 != "'\''"$(which nologin)"'\''" && $7 != "/bin/false") { print $1 " " $6 }'\'' | while read -r user dir; do if [ ! -d "$dir" ]; then echo "The home directory $dir of user $user does not exist."; fi; done'
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "6.2.4 Ensure no legacy \"+\" entries exist in /etc/shadow (Scored)" {
    run bash -c "grep '^\+:' /etc/shadow"
    [ "$status" -ne 0 ]
    [[ "$output" == "" ]]
}

@test "6.2.5 Ensure no legacy "+" entries exist in /etc/group (Scored)" {
    run bash -c "grep '^\+:' /etc/group"
    [ "$status" -ne 0 ]
    [[ "$output" == "" ]]
}

@test "6.2.6 Ensure root is the only UID 0 account (Scored)" {
    run bash -c 'awk -F: '\''($3 == 0) { print $1 }'\'' /etc/passwd'
    [ "$status" -eq 0 ]
    [[ "$output" == "root" ]]
}

@test "6.2.7 Ensure root PATH Integrity (Scored)" {
    run bash -c 'if echo "$PATH" | grep -q "::" ; then echo "Empty Directory in PATH (::)"; fi; if echo "$PATH" | grep -q ":$" ; then echo "Trailing : in PATH"; fi; for x in $(echo "$PATH" | tr ":" " ") ; do if [ -d "$x" ] ; then ls -ldH "$x" | awk '\''$9 == "." {print "PATH contains current working directory (.)"} $3 != "root" {print $9, "is not owned by root"} substr($1,6,1) != "-" {print $9, "is group writable"} substr($1,9,1) != "-" {print $9, "is world writable"}'\''; else echo "$x is not a directory"; fi; done'
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "6.2.8 Ensure users' home directories permissions are 750 or more restrictive (Scored)" {
    run bash -c 'grep -E -v '\''^(halt|sync|shutdown)'\'' /etc/passwd | awk -F: '\''($7 != "'\''"$(which nologin)"'\''" && $7 != "/bin/false") { print $1 " " $6 }'\'' | while read -r user dir; do if [ ! -d "$dir" ]; then echo "The home directory ($dir) of user $user does not exist."; else dirperm="$(ls -ld "$dir" | cut -f1 -d" ")"; if [ "$(echo "$dirperm" | cut -c6)" != "-" ]; then echo "Group Write permission set on the home directory \"$dir\" of user $user"; fi; if [ "$(echo "$dirperm" | cut -c8)" != "-" ]; then echo "Other Read permission set on the home directory \"$dir\" of user $user"; fi; if [ "$(echo "$dirperm" | cut -c9)" != "-" ]; then echo "Other Write permission set on the home directory \"$dir\" of user $user"; fi; if [ "$(echo "$dirperm" | cut -c10)" != "-" ]; then echo "Other Execute permission set on the home directory \"$dir\" of user $user"; fi; fi; done'
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "6.2.9 Ensure users own their home directories (Scored)" {
    run bash -c 'grep -E -v '\''^(halt|sync|shutdown)'\'' /etc/passwd | awk -F: '\''($7 != "'\''"$(which nologin)"'\''" && $7 != "/bin/false") { print $1 " " $6 }'\'' | while read -r user dir; do if [ ! -d "$dir" ]; then echo "The home directory \"$dir\" of user $user does not exist."; else owner=$(stat -L -c "%U" "$dir"); if [ "$owner" != "$user" ]; then echo "The home directory \"$dir\" of user $user is owned by $owner."; fi; fi; done'
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "6.2.10 Ensure users' dot files are not group or world writable (Scored)" {
    run bash -c 'grep -E -v '\''^(halt|sync|shutdown)'\'' /etc/passwd | awk -F: '\''($7 != "'\''"$(which nologin)"'\''" && $7 != "/bin/false") { print $1 " " $6 }'\'' | while read -r user dir; do if [ ! -d "$dir" ]; then echo "The home directory \"$dir\" of user \"$user\" does not exist."; else for file in "$dir"/.[A-Za-z0-9]*; do if [ ! -h "$file" ] && [ -f "$file" ]; then fileperm="$(ls -ld "$file" | cut -f1 -d" ")"; if [ "$(echo "$fileperm" | cut -c6)" != "-" ]; then echo "Group Write permission set on file $file"; fi; if [ "$(echo "$fileperm" | cut -c9)" != "-" ]; then echo "Other Write permission set on file \"$file\""; fi; fi; done; fi; done'
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "6.2.11 Ensure no users have .forward files (Scored)" {
    run bash -c 'grep -E -v '\''^(root|halt|sync|shutdown)'\'' /etc/passwd | awk -F: '\''($7 != "'\''"$(which nologin)"'\''" && $7 != "/bin/false") { print $1 " " $6 }'\'' | while read -r user dir; do if [ ! -d "$dir" ]; then echo "The home directory ($dir) of user $user does not exist."; else if [ ! -h "$dir/.forward" ] && [ -f "$dir/.forward" ]; then echo ".forward file \"$dir/.forward\" exists"; fi; fi; done'
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "6.2.12 Ensure no users have .netrc files (Scored)" {
    run bash -c 'grep -E -v '\''^(root|halt|sync|shutdown)'\'' /etc/passwd | awk -F: '\''($7 != "'\''"$(which nologin)"'\''" && $7 != "/bin/false") { print $1 " " $6 }'\'' | while read -r user dir; do if [ ! -d "$dir" ]; then echo "The home directory \"$dir\" of user \"$user\" does not exist."; else if [ ! -h "$dir/.netrc" ] && [ -f "$dir/.netrc" ]; then echo ".netrc file \"$dir/.netrc\" exists"; fi; fi; done'
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "6.2.13 Ensure users' .netrc Files are not group or world accessible (Scored)" {
    run bash -c 'grep -E -v '\''^(root|halt|sync|shutdown)'\'' /etc/passwd | awk -F: '\''($7 != "'\''"$(which nologin)"'\''" && $7 != "/bin/false") { print $1 " " $6 }'\'' | while read -r user dir; do if [ ! -d "$dir" ]; then echo "The home directory \"$dir\" of user \"$user\" does not exist."; else for file in $dir/.netrc; do if [ ! -h "$file" ] && [ -f "$file" ]; then fileperm="$(ls -ld "$file" | cut -f1 -d" ")"; if [ "$(echo "$fileperm" | cut -c5)" != "-" ]; then echo "Group Read set on \"$file\""; fi; if [ "$(echo "$fileperm" | cut -c6)" != "-" ]; then echo "Group Write set on \"$file\""; fi; if [ "$(echo "$fileperm" | cut -c7)" != "-" ]; then echo "Group Execute set on \"$file\""; fi; if [ "$(echo "$fileperm" | cut -c8)" != "-" ]; then echo "Other Read set on \"$file\""; fi; if [ "$(echo "$fileperm" | cut -c9)" != "-" ]; then echo "Other Write set on \"$file\""; fi; if [ "$(echo "$fileperm" | cut -c10)" != "-" ]; then echo "Other Execute set on \"$file\""; fi; fi; done; fi; done'
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "6.2.14 Ensure no users have .rhosts files (Scored)" {
    run bash -c 'grep -E -v '\''^(root|halt|sync|shutdown)'\'' /etc/passwd | awk -F: '\''($7 != "'\''"$(which nologin)"'\''" && $7 != "/bin/false") { print $1 " " $6 }'\'' | while read -r user dir; do if [ ! -d "$dir" ]; then echo "The home directory \"$dir\" of user \"$user\" does not exist."; else for file in $dir/.rhosts; do if [ ! -h "$file" ] && [ -f "$file" ]; then echo ".rhosts file in \"$dir\""; fi; done; fi; done'
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "6.2.15 Ensure all groups in /etc/passwd exist in /etc/group (Scored)" {
    run bash -c 'awk -F: '\''{print $4}'\'' /etc/passwd | while read -r gid; do if ! grep -E -q "^.*?:[^:]*:$gid:" /etc/group; then echo "The group ID \"$gid\" does not exist in /etc/group"; fi; done'
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "6.2.16 Ensure no duplicate UIDs exist (Scored)" {
    run bash -c 'awk -F: '\''{print $3}'\'' /etc/passwd | sort -n | uniq -c | while read -r uid; do [ -z "$uid" ] && break; set - $uid; if [ $1 -gt 1 ]; then users=$(awk -F: '\''($3 == n) { print $1 }'\'' n="$2" /etc/passwd | xargs); echo "Duplicate UID \"$2\": \"$users\""; fi; done'
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "6.2.17 Ensure no duplicate GIDs exist (Scored)" {
    run bash -c 'cut -d: -f3 /etc/group | sort | uniq -d | while read x ; do echo "Duplicate GID ($x) in /etc/group"; done'
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "6.2.18 Ensure no duplicate user names exist (Scored)" {
    run bash -c 'cut -d: -f1 /etc/passwd | sort | uniq -d | while read -r usr; do echo "Duplicate login name \"$usr\" in /etc/passwd"; done'
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "6.2.19 Ensure no duplicate group names exist (Scored)" {
    run bash -c 'cut -d: -f1 /etc/group | sort | uniq -d | while read -r grp; do echo "Duplicate group name \"$grp\" exists in /etc/group"; done'
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "6.2.20 Ensure shadow group is empty (Scored)" {
    run bash -c 'grep ^shadow:[^:]*:[^:]*:[^:]+ /etc/group'
    [ "$status" -ne 0 ]
    [[ "$output" == "" ]]
    local SHADOWGROUP=$(grep shadow /etc/group)
    SHADOWGROUP=(${SHADOWGROUP//shadow:x:/ }) # get the last part from the string
    SHADOWGROUPID=(${SHADOWGROUP//:/ }) # remove everything but the id
    run bash -c "awk -F: '(\$4 == $SHADOWGROUPID) { print }' /etc/passwd"
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}