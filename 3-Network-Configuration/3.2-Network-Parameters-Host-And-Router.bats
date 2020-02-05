#!/usr/bin/env bats

@test "3.2.1 Ensure source routed packets are not accepted (Scored)" {
    run bash -c "sysctl net.ipv4.conf.all.accept_source_route"
    [ "$status" -eq 0 ]
    [ "$output" = "net.ipv4.conf.all.accept_source_route = 0" ]
    run bash -c "sysctl net.ipv4.conf.default.accept_source_route"
    [ "$status" -eq 0 ]
    [ "$output" = "net.ipv4.conf.default.accept_source_route = 0" ]
    run bash -c "grep \"net\.ipv4\.conf\.all\.accept_source_route\" /etc/sysctl.conf /etc/sysctl.d/*"
    [ "$status" -eq 0 ]
    # Check if the desired output line is active in any of the conf files
    local CONF_FILE_CORRECT=0
    while IFS= read -r line; do
        if [[ "$line" == *":net.ipv4.conf.all.accept_source_route = 0" ]]; then
            CONF_FILE_CORRECT=1
        fi
    done <<< "$output"
    [ $CONF_FILE_CORRECT -eq 1 ]
    run bash -c "grep "net\.ipv4\.conf\.default\.accept_source_route" /etc/sysctl.conf /etc/sysctl.d/*"
    [ "$status" -eq 0 ]
    # Check if the desired output line is active in any of the conf files
    local CONF_FILE_CORRECT=0
    while IFS= read -r line; do
        if [[ "$line" == *":net.ipv4.conf.default.accept_source_route = 0" ]]; then
            CONF_FILE_CORRECT=1
        fi
    done <<< "$output"
    [ $CONF_FILE_CORRECT -eq 1 ]
    run bash -c "sysctl net.ipv6.conf.all.accept_source_route"
    [ "$status" -eq 0 ]
    [ "$output" = "net.ipv6.conf.all.accept_source_route = 0" ]
    run bash -c "sysctl net.ipv6.conf.default.accept_source_route"
    [ "$status" -eq 0 ]
    [ "$output" = "net.ipv6.conf.default.accept_source_route = 0" ]
    run bash -c "grep \"net\.ipv6\.conf\.all\.accept_source_route\" /etc/sysctl.conf /etc/sysctl.d/*"
    [ "$status" -eq 0 ]
    # Check if the desired output line is active in any of the conf files
    local CONF_FILE_CORRECT=0
    while IFS= read -r line; do
        if [[ "$line" == *":net.ipv6.conf.all.accept_source_route = 0" ]]; then
            CONF_FILE_CORRECT=1
        fi
    done <<< "$output"
    [ $CONF_FILE_CORRECT -eq 1 ]
    run bash -c "grep \"net\.ipv6\.conf\.default\.accept_source_route\" /etc/sysctl.conf /etc/sysctl.d/*"
    [ "$status" -eq 0 ]
    # Check if the desired output line is active in any of the conf files
    local CONF_FILE_CORRECT=0
    while IFS= read -r line; do
        if [[ "$line" == *":net.ipv6.conf.default.accept_source_route = 0" ]]; then
            CONF_FILE_CORRECT=1
        fi
    done <<< "$output"
    [ $CONF_FILE_CORRECT -eq 1 ]
}

