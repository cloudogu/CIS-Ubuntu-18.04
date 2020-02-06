#!/usr/bin/env bats

@test "1.6.1 Ensure XD/NX support is enabled (Scored)" {
    run bash -c "journalctl | grep 'protection: active'"
    [ "$status" -eq 0 ]
}

@test "1.6.2 Ensure address space layout randomization (ASLR) is enabled (Scored)" {
    run bash -c "sysctl kernel.randomize_va_space"

    [[ "$output" == "kernel.randomize_va_space = 2" ]]
}

@test "1.6.3 Ensure prelink is disabled (Scored)" {
    run bash -c "dpkg -s prelink"
    [ "$status" -eq 1 ]
}

@test "
" {
    local subfile_is_hard_core
    local limitsconf_is_hard_core

    if [ "$(find /etc/security/limits.d/* -prune -empty 2>/dev/null)" ]; then
        run bash -c "grep 'hard core' /etc/security/limits.d/*"
        [ "$output" == "* hard core 0" ]
        subfile_is_hard_core=$?
    fi

    run bash -c "grep 'hard core' /etc/security/limits.conf"
    [ "$output" == "* hard core 0" ]
    limitsconf_is_hard_core=$?

    [ "$subfile_is_hard_core" == "0" ] || [ "$limitsconf_is_hard_core" == "0" ]

    run bash -c "sysctl fs.suid_dumpable"
    [ "$output" == "fs.suid_dumpable = 0" ]

    local subfile_is_dumpable
    local sysctlconf_is_dumpable
    if [ "$(find /etc/sysctl.d/* -prune -empty 2>/dev/null)" ]; then
        run bash -c "grep \"fs\.suid_dumpable\" /etc/sysctl.d/*"
        [ "$output" == "fs.suid_dumpable = 0" ]
        subfile_is_dumpable=$?
    fi

    run bash -c "grep \"fs\.suid_dumpable\" /etc/sysctl.conf"
    [ "$output" == "fs.suid_dumpable = 0" ]
    sysctlconf_is_dumpable=$?

    [ "$subfile_is_dumpable" == "0" ] || [ "$sysctlconf_is_dumpable" == "0" ]

    run bash -c "systemctl is-enabled coredump.service"
    [ "$status" -eq 1 ]
}
