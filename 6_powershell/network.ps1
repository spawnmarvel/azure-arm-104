# Test port
Test-NetConnection -ComputerName xxx.xx.xxx.xx -Port 1000

# Test latency
# Ping tool is used to test whether a particular host is reachable across an IP network. 
# A Ping measures the time it takes for packets to be sent from the local host to a destination computer and back
ping www.google.com -t
# Pinging www.google.com [142.250.181.196] with 32 bytes of data:
# Reply from 142.250.181.196: bytes=32 time=34ms TTL=55
# Reply from 142.250.181.196: bytes=32 time=34ms TTL=55

# Traceroute ensures each hop on the way to a destination device drops a packet and sends back an ICMP error message. 
# This means traceroute can measure the duration of time between when the data is sent and when the ICMP message is received back for each hop—giving you the RTT value for each hop
tracert www.goggle.com
# Tracing route to www.goggle.com [45.55.44.56]
# over a maximum of 30 hops:
# 1    <1 ms    <1 ms    <1 ms  xx.xx.x.x.x
# 2     3 ms     1 ms     1 ms  somedomain.no [x.x.x.x..x]

# Test bandwidth network speed test
# There's an old command line tool call iperf.exe that can be used to test the bandwidth between two endpoints. 
# Run 
iperf -s on the endpoint, iperf -c computername from Powershell.

# https://iperf.fr/
# https://www.dell.com/support/kbdoc/no-no/000139427/hvordan-du-tester-tilgjengelig-nettverks-b%C3%A5nd-bredde-ved-hjelp-av-iperf


# 1. Last ned Iperf-verktøyet.  Du kan finne en kopi på Iperf.fr, https://iperf.fr/
# 2. Åpne et hevet kommando vindu på serveren som skal motta data, og Kjør følgende kommando: "Iperf. exe – s – w 2 MB".
# 3. Åpne et hevet kommando vindu på serveren som skal sende data, og Kjør følgende kommando: "Iperf-c x. x-. x-w 2 MB-t 30s-i 1s".  Bytt ut x. x. x med IP-adressen til serveren fra trinn 2.
# 4. Se gjennom dataene som ble returnert på serveren fra trinn 3.  Utdataene bør ligne på teksten nedenfor: 


# -w,--vindu n [KM] TCP vindus størrelse (kontaktens buffer størrelse) 
# -s,--server, Kjør i server-modus 

# C:\Users\ some_user \Downloads > Iperf-c xx. xx. xx. xx-w 2 MB-t 30s-i 1
# ------------------------------------------------------------
# Klienten kobler til xx. xx. xx. xx, TCP port 5001
# TCP vindus størrelse: 2,00 MB
# ------------------------------------------------------------
# [156] lokal xx. xx. xx. xx port 53724 koblet til xx. xx. xx. xx port 5001
# [ID] intervall mellom overførings bånd bredde
# [156] 0,0-1,0 sek 113 megabyte på 945 Mbit/sek
# [156] 1,0-2,0 sek 112 megabyte på 944 Mbit/sek
# [156] 2,0-3,0 sek 113 megabyte på 945 Mbit/sek
# .
# .
# .
# [156] 28.0-29.0 sek 113 MB 945 Mbit/sek
# [156] 29.0-30.0 sek 112 MB 944 Mbit/sek
# [156] 0.0-30.3 sek 3,30 GBytes 945 Mbps 