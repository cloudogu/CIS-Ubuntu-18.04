#!/usr/bin/env bats

@test "2.1.1 Ensure xinetd is not installed (Scored)" {
    run bash -c "dpkg -s xinetd"
    [ "$status" -eq 1 ]
    [[ "$output" == *"package 'xinetd' is not installed and no information is available"* ]]
}

@test "2.1.2 Ensure openbsd-inetd is not installed (Scored)" {
    run bash -c "dpkg -s openbsd-inetd"
    [ "$status" -eq 1 ]
    [[ "$output" == *"package 'openbsd-inetd' is not installed and no information is available"* ]]
}
