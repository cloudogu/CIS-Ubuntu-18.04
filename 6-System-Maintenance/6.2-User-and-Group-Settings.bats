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

@test "" {
    run bash -c ""
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "" {
    run bash -c ""
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "" {
    run bash -c ""
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "" {
    run bash -c ""
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "" {
    run bash -c ""
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "" {
    run bash -c ""
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "" {
    run bash -c ""
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "" {
    run bash -c ""
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "" {
    run bash -c ""
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "" {
    run bash -c ""
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "" {
    run bash -c ""
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}