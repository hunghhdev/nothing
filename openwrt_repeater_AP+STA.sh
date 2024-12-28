# Fill in these values, then run the script
export ROUTER_LAN_IP='192.168.198.1'

# Set the router's LAN IP address to a different subnet from the hotspot (AP) IP address.
echo 'Setting the LAN IP address to '$ROUTER_LAN_IP
uci set network.lan.ipaddr=$ROUTER_LAN_IP

# Add the WWAN network is in the WAN firewall zone
echo 'Setting firewall zone for "wwan"'
uci add_list firewall.@zone[1].network="wwan"
uci commit firewall
/etc/init.d/firewall restart

# The WWAN interface is the "uplink". It obtains a DHCP address from the upstream hotspot.
echo 'Configuring WWAN'
uci set network.wwan="interface"
uci set network.wwan.proto="dhcp"
uci commit network
/etc/init.d/network restart

# Add the Wi-Fi interface for the uplink.
# STA mode, with the proper Wi-Fi credentials (SSID, encryption mode, key)
echo 'Configuring the Wi-Fi uplink'
uci set wireless.wwan="wifi-iface"                                                                                                                                                                    uci set wireless.wwan.device="radio0"
uci set wireless.wwan.network="wwan"
uci set wireless.wwan.mode="sta"
# Change the encryption and ssid values to match those of the hotspot (AP)
uci set wireless.wwan.encryption='psk-mixed'
uci set wireless.wwan.ssid='master wifi'
uci set wireless.wwan.key='master passs'
uci commit wireless

echo "Configuring the AP Wi-Fi"
uci set wireless.default_radio0.ssid=h5n1
uci set wireless.default_radio0.hidden=1
uci set wireless.default_radio0.encryption=sae #none wep psk psk2 sae psk-mixed sae-mixed
uci set wireless.default_radio0.key='n2ohahahehe'
uci commit wireless

wifi reload


# enable radio
#uci set wireless.radio0.disabled=0
#uci set wireless.radio1.disabled=0
#uci commit wireless
#wifi reload


# check status
# iwinfo
# iw dev wlan0 link
# ifstatus wwan
#
