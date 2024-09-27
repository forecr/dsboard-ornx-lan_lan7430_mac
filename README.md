# dsboard-ornx-lan_lan7430_mac
LAN7430 MAC address writer application for DSBOARD-ORNX-LAN

## [Optional] Write custom MAC Address into the .bin file
For example, if you want to write 02:4b:cf:ae:f7:00 as a MAC address, you can update the .bin file with:
```shell
printf '\xa5\x02\x4b\xcf\xae\xf7\x00' | dd of=lan7430e_00.bin bs=1 seek=0 conv=notrunc
```

## [Optional] Verify the LAN7430 detected by the system
Run the following command to find how many lan743x based network interfaces does DSBOARD-ORNX-LAN has (it should be 1):
```shell
sudo ./check_lan7430_interfaces.sh
```

## Write the MAC address to the IC
Run the following command to write the "lan7430e_00.bin" file to the "eth1" interface:
```shell
sudo ethtool --set-priv-flags eth1 OTP_ACCESS off
sudo ethtool -E eth1 magic 0x74A5 offset 0 length 256 < lan7430e_00.bin
```

