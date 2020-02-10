#!/usr/bin/env bats

@test "5.1.1 Ensure cron daemon is enabled (Scored)" {
    run bash -c "systemctl is-enabled cron"
    [ "$status" -eq 0 ]
    [[ "$output" == "enabled" ]]
}

@test "5.1.2 Ensure permissions on /etc/crontab are configured (Scored)" {
    run bash -c "stat /etc/crontab"
    [ "$status" -eq 0 ]
    [[ "$output" = *"Uid:"*"("*"0/"*"root"* ]]
    [[ "$output" = *"Gid:"*"("*"0/"*"root"* ]]
    [[ "$output" = *"Access:"*"(0"[0-7]"00"* ]]
}

@test "5.1.3 Ensure permissions on /etc/cron.hourly are configured (Scored)" {
    run bash -c "stat /etc/cron.hourly"
    [ "$status" -eq 0 ]
    [[ "$output" = *"Uid:"*"("*"0/"*"root"* ]]
    [[ "$output" = *"Gid:"*"("*"0/"*"root"* ]]
    [[ "$output" = *"Access:"*"(0"[0-7]"00"* ]]
}

@test "5.1.4 Ensure permissions on /etc/cron.daily are configured (Scored)" {
    run bash -c "stat /etc/cron.daily"
    [ "$status" -eq 0 ]
    [[ "$output" = *"Uid:"*"("*"0/"*"root"* ]]
    [[ "$output" = *"Gid:"*"("*"0/"*"root"* ]]
    [[ "$output" = *"Access:"*"(0"[0-7]"00"* ]]
}

@test "5.1.5 Ensure permissions on /etc/cron.weekly are configured (Scored)" {
    run bash -c "stat /etc/cron.weekly"
    [ "$status" -eq 0 ]
    [[ "$output" = *"Uid:"*"("*"0/"*"root"* ]]
    [[ "$output" = *"Gid:"*"("*"0/"*"root"* ]]
    [[ "$output" = *"Access:"*"(0"[0-7]"00"* ]]
}

@test "5.1.6 Ensure permissions on /etc/cron.monthly are configured (Scored)" {
    run bash -c "stat /etc/cron.monthly"
    [ "$status" -eq 0 ]
    [[ "$output" = *"Uid:"*"("*"0/"*"root"* ]]
    [[ "$output" = *"Gid:"*"("*"0/"*"root"* ]]
    [[ "$output" = *"Access:"*"(0"[0-7]"00"* ]]
}

@test "5.1.7 Ensure permissions on /etc/cron.d are configured (Scored)" {
    run bash -c "stat /etc/cron.d"
    [ "$status" -eq 0 ]
    [[ "$output" = *"Uid:"*"("*"0/"*"root"* ]]
    [[ "$output" = *"Gid:"*"("*"0/"*"root"* ]]
    [[ "$output" = *"Access:"*"(0"[0-7]"00"* ]]
}

@test "5.1.8 Ensure at/cron is restricted to authorized users (Scored)" {
    run bash -c "stat /etc/cron.deny"
    [ "$status" -ne 0 ]
    run bash -c "stat /etc/at.deny"
    [ "$status" -ne 0 ]
    run bash -c "stat /etc/cron.allow"
    [ "$status" -eq 0 ]
    [[ "$output" = *"Uid:"*"("*"0/"*"root"* ]]
    [[ "$output" = *"Gid:"*"("*"0/"*"root"* ]]
    [[ "$output" = *"Access:"*"(0"[0-7][0\|4]"0"* ]]
    run bash -c "stat /etc/at.allow"
    [ "$status" -eq 0 ]
    [[ "$output" = *"Uid:"*"("*"0/"*"root"* ]]
    [[ "$output" = *"Gid:"*"("*"0/"*"root"* ]]
    [[ "$output" = *"Access:"*"(0"[0-7][0\|4]"0"* ]]
}