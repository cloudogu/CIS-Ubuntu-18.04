#!/usr/bin/env bats

@test "1.7.1.1 Ensure AppArmor is installed (Scored)" {
    run bash -c "dpkg -s apparmor apparmor-utils"
    [ "$status" -eq 0 ]
}

@test "1.7.1.2 Ensure AppArmor is enabled in the bootloader configuration (Scored)" {
    run bash -c "grep \"^\s*linux\" /boot/grub/grub.cfg | grep -v \"apparmor=1\" | grep -v '/boot/memtest86+.bin"
    [ "$status" -eq 1 ]

    run bash -c "grep \"^\s*linux\" /boot/grub/grub.cfg | grep -v \"security=apparmor\" | grep -v '/boot/memtest86+.bin'"
    [ "$status" -eq 1 ]
}

@test "1.7.1.3 Ensure all AppArmor Profiles are in enforce or complain mode (Scored)" {
    run bash -c "apparmor_status | grep profiles | grep '0 profiles are loaded.'"
    [ "$status" -eq 1 ]

    local enforce_mode
    run bash -c "apparmor_status | grep profiles | grep '0 profiles are in enforce mode.'"
    enforce_mode=$?

    local complain_mode
    run bash -c "apparmor_status | grep profiles | grep '0 profiles are in complain mode.'"
    complain_mode=$?

    [ "$enforce_mode" -eq 0 ] || [ "$complain_mode" -eq 0 ]

    run bash -c "apparmor_status | grep processes | grep '0 processes are unconfined'"
    [ "$status" -eq 0 ]
}

@test "1.7.1.4 Ensure all AppArmor Profiles are enforcing (Scored)" {
    run bash -c "apparmor_status | grep '0 profiles are loaded'"
    [ "$status" -eq 1 ]

    run bash -c "apparmor_status | grep profiles | grep '0 profiles are in complain mode.'"
    [ "$status" -eq 0 ]

    run bash -c "apparmor_status | grep processes | grep '0 processes are unconfined'"
    [ "$status" -eq 0 ]
}
