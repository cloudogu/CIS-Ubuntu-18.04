#!/usr/bin/env bats

@test "1.5.1 Ensure permissions on bootloader config are configured (Scored)" {
    run bash -c "stat /boot/grub/grub.cfg | grep '^Access: (0400'"
    [ "$status" -eq 0 ]
}

@test "1.5.2 Ensure bootloader password is set (Scored)" {
    local superusers
    superusers=$(grep '^set superusers' /boot/grub/grub.cfg)

    local password
    password=$(grep "^password" /boot/grub/grub.cfg)

    [ "$superusers" ] && [ "$password" ]
}

@test "1.5.3 Ensure authentication required for single user mode (Scored)" {
    run bash -c "grep ^root:[*\!]: /etc/shadow"
    [ "$status" != 0 ]
}

@test "1.5.4 Ensure interactive boot is not enabled (Not Scored)" {
    if [ -f /etc/sysconfig/boot ]; then
        run bash -c "grep '^PROMPT_FOR_CONFIRM=' /etc/sysconfig/boot"
        [[ "$output" == "PROMPT_FOR_CONFIRM=\"no\"" ]]
    fi
}
