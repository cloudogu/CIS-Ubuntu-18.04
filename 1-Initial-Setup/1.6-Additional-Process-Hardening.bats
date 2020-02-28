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

@test "1.6.4 Ensure core dumps are restricted (Scored)" {
    run bash -c "grep 'hard core' /etc/security/limits.conf /etc/security/limits.d/*"
    [[ "$output" == *"* hard core 0" ]]

    run bash -c "sysctl fs.suid_dumpable"
    [ "$output" == "fs.suid_dumpable = 0" ]

    run bash -c "grep \"fs\.suid_dumpable\" /etc/sysctl.conf /etc/sysctl.d/*"
    [[ "$output" == *"fs.suid_dumpable = 0" ]]

    run bash -c "systemctl is-enabled coredump.service"
    [ "$status" -eq 1 ]
}
