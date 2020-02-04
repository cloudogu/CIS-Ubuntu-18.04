#!/usr/bin/env bats

@test "2.2.1.1 Ensure time synchronization is in use (Scored)" {
    run bash -c "systemctl is-enabled systemd-timesyncd || dpkg -s chrony || dpkg -s ntp"
    [ "$status" -eq 0 ]
}

@test "2.2.1.2 Ensure systemd-timesyncd is configured (Not Scored)" {
    skip "This audit has to be done manually"
}

@test "2.2.1.3 Ensure chrony is configured (Scored)" {
    run bash -c "grep -E \"^(server|pool)\" /etc/chrony/chrony.conf"
    [ "$status" -eq 0 ]
    [[ "$output" == "server "* ]] || [[ "$output" == "pool "* ]]
    run bash -c "ps -ef | grep chronyd"
    [ "$status" -eq 0 ]
    [[ "$output" == "chrony "*" /usr/sbin/chronyd"* ]]
}

@test "2.2.1.4 Ensure ntp is configured (Scored)" {
    run bash -c "grep "^restrict" /etc/ntp.conf"
    [ "$status" -eq 0 ]
    [[ "$output" == *"restrict -4 default "*"kod"* ]]
    [[ "$output" == *"restrict -4 default "*"nomodify"* ]]
    [[ "$output" == *"restrict -4 default "*"notrap"* ]]
    [[ "$output" == *"restrict -4 default "*"nopeer"* ]]
    [[ "$output" == *"restrict -4 default "*"noquery"* ]]
    [[ "$output" == *"restrict -6 default "*"kod"* ]]
    [[ "$output" == *"restrict -6 default "*"nomodify"* ]]
    [[ "$output" == *"restrict -6 default "*"notrap"* ]]
    [[ "$output" == *"restrict -6 default "*"nopeer"* ]]
    [[ "$output" == *"restrict -6 default "*"noquery"* ]]
    # 2.2.1.4 may fail due to "-4" or "-6" not being present in conf file
    run bash -c "grep -E \"^(server|pool)\" /etc/ntp.conf"
    [ "$status" -eq 0 ]
    [[ "$output" == "server "* ]] || [[ "$output" == "pool "* ]]
    run bash -c "grep "RUNASUSER=ntp" /etc/init.d/ntp"
    [ "$status" -eq 0 ]
    [ "$output" = "RUNASUSER=ntp" ]
}

@test "2.2.2 Ensure X Window System is not installed (Scored)" {
    run bash -c "dpkg -l xserver-xorg*"
    [ "$status" -eq 1 ]
    [[ "$output" == *"no packages found matching xserver-xorg*" ]]
}

@test "2.2.3 Ensure Avahi Server is not enabled (Scored)" {
    run bash -c "systemctl is-enabled avahi-daemon"
    if [ "$status" -eq 0 ]; then
        [[ "$output" != "enabled" ]]
    fi
}

@test "2.2.4 Ensure CUPS is not enabled (Scored)" {
    run bash -c "systemctl is-enabled cups"
    if [ "$status" -eq 0 ]; then
        [[ "$output" != "enabled" ]]
    fi
}

@test "2.2.5 Ensure DHCP Server is not enabled (Scored)" {
    run bash -c "systemctl is-enabled isc-dhcp-server"
    if [ "$status" -eq 0 ]; then
        [[ "$output" != "enabled" ]]
    fi
    run bash -c "systemctl is-enabled isc-dhcp-server6"
    if [ "$status" -eq 0 ]; then
        [[ "$output" != "enabled" ]]
    fi
}

@test "2.2.6 Ensure LDAP server is not enabled (Scored)" {
    run bash -c "systemctl is-enabled slapd"
    if [ "$status" -eq 0 ]; then
        [[ "$output" != *"enabled"* ]]
    fi
}

@test "2.2.7 Ensure NFS and RPC are not enabled (Scored)" {
    run bash -c "systemctl is-enabled nfs-server"
    if [ "$status" -eq 0 ]; then
        [[ "$output" != "enabled" ]]
    fi
    run bash -c "systemctl is-enabled rpcbind"
    if [ "$status" -eq 0 ]; then
        [[ "$output" != "enabled" ]]
    fi
}

@test "2.2.8 Ensure DNS Server is not enabled (Scored)" {
    run bash -c "systemctl is-enabled bind9"
    if [ "$status" -eq 0 ]; then
        [[ "$output" != "enabled" ]]
    fi
}

@test "2.2.9 Ensure FTP Server is not enabled (Scored)" {
    run bash -c "systemctl is-enabled vsftpd"
    if [ "$status" -eq 0 ]; then
        [[ "$output" != "enabled" ]]
    fi
}

@test "2.2.10 Ensure HTTP server is not enabled (Scored)" {
    run bash -c "systemctl is-enabled apache2"
    if [ "$status" -eq 0 ]; then
        [[ "$output" != "enabled" ]]
    fi
}

@test "2.2.11 Ensure email services are not enabled (Scored)" {
    run bash -c "systemctl is-enabled dovecot"
    if [ "$status" -eq 0 ]; then
        [[ "$output" != "enabled" ]]
    fi
}

@test "2.2.12 Ensure Samba is not enabled (Scored)" {
    run bash -c "systemctl is-enabled smbd"
    if [ "$status" -eq 0 ]; then
        [[ "$output" != "enabled" ]]
    fi
}

@test "2.2.13 Ensure HTTP Proxy Server is not enabled (Scored)" {
    run bash -c "systemctl is-enabled squid"
    if [ "$status" -eq 0 ]; then
        [[ "$output" != *"enabled"* ]]
    fi
}

@test "2.2.14 Ensure SNMP Server is not enabled (Scored)" {
    run bash -c "systemctl is-enabled snmpd"
    if [ "$status" -eq 0 ]; then
        [[ "$output" != "enabled" ]]
    fi
}

@test "2.2.15 Ensure mail transfer agent is configured for local-only mode (Scored)" {
    run bash -c "ss -lntu | grep -E ':25\s' | grep -E -v '\s(127.0.0.1|::1):25\s'"
    if [ "$status" -eq 0 ]; then
        [[ "$output" == "" ]]
    fi
}

@test "2.2.16 Ensure rsync service is not enabled (Scored)" {
    run bash -c "systemctl is-enabled rsync"
    if [ "$status" -eq 0 ]; then
        [[ "$output" != "enabled" ]]
    fi
}

@test "2.2.17 Ensure NIS Server is not enabled (Scored)" {
    run bash -c "systemctl is-enabled nis"
    if [ "$status" -eq 0 ]; then
        [[ "$output" != *"enabled"* ]]
    fi
}