@test "3.2.2 Ensure ICMP redirects are not accepted (Scored)" {
    run bash -c "sysctl net.ipv4.conf.all.accept_redirects"
    [ "$status" -eq 0 ]
    [ "$output" = "net.ipv4.conf.all.accept_redirects = 0" ]
    run bash -c "sysctl net.ipv4.conf.default.accept_redirects"
    [ "$status" -eq 0 ]
    [ "$output" = "net.ipv4.conf.default.accept_redirects = 0" ]
    run bash -c "grep \"net\.ipv4\.conf\.all\.accept_redirects\" /etc/sysctl.conf /etc/sysctl.d/*"
    [ "$status" -eq 0 ]
    # Check if the desired output line is active in any of the conf files
    local CONF_FILE_CORRECT=0
    while IFS= read -r line; do
        if [[ "$line" == *":net.ipv4.conf.all.accept_redirects = 0" ]]; then
            CONF_FILE_CORRECT=1
        fi
    done <<< "$output"
    [ $CONF_FILE_CORRECT -eq 1 ]
    run bash -c "grep \"net\.ipv4\.conf\.default\.accept_redirects\" /etc/sysctl.conf /etc/sysctl.d/*"
    [ "$status" -eq 0 ]
    # Check if the desired output line is active in any of the conf files
    local CONF_FILE_CORRECT=0
    while IFS= read -r line; do
        if [[ "$line" == *":net.ipv4.conf.default.accept_redirects = 0" ]]; then
            CONF_FILE_CORRECT=1
        fi
    done <<< "$output"
    [ $CONF_FILE_CORRECT -eq 1 ]
    run bash -c "sysctl net.ipv6.conf.all.accept_redirects"
    [ "$status" -eq 0 ]
    [ "$output" = "net.ipv6.conf.all.accept_redirects = 0" ]
    run bash -c "sysctl net.ipv6.conf.default.accept_redirects"
    [ "$status" -eq 0 ]
    [ "$output" = "net.ipv6.conf.default.accept_redirects = 0" ]
    run bash -c "grep \"net\.ipv6\.conf\.all\.accept_redirects\" /etc/sysctl.conf /etc/sysctl.d/*"
    [ "$status" -eq 0 ]
    # Check if the desired output line is active in any of the conf files
    local CONF_FILE_CORRECT=0
    while IFS= read -r line; do
        if [[ "$line" == *":net.ipv6.conf.all.accept_redirects = 0" ]]; then
            CONF_FILE_CORRECT=1
        fi
    done <<< "$output"
    [ $CONF_FILE_CORRECT -eq 1 ]
    run bash -c "grep \"net\.ipv6\.conf\.default\.accept_redirects\" /etc/sysctl.conf /etc/sysctl.d/*"
    [ "$status" -eq 0 ]
    # Check if the desired output line is active in any of the conf files
    local CONF_FILE_CORRECT=0
    while IFS= read -r line; do
        if [[ "$line" == *":net.ipv6.conf.default.accept_redirects = 0" ]]; then
            CONF_FILE_CORRECT=1
        fi
    done <<< "$output"
    [ $CONF_FILE_CORRECT -eq 1 ]
}

@test "3.2.3 Ensure secure ICMP redirects are not accepted (Scored)" {
    run bash -c "sysctl net.ipv4.conf.all.secure_redirects"
    [ "$status" -eq 0 ]
    [ "$output" = "net.ipv4.conf.all.secure_redirects = 0" ]
    run bash -c "sysctl net.ipv4.conf.default.secure_redirects"
    [ "$status" -eq 0 ]
    [ "$output" = "net.ipv4.conf.default.secure_redirects = 0" ]
    run bash -c "grep \"net\.ipv4\.conf\.all\.secure_redirects\" /etc/sysctl.conf /etc/sysctl.d/*"
    [ "$status" -eq 0 ]
    # Check if the desired output line is active in any of the conf files
    local CONF_FILE_CORRECT=0
    while IFS= read -r line; do
        if [[ "$line" == *":net.ipv4.conf.all.secure_redirects = 0" ]]; then
            CONF_FILE_CORRECT=1
        fi
    done <<< "$output"
    [ $CONF_FILE_CORRECT -eq 1 ]
    run bash -c "grep \"net\.ipv4\.conf\.default\.secure_redirects\" /etc/sysctl.conf /etc/sysctl.d/*"
    [ "$status" -eq 0 ]
    # Check if the desired output line is active in any of the conf files
    local CONF_FILE_CORRECT=0
    while IFS= read -r line; do
        if [[ "$line" == *":net.ipv4.conf.default.secure_redirects = 0" ]]; then
            CONF_FILE_CORRECT=1
        fi
    done <<< "$output"
    [ $CONF_FILE_CORRECT -eq 1 ]
}

