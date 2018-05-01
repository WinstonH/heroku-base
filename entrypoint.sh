#!/bin/bash
#start net speeder
ETH=$(eval "ifconfig | grep 'eth0'| wc -l")
if [ "$ETH"  ==  '1' ] ; then
	nohup /usr/local/bin/net_speeder eth0 "ip" >/dev/null 2>&1 &
fi
if [ "$ETH"  ==  '0' ] ; then
    nohup /usr/local/bin/net_speeder venet0 "ip" >/dev/null 2>&1 &
fi

#config UUID
sed -i "s/UUID/$UUID/g" /etc/v2ray/config.json
echo "UUID config OK"
#config wallet
sed -i "s/WALLET/$WALLET/g" /home/myuser/xmr-stak/build/bin/pools.txt
#config PORT
sed -i "s/PORT/$PORT/g" /etc/nginx/nginx.conf
nginx
/usr/bin/supervisord -c /etc/supervisord.conf
