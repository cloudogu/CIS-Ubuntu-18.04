#!/usr/bin/env bats

@test "1.3.1 Ensure sudo is installed (Scored)" {
    run bash -c "dpkg -s sudo"
    [ "$status" -eq 0 ] || bash -c "dpkg -s sudo-ldap"
}

@test "1.3.2 Ensure sudo commands use pty (Scored)" {
    run bash -c "grep -Ei '^\s*Defaults\s+([^#]+,\s*)?use_pty(,\s+\S+\s*)*(\s+#.*)?$' /etc/sudoers /etc/sudoers.d/*"
    [ "$status" -eq 0 ]
    [[ "$output" == *"Defaults use_pty" ]]
}

@test "1.3.3 Ensure sudo log file exists (Scored)" {
    run bash -c "grep -Ei '^\s*Defaults\s+logfile=\S+' /etc/sudoers /etc/sudoers.d/*"
    [ "$status" -eq 0 ]
    [[ "$output" == *"Defaults logfile="* ]]
}
