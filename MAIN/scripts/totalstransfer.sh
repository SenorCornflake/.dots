rx=`cat /sys/class/net/wlp3s0/statistics/rx_bytes`
tx=`cat /sys/class/net/wlp3s0/statistics/tx_bytes`

total=$((tx + rx))
#total=$(echo "$total/1000" | bc -l)
#total=$(echo "$total/1000" | bc -l)
total=$((total / 1000))
total=$((total / 1000))
echo "$total"
