#!/usr/bin/env bats

@test "1.8.1.1 Ensure message of the day is configured properly (Scored)" {
    release=$(grep '^ID=' /etc/os-release | cut -d= -f2 | sed -e 's/"//g')
    run bash -c "grep -E -i -s '(\\\v|\\\r|\\\m|\\\s|$release)' /etc/motd"
    [ "$status" -eq 1 ]
}

@test "1.8.1.2 Ensure local login warning banner is configured properly (Scored)" {
    release=$(grep '^ID=' /etc/os-release | cut -d= -f2 | sed -e 's/"//g')
    run bash -c "grep -E -i -s '(\\\v|\\\r|\\\m|\\\s|$release)' /etc/issue"
    [ "$status" -eq 1 ]
}

@test "1.8.1.3 Ensure remote login warning banner is configured properly (Scored)" {
    release=$(grep '^ID=' /etc/os-release | cut -d= -f2 | sed -e 's/"//g')
    run bash -c "grep -E -i -s '(\\\v|\\\r|\\\m|\\\s|$release)' /etc/issue.net"
    [ "$status" -eq 1 ]
}

@test "1.8.1.4 Ensure permissions on /etc/motd are configured (Scored)" {
    (stat /etc/motd | grep -E "Uid: \([[:space:]]+0/[[:space:]]+root\)")
    (stat /etc/motd | grep -E "Gid: \([[:space:]]+0/[[:space:]]+root\)")
    (stat /etc/motd | grep "Access: (0644/")
}

@test "1.8.1.5 Ensure permissions on /etc/issue are configured (Scored)" {
    (stat /etc/issue | grep -E "Uid: \([[:space:]]+0/[[:space:]]+root\)")
    (stat /etc/issue | grep -E "Gid: \([[:space:]]+0/[[:space:]]+root\)")
    (stat /etc/issue | grep "Access: (0644/")
}

@test "1.8.1.6 Ensure permissions on /etc/issue.net are configured (Scored)" {
    (stat /etc/issue.net | grep -E "Uid: \([[:space:]]+0/[[:space:]]+root\)")
    (stat /etc/issue.net | grep -E "Gid: \([[:space:]]+0/[[:space:]]+root\)")
    (stat /etc/issue.net | grep "Access: (0644/")
}

@test "1.8.2 Ensure GDM login banner is configured (Scored)" {
    if dpkg -s gdm; then
        (grep "^banner-message-enable=true" /etc/gdm3/greeter.dconf-defaults)
        (grep "^banner-message-text=" /etc/gdm3/greeter.dconf-defaults)
    fi
}
