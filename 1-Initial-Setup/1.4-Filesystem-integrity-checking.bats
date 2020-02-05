#!/usr/bin/env bats

@test "1.4.1 Ensure AIDE is installed (Scored)" {
    run bash -c "dpkg -s aide"
    [ "$status" -eq 0 ]
}

@test "1.4.2 Ensure filesystem integrity is regularly checked (Scored)" {
    local check_enabled
    local check_status

    if systemctl is-enabled aidecheck.service; then
        check_enabled=$(systemctl is-enabled aidecheck.service)
        check_status=$(systemctl status aidecheck.service)
    else
        check_enabled=false
        check_status=false
    fi

    local timer_enabled
    local timer_status
    if systemctl is-enabled aidecheck.timer; then
        timer_enabled=$(systemctl is-enabled aidecheck.timer)
        timer_status=$(systemctl status aidecheck.timer)
    else
        timer_enabled=false
        timer_status=false
    fi;

    local aide_in_root_cron
    if crontab -u root -l; then
        aide_in_root_cron=$(crontab -u root -l | grep aide)
    else
        aide_in_root_cron=false
    fi;

    local aide_in_any_cron
    aide_in_any_cron=$(grep -r aide /etc/cron.* /etc/crontab)

    [ "$check_enabled" != false ] && [ "$check_status" != false ] &&
     [ "$timer_enabled" != false ] && [ "$timer_status" != false ] \
      || [ "$aide_in_root_cron" ] \
      || [ "$aide_in_any_cron" ]
}
