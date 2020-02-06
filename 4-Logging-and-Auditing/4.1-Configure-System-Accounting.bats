#!/usr/bin/env bats

@test "4.1.1.1 Ensure auditd is installed (Scored)" {
    run bash -c "dpkg -s auditd audispd-plugins"
    [ "$status" -eq 0 ]
    [[ "$output" == *"Status: install ok installed"* ]]
}

@test "4.1.1.2 Ensure auditd service is enabled (Scored)" {
    run bash -c "systemctl is-enabled auditd"
    [ "$status" -eq 0 ]
    [ "$output" = "enabled" ]
}

@test "4.1.1.3 Ensure auditing for processes that start prior to auditd is enabled (Scored)" {
    run bash -c "grep \"^\s*linux\" /boot/grub/grub.cfg | grep -v \"audit=1\" | grep -v '/boot/memtest86+.bin'"
    [ "$status" -ne 0 ]
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