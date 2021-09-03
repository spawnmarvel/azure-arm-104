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