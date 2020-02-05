#!/usr/bin/env bats

@test "3.3.1 Ensure TCP Wrappers is installed (Not Scored)" {
    run bash -c "dpkg -s tcpd"
    [ "$status" -eq 0 ]
}

@test "3.3.2 Ensure /etc/hosts.allow is configured (Not Scored)" {
    skip "This audit has to be done manually"
}

@test "3.3.3 Ensure /etc/hosts.deny is configured (Not Scored)" {
    run bash -c "cat /etc/hosts.deny"
    [ "$status" -eq 0 ]
    [[ "$output" = *"ALL: ALL"* ]]
}

@test "3.3.4 Ensure permissions on /etc/hosts.allow are configured (Scored)" {
    run bash -c "stat /etc/hosts.allow"
    [ "$status" -eq 0 ]
    [[ "$output" = *"Uid:"*"("*"0/"*"root"* ]]
    [[ "$output" = *"Gid:"*"("*"0/"*"root"* ]]
    [[ "$output" = *"Access:"*"(0644"* ]]
}

@test "3.3.5 Ensure permissions on /etc/hosts.deny are configured (Scored)" {
    run bash -c "stat /etc/hosts.deny"
    [ "$status" -eq 0 ]
    [[ "$output" = *"Uid:"*"("*"0/"*"root"* ]]
    [[ "$output" = *"Gid:"*"("*"0/"*"root"* ]]
    [[ "$output" = *"Access:"*"(0644"* ]]
}
