#!/usr/bin/env bats

@test "3.5.1.1 Ensure a Firewall package is installed (Scored)" {
    [[ $(dpkg -s ufw | grep -i status) || $(dpkg -s nftables | grep -i status) || $(dpkg -s iptables | grep -i status) ]]
}

@test "3.5.2.1 Ensure ufw service is enabled (Scored)" {
    run bash -c "systemctl is-enabled ufw"
    [ "$status" -eq 0 ]
    [ "$output" = "enabled" ]
}

@test "3.5.2.2 Ensure default deny firewall policy (Scored)" {
    run bash -c "ufw status verbose | grep -i default"
    [ "$status" -eq 0 ]
    [[ "$output" == *"deny (incoming)"* || "$output" == *"reject (incoming)"* ]]
    [[ "$output" == *"deny (outgoing)"* || "$output" == *"reject (outgoing)"* ]]
    [[ "$output" == *"deny (routed)"* || "$output" == *"reject (routed)"* ]]
}

@test "3.5.2.3 Ensure loopback traffic is configured (Scored)" {
    run bash -c "ufw status verbose"
    [ "$status" -eq 0 ]
    [[ "$output" == *"Anywhere on lo"*"ALLOW IN"*"Anywhere"* ]]
    [[ "$output" == *"Anywhere"*"DENY IN"*"127.0.0.0/8"* ]]
    [[ "$output" == *"Anywhere (v6) on lo"*"ALLOW IN"*"Anywhere (v6)"* ]]
    [[ "$output" == *"Anywhere (v6)"*"DENY IN"*"::1"* ]]
    [[ "$output" == *"Anywhere"*"ALLOW OUT"*"Anywhere on lo"* ]]
    [[ "$output" == *"Anywhere (v6)"*"ALLOW OUT"*"Anywhere (v6) on lo"* ]]
}

@test "3.5.2.4 Ensure outbound connections are configured (Not Scored)" {
    skip "This audit has to be done manually"
}

@test "3.5.2.5 Ensure firewall rules exist for all open ports (Not Scored)" {
    skip "This audit has to be done manually"
}

@test "3.5.3.1 Ensure iptables are flushed (Not Scored)" {
    run bash -c "iptables -L"
    [ "$status" -eq 0 ]
    [ "$output" = "" ]
    run bash -c "ip6tables -L"
    [ "$status" -eq 0 ]
    [ "$output" = "" ]
}

@test "3.5.3.2 Ensure a table exists (Scored)" {
    run bash -c "nft list tables"
    [ "$status" -eq 0 ]
}

@test "3.5.3.3 Ensure base chains exist (Scored)" {
    run bash -c "nft list ruleset | grep 'hook input'"
    [ "$status" -eq 0 ]
    [[ "$output" == *"type filter hook input priority 0;"* ]]
    run bash -c "nft list ruleset | grep 'hook forward'"
    [ "$status" -eq 0 ]
    [[ "$output" == *"type filter hook forward priority 0;"* ]]
    run bash -c "nft list ruleset | grep 'hook output'"
    [ "$status" -eq 0 ]
    [[ "$output" == *"type filter hook output priority 0;"* ]]
}

@test "3.5.3.4 Ensure loopback traffic is configured (Scored)" {
    run bash -c "nft list ruleset | awk '/hook input/,/}/' | grep 'iif \"lo\" accept'"
    [ "$status" -eq 0 ]
    [[ "$output" == *"iif \"lo\" accept"* ]]
    run bash -c "nft list ruleset | awk '/hook input/,/}/' | grep 'ip saddr'"
    [ "$status" -eq 0 ]
    [[ "$output" == *"ip saddr 127.0.0.0/8 counter packets 0 bytes 0 drop"* ]]
    run bash -c "nft list ruleset | awk '/hook input/,/}/' | grep 'ip6 saddr'"
    [ "$status" -eq 0 ]
    [[ "$output" == *"ip6 saddr ::1 counter packets 0 bytes 0 drop"* ]]
}

@test "3.5.3.5 Ensure outbound and established connections are configured (Not Scored)" {
    run bash -c "nft list ruleset | awk '/hook input/,/}/' | grep -E 'ip protocol (tcp|udp|icmp) ct state'"
    [ "$status" -eq 0 ]
    [[ "$output" == *"ip protocol tcp ct state established accept"* ]]
    [[ "$output" == *"ip protocol udp ct state established accept"* ]]
    [[ "$output" == *"ip protocol icmp ct state established accept"* ]]
    run bash -c "nft list ruleset | awk '/hook output/,/}/' | grep -E 'ip protocol (tcp|udp|icmp) ct state'"
    [ "$status" -eq 0 ]
    [[ "$output" == *"ip protocol tcp ct state established,related,new accept"* ]]
    [[ "$output" == *"ip protocol udp ct state established,related,new accept"* ]]
    [[ "$output" == *"ip protocol icmp ct state established,related,new accept"* ]]
}

@test "3.5.3.6 Ensure default deny firewall policy (Scored)" {
    run bash -c "nft list ruleset | grep 'hook input'"
    [ "$status" -eq 0 ]
    [[ "$output" == *"type filter hook input priority 0; policy drop;"* ]]
    run bash -c "nft list ruleset | grep 'hook forward'"
    [ "$status" -eq 0 ]
    [[ "$output" == *"type filter hook forward priority 0; policy drop;"* ]]
    run bash -c "nft list ruleset | grep 'hook output'"
    [ "$status" -eq 0 ]
    [[ "$output" == *"type filter hook output priority 0; policy drop;"* ]]
}

@test "3.5.3.7 Ensure nftables service is enabled (Scored)" {
    run bash -c "systemctl is-enabled nftables"
    [ "$status" -eq 0 ]
    [ "$output" = "enabled" ]
}

@test "3.5.3.8 Ensure nftables rules are permanent (Scored)" {
    skip "This audit has to be done manually"
}

@test "3.5.4.1.1 Ensure default deny firewall policy (Scored)" {
    run bash -c "iptables -L"
    [ "$status" -eq 0 ]
    [[ "$output" == *"Chain INPUT (policy DROP)"* || "$output" == *"Chain INPUT (policy REJECT)"* ]]
    [[ "$output" == *"Chain FORWARD (policy DROP)"* || "$output" == *"Chain FORWARD (policy REJECT)"* ]]
    [[ "$output" == *"Chain OUTPUT (policy DROP)"* || "$output" == *"Chain OUTPUT (policy REJECT)"* ]]
}

@test "" {
    run bash -c ""
    [ "$status" -eq 0 ]
    [ "$output" = "" ]
}

@test "" {
    run bash -c ""
    [ "$status" -eq 0 ]
    [ "$output" = "" ]
}

@test "" {
    run bash -c ""
    [ "$status" -eq 0 ]
    [ "$output" = "" ]
}

@test "" {
    run bash -c ""
    [ "$status" -eq 0 ]
    [ "$output" = "" ]
}

@test "" {
    run bash -c ""
    [ "$status" -eq 0 ]
    [ "$output" = "" ]
}

@test "" {
    run bash -c ""
    [ "$status" -eq 0 ]
    [ "$output" = "" ]
}

@test "" {
    run bash -c ""
    [ "$status" -eq 0 ]
    [ "$output" = "" ]
}

@test "" {
    run bash -c ""
    [ "$status" -eq 0 ]
    [ "$output" = "" ]
}

@test "" {
    run bash -c ""
    [ "$status" -eq 0 ]
    [ "$output" = "" ]
}
