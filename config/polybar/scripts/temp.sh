echo "$(sensors | grep "Core" | sed "s/.*://" | sed "s/(.*)//" | sed "s/ //g" | sed "s/°C//" | sed "s/+//")" | awk '{s+=$1}END{print s/NR}' RS="\n"
