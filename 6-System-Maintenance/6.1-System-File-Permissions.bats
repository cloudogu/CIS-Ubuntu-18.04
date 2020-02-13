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
    run bash -c "df --local -P | awk '{if (NR!=1) print \$6}' | xargs -I '{}' find '{}' -xdev -type f -perm -4000 \\
        | grep -v /bin/ping \\
        | grep -v /bin/su \\
        | grep -v /bin/fusermount \\
        | grep -v /bin/mount \\
        | grep -v /bin/umount \\
        | grep -v /usr/bin/chfn \\
        | grep -v /usr/bin/chsh \\
        | grep -v /usr/bin/gpasswd \\
        | grep -v /usr/bin/newgrp \\
        | grep -v /usr/bin/passwd \\
        | grep -v /usr/bin/traceroute6.iputils \\
        | grep -v /usr/bin/at \\
        | grep -v /usr/bin/newgidmap \\
        | grep -v /usr/bin/newuidmap \\
        | grep -v /usr/bin/pkexec \\
        | grep -v /usr/bin/sudo \\
        | grep -v /usr/lib/dbus-1.0/dbus-daemon-launch-helper \\
        | grep -v /usr/lib/eject/dmcrypt-get-device \\
        | grep -v /usr/lib/x86_64-linux-gnu/lxc/lxc-user-nic \\
        | grep -v /usr/lib/openssh/ssh-keysign \\
        | grep -v /usr/lib/policykit-1/polkit-agent-helper-1 \\
        | grep -v /usr/lib/snapd/snap-confine"
    # grep -v returns 1 when the last remaining line is removed
    # the binaries mentioned above are whitelisted
    # so, when all lines are removed an not output is generated, everything is okay
    [ "$status" -eq 1 ]
    [[ "$output" == "" ]]
}

@test "6.1.14 Audit SGID executables (Not Scored)" {
    run bash -c "df --local -P | awk '{if (NR!=1) print \$6}' | xargs -I '{}' find '{}' -xdev -type f -perm -2000 \\
        | grep -v /sbin/pam_extrausers_chkpwd \\
        | grep -v /sbin/unix_chkpwd \\
        | grep -v /usr/bin/chage \\
        | grep -v /usr/bin/crontab \\
        | grep -v /usr/bin/expiry \\
        | grep -v /usr/bin/bsd-write \\
        | grep -v /usr/bin/mlocate \\
        | grep -v /usr/bin/ssh-agent \\
        | grep -v /usr/bin/at \\
        | grep -v /usr/bin/wall \\
        | grep -v /usr/lib/x86_64-linux-gnu/utempter/utempter \\
        | grep -v /usr/lib/snapd/snap-confine"
    # grep -v returns 1 when the last remaining line is removed
    # the binaries mentioned above are whitelisted
    # so, when all lines are removed an not output is generated, everything is okay
    [ "$status" -eq 1 ]
    [[ "$output" == "" ]]
}
