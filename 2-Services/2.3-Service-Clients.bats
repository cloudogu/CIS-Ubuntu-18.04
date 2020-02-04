#!/usr/bin/env bats

@test "2.3.1 Ensure NIS Client is not installed (Scored)" {
    run bash -c "dpkg -s nis"
    [ "$status" -eq 1 ]
    [[ "$output" == *"is not installed"* ]]
}

@test "2.3.2 Ensure rsh client is not installed (Scored)" {
    run bash -c "dpkg -s rsh-client"
    [ "$status" -eq 1 ]
    [[ "$output" == *"is not installed"* ]]
}

@test "2.3.3 Ensure talk client is not installed (Scored)" {
    run bash -c "dpkg -s talk"
    [ "$status" -eq 1 ]
    [[ "$output" == *"is not installed"* ]]
}

@test "2.3.4 Ensure telnet client is not installed (Scored)" {
    run bash -c "dpkg -s telnet"
    [ "$status" -eq 1 ]
    [[ "$output" == *"is not installed"* ]]
}

@test "2.3.5 Ensure LDAP client is not installed (Scored)" {
    run bash -c "dpkg -s ldap-utils"
    [ "$status" -eq 1 ]
    [[ "$output" == *"is not installed"* ]]
}
