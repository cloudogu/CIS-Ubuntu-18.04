#!/usr/bin/env bats

@test "6.1.1 Audit system file permissions (Not Scored)" {
    local packages
    packages=$(dpkg --get-selections | grep install | awk '{split($0, a, "\t"); split(a[1], b, ":"); print b[1]}')

    if [ -z ${SKIP_LONG_RUNNING+x} ]; then
        for package in $packages; do
            (dpkg --verify "$package")
        done
    else
        skip "long running tests deactivated"
    fi
}

@test "6.1.2 Ensure permissions on /etc/passwd are configured (Scored)" {
    (stat /etc/passwd | grep -E "Uid: \([[:space:]]+0/[[:space:]]+root\)")
    (stat /etc/passwd | grep -E "Gid: \([[:space:]]+0/[[:space:]]+root\)")
    (stat /etc/passwd | grep "Access: (0644/")
}

@test "6.1.3 Ensure permissions on /etc/gshadow- are configured (Scored)" {
    (stat /etc/gshadow- | grep -E "Uid: \([[:space:]]+0/[[:space:]]+root\)")
    (stat /etc/gshadow- | grep -E "Gid: \([[:space:]]+0/[[:space:]]+shadow\)")
    (stat /etc/gshadow- | grep "Access: (0640/")
}

@test "6.1.4 Ensure permissions on /etc/shadow are configured (Scored)" {
    (stat /etc/shadow | grep -E "Uid: \([[:space:]]+0/[[:space:]]+root\)")
    (stat /etc/shadow | grep -E "Gid: \([[:space:]]+42/[[:space:]]+shadow\)")
    (stat /etc/shadow | grep "Access: (0640/")
}

@test "6.1.5 Ensure permissions on /etc/group are configured (Scored)" {
    (stat /etc/group | grep -E "Uid: \([[:space:]]+0/[[:space:]]+root\)")
    (stat /etc/group | grep -E "Gid: \([[:space:]]+0/[[:space:]]+root\)")
    (stat /etc/group | grep "Access: (0644/")
}

@test "6.1.6 Ensure permissions on /etc/passwd- are configured (Scored)" {
    (stat /etc/passwd- | grep -E "Uid: \([[:space:]]+0/[[:space:]]+root\)")
    (stat /etc/passwd- | grep -E "Gid: \([[:space:]]+0/[[:space:]]+root\)")
    (stat /etc/passwd- | grep "Access: (0600/")
}

@test "6.1.7 Ensure permissions on /etc/shadow- are configured (Scored)" {
    (stat /etc/shadow- | grep -E "Uid: \([[:space:]]+0/[[:space:]]+root\)")
    (stat /etc/shadow- | grep -E "Gid: \([[:space:]]+42/[[:space:]]+shadow\)")
    (stat /etc/shadow- | grep "Access: (0600/")
}

@test "6.1.8 Ensure permissions on /etc/group- are configured (Scored)" {
    (stat /etc/group- | grep -E "Uid: \([[:space:]]+0/[[:space:]]+root\)")
    (stat /etc/group- | grep -E "Gid: \([[:space:]]+0/[[:space:]]+root\)")
    (stat /etc/group- | grep "Access: (0644/")
}

@test "6.1.9 Ensure permissions on /etc/gshadow are configured (Scored)" {
    (stat /etc/gshadow | grep -E "Uid: \([[:space:]]+0/[[:space:]]+root\)")
    (stat /etc/gshadow | grep -E "Gid: \([[:space:]]+42/[[:space:]]+shadow\)")
    (stat /etc/gshadow | grep "Access: (0640/")
}