@test "3.2.4 Ensure suspicious packets are logged (Scored)" {
    run bash -c "sysctl net.ipv4.conf.all.log_martians"
    [ "$status" -eq 0 ]
    [ "$output" = "net.ipv4.conf.all.log_martians = 1" ]
    run bash -c "sysctl net.ipv4.conf.default.log_martians"
    [ "$status" -eq 0 ]
    [ "$output" = "net.ipv4.conf.default.log_martians = 1" ]
    run bash -c "grep \"net\.ipv4\.conf\.all\.log_martians\" /etc/sysctl.conf /etc/sysctl.d/*"
    [ "$status" -eq 0 ]
    # Check if the desired output line is active in any of the conf files
    local CONF_FILE_CORRECT=0
    while IFS= read -r line; do
        if [[ "$line" == *":net.ipv4.conf.all.log_martians = 1" ]]; then
            CONF_FILE_CORRECT=1
        fi
    done <<< "$output"
    [ $CONF_FILE_CORRECT -eq 1 ]
    run bash -c "grep "net\.ipv4\.conf\.default\.log_martians" /etc/sysctl.conf /etc/sysctl.d/*"
    [ "$status" -eq 0 ]
    # Check if the desired output line is active in any of the conf files
    local CONF_FILE_CORRECT=0
    while IFS= read -r line; do
        if [[ "$line" == *":net.ipv4.conf.default.log_martians = 1" ]]; then
            CONF_FILE_CORRECT=1
        fi
    done <<< "$output"
    [ $CONF_FILE_CORRECT -eq 1 ]
}

@test "3.2.5 Ensure broadcast ICMP requests are ignored (Scored)" {
    run bash -c "sysctl net.ipv4.icmp_echo_ignore_broadcasts"
    [ "$status" -eq 0 ]
    [ "$output" = "net.ipv4.icmp_echo_ignore_broadcasts = 1" ]
    run bash -c "grep \"net\.ipv4\.icmp_echo_ignore_broadcasts\" /etc/sysctl.conf /etc/sysctl.d/*"
    [ "$status" -eq 0 ]
    # Check if the desired output line is active in any of the conf files
    local CONF_FILE_CORRECT=0
    while IFS= read -r line; do
        if [[ "$line" == *":net.ipv4.icmp_echo_ignore_broadcasts = 1" ]]; then
            CONF_FILE_CORRECT=1
        fi
    done <<< "$output"
    [ $CONF_FILE_CORRECT -eq 1 ]
}

@test "3.2.6 Ensure bogus ICMP responses are ignored (Scored)" {
    run bash -c "sysctl net.ipv4.icmp_ignore_bogus_error_responses"
    [ "$status" -eq 0 ]
    [ "$output" = "net.ipv4.icmp_ignore_bogus_error_responses = 1" ]
    run bash -c "grep "net.ipv4.icmp_ignore_bogus_error_responses" /etc/sysctl.conf /etc/sysctl.d/*"
    [ "$status" -eq 0 ]
    # Check if the desired output line is active in any of the conf files
    local CONF_FILE_CORRECT=0
    while IFS= read -r line; do
        if [[ "$line" == *":net.ipv4.icmp_ignore_bogus_error_responses = 1" ]]; then
            CONF_FILE_CORRECT=1
        fi
    done <<< "$output"
    [ $CONF_FILE_CORRECT -eq 1 ]
}

