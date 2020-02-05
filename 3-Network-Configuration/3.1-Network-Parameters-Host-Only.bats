#!/usr/bin/env bats

@test "3.1.1 Ensure packet redirect sending is disabled (Scored)" {
    run bash -c "sysctl net.ipv4.conf.all.send_redirects"
    [ "$status" -eq 0 ]
    [ "$output" = "net.ipv4.conf.all.send_redirects = 0" ]
    run bash -c "sysctl net.ipv4.conf.default.send_redirects"
    [ "$status" -eq 0 ]
    [ "$output" = "net.ipv4.conf.default.send_redirects = 0" ]
    run bash -c "grep \"net\.ipv4\.conf\.all\.send_redirects\" /etc/sysctl.conf /etc/sysctl.d/*"
    [ "$status" -eq 0 ]
    while IFS= read -r line; do
        [[ "$line" == *"net.ipv4.conf.all.send_redirects = 0" ]]
        [[ "$line" != *"#net.ipv4.conf.all.send_redirects = 0" ]]
    done <<< "$output"
    run bash -c "grep \"net\.ipv4\.conf\.default\.send_redirects\" /etc/sysctl.conf /etc/sysctl.d/*"
    [ "$status" -eq 0 ]
    while IFS= read -r line; do
        [[ "$line" == *"net.ipv4.conf.default.send_redirects = 0" ]]
        [[ "$line" != *"#net.ipv4.conf.default.send_redirects = 0" ]]
    done <<< "$output"

}

@test "3.1.2 Ensure IP forwarding is disabled (Scored)" {
    run bash -c "sysctl net.ipv4.ip_forward"
    [ "$status" -eq 0 ]
    [ "$output" = "net.ipv4.ip_forward = 0" ]
    run bash -c "grep -E -s \"^\s*net\.ipv4\.ip_forward\s*=\s*1\" /etc/sysctl.conf /etc/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf /run/sysctl.d/*.conf"
    [ "$status" -ne 0 ]
    [ "$output" = "" ]
    run bash -c "sysctl net.ipv6.conf.all.forwarding"
    [ "$status" -eq 0 ]
    [ "$output" = "net.ipv6.conf.all.forwarding = 0" ]
    run bash -c "grep -E -s \"^\s*net\.ipv6\.conf\.all\.forwarding\s*=\s*1\" /etc/sysctl.conf /etc/sysctl.d/*.conf /usr/lib/sysctl.d/*.conf /run/sysctl.d/*.conf"
    [ "$status" -ne 0 ]
    [ "$output" = "" ]
}
