#!/usr/bin/env bats

@test "1.9 Ensure updates, patches, and additional security software are installed (Not Scored)" {
    (apt-get upgrade -s | grep "^0 upgraded")
    (apt-get upgrade -s | grep -E "[[:space:]]0 newly installed")
    (apt-get upgrade -s | grep -E "[[:space:]]0 to remove")
    (apt-get upgrade -s | grep -E "[[:space:]]0 not upgraded")
}
