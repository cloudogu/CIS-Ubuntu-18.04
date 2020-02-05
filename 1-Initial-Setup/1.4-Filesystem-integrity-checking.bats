#!/usr/bin/env bats

@test "1.4.1 Ensure AIDE is installed (Scored)" {
    run bash -c "dpkg -s aide"
    [ "$status" -eq 0 ]
}

@test "1.4.2 Ensure filesystem integrity is regularly checked (Scored)" {
    local check_enabled=$(systemctl is-enabled aidecheck.service)
    local check_status=$(systemctl status aidecheck.service)
    local timer_enabled=$(systemctl is-enabled aidecheck.timer)
    local timer_status=$(systemctl status aidecheck.timer)

    local aide_in_root_cron=$(crontab -u root -l | grep aide)
    local aide_in_any_cron=$(grep -r aide /etc/cron.* /etc/crontab)

    echo "$check_enabled dings"
}
