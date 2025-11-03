#!/bin/bash
sudo sh -c 'echo 0 > /sys/class/net/ens1f0/device/sriov_numvfs'
sudo sh -c 'echo 2 > /sys/class/net/ens1f0/device/sriov_numvfs'
sudo ip link set ens1f0 vf 0 mac 00:11:22:33:44:66 vlan 3 trust on spoofchk off
sudo ip link set ens1f0 vf 1 mac 00:11:22:33:44:66 vlan 3 trust on spoofchk off
sleep 2
sudo /usr/local/bin/dpdk-devbind.py --bind=vfio-pci 70:02.0 70:02.1
