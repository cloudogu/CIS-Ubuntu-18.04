#!/usr/bin/env bats

@test "6.1.1 Audit system file permissions (Not Scored)" {
    local packages
    packages=$(dpkg --get-selections | grep install | awk '{split($0, a, "\t"); split(a[1], b, ":"); print b[1]}')

    for package in $packages; do
       (dpkg --verify "$package")
    done
}

@test "6.1.2 Ensure permissions on /etc/passwd are configured (Scored)" {
    (stat /etc/passwd | grep -E "Uid: \([[:space:]]+0/[[:space:]]+root\)")
    (stat /etc/passwd | grep -E "Gid: \([[:space:]]+0/[[:space:]]+root\)")
    (stat /etc/passwd | grep "Access: (0644/")
}

@test "6.1.3 Ensure permissions on /etc/gshadow- are configured (Scored)" {
    (stat /etc/gshadow- | grep -E "Uid: \([[:space:]]+0/[[:space:]]+root\)")
    (stat /etc/gshadow- | grep -E "Gid: \([[:space:]]+0/[[:space:]]+root\)") \
        || (stat /etc/gshadow- | grep -E "Gid: \([[:space:]]+[[:digit:]]+/[[:space:]]+shadow\)")
    (stat /etc/gshadow- | grep -E "Access: \(0[0246][04]0/")
}

@test "6.1.4 Ensure permissions on /etc/shadow are configured (Scored)" {
    (stat /etc/shadow | grep -E "Uid: \([[:space:]]+0/[[:space:]]+root\)")
    (stat /etc/shadow | grep -E "Gid: \([[:space:]]+[[:digit:]]+/[[:space:]]+shadow\)")
    (stat /etc/shadow | grep -E "Access: \(0[0246][04]0/")
}

@test "6.1.5 Ensure permissions on /etc/group are configured (Scored)" {
    (stat /etc/group | grep -E "Uid: \([[:space:]]+0/[[:space:]]+root\)")
    (stat /etc/group | grep -E "Gid: \([[:space:]]+0/[[:space:]]+root\)")
    (stat /etc/group | grep "Access: (0644/")
}

@test "6.1.6 Ensure permissions on /etc/passwd- are configured (Scored)" {
    (stat /etc/passwd- | grep -E "Uid: \([[:space:]]+0/[[:space:]]+root\)")
    (stat /etc/passwd- | grep -E "Gid: \([[:space:]]+0/[[:space:]]+root\)")
    (stat /etc/passwd- | grep -E "Access: \(0[0246]00/")
}

@test "6.1.7 Ensure permissions on /etc/shadow- are configured (Scored)" {
    (stat /etc/shadow- | grep -E "Uid: \([[:space:]]+0/[[:space:]]+root\)")
    (stat /etc/shadow- | grep -E "Gid: \([[:space:]]+[[:digit:]]+/[[:space:]]+shadow\)")
    (stat /etc/shadow- | grep -E "Access: \(0[0246][04]0/")
}

@test "6.1.8 Ensure permissions on /etc/group- are configured (Scored)" {
    (stat /etc/group- | grep -E "Uid: \([[:space:]]+0/[[:space:]]+root\)")
    (stat /etc/group- | grep -E "Gid: \([[:space:]]+0/[[:space:]]+root\)")
    (stat /etc/group- | grep -E "Access: \(0[0246][04]{2}/")
}

@test "6.1.9 Ensure permissions on /etc/gshadow are configured (Scored)" {
    (stat /etc/gshadow | grep -E "Uid: \([[:space:]]+0/[[:space:]]+root\)")
    (stat /etc/gshadow | grep -E "Gid: \([[:space:]]+[[:digit:]]+/[[:space:]]+shadow\)")
    (stat /etc/gshadow | grep -E "Access: \(0[0246][04]0/")
}

@test "6.1.10 Ensure no world writable files exist (Scored)" {
    run bash -c "df --local -P | awk '{if (NR!=1) print \$6}' | xargs -I '{}' find '{}' -xdev -type f -perm -0002"
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "6.1.11 Ensure no unowned files or directories exist (Scored)" {
    run bash -c "df --local -P | awk '{if (NR!=1) print \$6}' | xargs -I '{}' find '{}' -xdev -nouser"
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "6.1.12 Ensure no ungrouped files or directories exist (Scored)" {
    run bash -c "df --local -P | awk '{if (NR!=1) print \$6}' | xargs -I '{}' find '{}' -xdev -nogroup"
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "6.1.13 Audit SUID executables (Not Scored)" {
    run bash -c "df --local -P | awk '{if (NR!=1) print \$6}' | xargs -I '{}' find '{}' -xdev -type f -perm -4000"
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}

@test "6.1.14 Audit SGID executables (Not Scored)" {
    run bash -c "df --local -P | awk '{if (NR!=1) print \$6}' | xargs -I '{}' find '{}' -xdev -type f -perm -2000"
    [ "$status" -eq 0 ]
    [[ "$output" == "" ]]
}
