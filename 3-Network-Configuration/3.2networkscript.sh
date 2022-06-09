# AUTOMATED NETWORK SCRIPT FOR 3.2 BASED ON CIS BENCHMARK UBUNTU 18.04 AND RED HAT LINUX 8
# PLEASE ENSURE THAT REQUIRED PARAMETERS ARE CONFIGURED IN  /etc/sysctl.conf
# SCRIPT BY GITHUB/MRFAEEZ

# 3.2.1 Ensure source routed packets are not accepted 
sysctl -w net.ipv4.conf.all.accept_source_route=0;
sysctl -w net.ipv4.conf.default.accept_source_route=0;
sysctl -w net.ipv6.conf.all.accept_source_route=0;
sysctl -w net.ipv6.conf.default.accept_source_route=0;
sysctl -w net.ipv4.route.flush=1;
sysctl -w net.ipv6.route.flush=1;

# 3.2.2  Ensure ICMP redirects are not accepted 
sysctl -w net.ipv4.conf.all.accept_redirects=0;
sysctl -w net.ipv4.conf.default.accept_redirects=0;
sysctl -w net.ipv6.conf.all.accept_redirects=0;
sysctl -w net.ipv6.conf.default.accept_redirects=0;
sysctl -w net.ipv4.route.flush=1;
sysctl -w net.ipv6.route.flush=1;

# 3.2.3 Ensure secure ICMP redirects are not accepted
sysctl -w net.ipv4.conf.all.secure_redirects=0;
sysctl -w net.ipv4.conf.default.secure_redirects=0;
sysctl -w net.ipv4.route.flush=1;

# 3.2.4 Ensure suspicious packets are logged
sysctl -w net.ipv4.conf.all.log_martians=1;
sysctl -w net.ipv4.conf.default.log_martians=1;
sysctl -w net.ipv4.route.flush=1;

# 3.2.5 Ensure broadcast ICMP requests are ignored
sysctl -w net.ipv4.icmp_echo_ignore_broadcasts=1
sysctl -w net.ipv4.route.flush=1

# 3.2.6 Ensure bogus ICMP responses are ignored
sysctl -w net.ipv4.icmp_echo_ignore_broadcasts=1;
sysctl -w net.ipv4.route.flush=1;

# 3.2.7 Ensure Reverse Path Filtering is enabled
sysctl -w net.ipv4.conf.default.rp_filter=1;
sysctl -w net.ipv4.route.flush=1;

# 3.2.8 Ensure TCP SYN Cookies is enabled
sysctl -w net.ipv4.tcp_syncookies=1;
sysctl -w net.ipv4.route.flush=1;

# 3.2.9 Ensure IPv6 router advertisements are not accepted
sysctl -w net.ipv6.conf.all.accept_ra=0;
sysctl -w net.ipv6.conf.default.accept_ra=0;
sysctl -w net.ipv6.route.flush=1;