@test "3.2.7 Ensure Reverse Path Filtering is enabled (Scored)" {
    run bash -c "sysctl net.ipv4.conf.all.rp_filter"
    [ "$status" -eq 0 ]
    [ "$output" = "net.ipv4.conf.all.rp_filter = 1" ]
    run bash -c "sysctl net.ipv4.conf.default.rp_filter"
    [ "$status" -eq 0 ]
    [ "$output" = "net.ipv4.conf.default.rp_filter = 1" ]
    run bash -c "grep \"net\.ipv4\.conf\.all\.rp_filter\" /etc/sysctl.conf /etc/sysctl.d/*"
    [ "$status" -eq 0 ]
    # Check if the desired output line is active in any of the conf files
    local CONF_FILE_CORRECT=0
    while IFS= read -r line; do
        if [[ "$line" == *":net.ipv4.conf.all.rp_filter = 1" ]]; then
            CONF_FILE_CORRECT=1
        fi
    done <<< "$output"
    [ $CONF_FILE_CORRECT -eq 1 ]
    run bash -c "grep \"net\.ipv4\.conf\.default\.rp_filter\" /etc/sysctl.conf /etc/sysctl.d/*"
    [ "$status" -eq 0 ]
    # Check if the desired output line is active in any of the conf files
    local CONF_FILE_CORRECT=0
    while IFS= read -r line; do
        if [[ "$line" == *":net.ipv4.conf.default.rp_filter = 1" ]]; then
            CONF_FILE_CORRECT=1
        fi
    done <<< "$output"
    [ $CONF_FILE_CORRECT -eq 1 ]
}

@test "3.2.8 Ensure TCP SYN Cookies is enabled (Scored)" {
    run bash -c "sysctl net.ipv4.tcp_syncookies"
    [ "$status" -eq 0 ]
    [ "$output" = "net.ipv4.tcp_syncookies = 1" ]
    run bash -c "grep \"net\.ipv4\.tcp_syncookies\" /etc/sysctl.conf /etc/sysctl.d/*"
    [ "$status" -eq 0 ]
    # Check if the desired output line is active in any of the conf files
    local CONF_FILE_CORRECT=0
    while IFS= read -r line; do
        if [[ "$line" == *":net.ipv4.tcp_syncookies = 1" ]]; then
            CONF_FILE_CORRECT=1
        fi
    done <<< "$output"
    [ $CONF_FILE_CORRECT -eq 1 ]
}

@test "3.2.9 Ensure IPv6 router advertisements are not accepted (Scored)" {
    run bash -c "sysctl net.ipv6.conf.all.accept_ra"
    [ "$status" -eq 0 ]
    [ "$output" = "net.ipv6.conf.all.accept_ra = 0" ]
    run bash -c "sysctl net.ipv6.conf.default.accept_ra"
    [ "$status" -eq 0 ]
    [ "$output" = "net.ipv6.conf.default.accept_ra = 0" ]
    run bash -c "grep \"net\.ipv6\.conf\.all\.accept_ra\" /etc/sysctl.conf /etc/sysctl.d/*"
    [ "$status" -eq 0 ]
    # Check if the desired output line is active in any of the conf files
    local CONF_FILE_CORRECT=0
    while IFS= read -r line; do
        if [[ "$line" == *":net.ipv6.conf.all.accept_ra = 0" ]]; then
            CONF_FILE_CORRECT=1
        fi
    done <<< "$output"
    [ $CONF_FILE_CORRECT -eq 1 ]
    run bash -c "grep \"net\.ipv6\.conf\.default\.accept_ra\" /etc/sysctl.conf /etc/sysctl.d/*"
    [ "$status" -eq 0 ]
    # Check if the desired output line is active in any of the conf files
    local CONF_FILE_CORRECT=0
    while IFS= read -r line; do
        if [[ "$line" == *":net.ipv6.conf.default.accept_ra = 0" ]]; then
            CONF_FILE_CORRECT=1
        fi
    done <<< "$output"
    [ $CONF_FILE_CORRECT -eq 1 ]
}
