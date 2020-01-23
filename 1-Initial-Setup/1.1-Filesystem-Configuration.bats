#!/usr/bin/env bats

@test "1.1.1.1 Ensure mounting of cramfs filesystems is disabled (Scored)" {
    run bash -c "modprobe -n -v cramfs | grep -v mtd"
    [ "$status" -eq 0 ]
    [ "$output" = "install /bin/true" ]
    run bash -c "lsmod | grep cramfs"
    [ "$status" -eq 1 ]
    [ "$output" = "" ]
}

@test "1.1.10 Ensure noexec option set on /var/tmp partition (Scored)" {
    run bash -c "mount | grep -E '\s/var/tmp\s' | grep -v noexec"
    [ "$status" -eq 1 ]
    [ "$output" = "" ]
}