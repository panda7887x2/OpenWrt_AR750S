#!/bin/bash

############# Modify default parameters here #################
WORKDIR=/workdir
HOSTNAME=AR750S
IPADDRESS=192.168.1.1
SSID=AR750S
ENCRYPTION=psk2+ccmp
KEY=password
###############################################################

cd "$WORKDIR/openwrt"

# Modify default Hostname
sed -i "s/hostname='OpenWrt'/hostname='$HOSTNAME'/g" package/base-files/files/bin/config_generate

# Modify default IP
#sed -i 's/192.168.1.1/$IPADDRESS/g' package/base-files/files/bin/config_generate

# Modify Timezone
sed -i "s/timezone='UTC'/timezone='CST-8'/g" package/base-files/files/bin/config_generate
sed -i "/timezone='CST-8'/a\                set system.@system[-1].zonename='Asia/Shanghai'" package/base-files/files/bin/config_generate

# Modify NTP settings
sed -i 's/0.openwrt.pool.ntp.org/ntp1.aliyun.com/g' package/base-files/files/bin/config_generate
sed -i 's/1.openwrt.pool.ntp.org/time1.cloud.tencent.com/g' package/base-files/files/bin/config_generate
sed -i 's/2.openwrt.pool.ntp.org/time.ustc.edu.cn/g' package/base-files/files/bin/config_generate
sed -i 's/3.openwrt.pool.ntp.org/pool.ntp.org/g' package/base-files/files/bin/config_generate

# Modify default WiFi SSID
sed -i "s/set wireless.default_radio\${devidx}.ssid=OpenWrt/set wireless.default_radio\${devidx}.ssid='$SSID'/g" package/kernel/mac80211/files/lib/wifi/mac80211.sh

# Modify default WiFi Encryption
sed -i "s/set wireless.default_radio\${devidx}.encryption=none/set wireless.default_radio\${devidx}.encryption='$ENCRYPTION'/g" package/kernel/mac80211/files/lib/wifi/mac80211.sh

# Modify default WiFi Key
sed -i "/set wireless.default_radio\${devidx}.mode=ap/a\                        set wireless.default_radio\${devidx}.key='$KEY'" package/kernel/mac80211/files/lib/wifi/mac80211.sh

# Forced WiFi to enable
sed -i 's/set wireless.radio\${devidx}.disabled=1/set wireless.radio\${devidx}.disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

