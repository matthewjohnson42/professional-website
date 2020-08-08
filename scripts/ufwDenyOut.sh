echo
echo "---------------------------"
echo "DISALLOWING OUTBOUND HTTP(S)"
echo "---------------------------"
echo

sudo ufw deny out to any from any
