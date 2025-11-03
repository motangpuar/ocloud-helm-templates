#!/bin/bash
# /usr/local/bin/setup-vf.sh

# Step 1: Unbind everything - don't care which driver
for dev in 0000:70:02.0 0000:70:02.1; do
    if [ -L /sys/bus/pci/devices/$dev/driver ]; then
        echo $dev > /sys/bus/pci/devices/$dev/driver/unbind 2>/dev/null || true
    fi
done

# Step 2: Destroy VFs
echo 0 > /sys/class/net/ens1f0/device/sriov_numvfs

# Step 3: Unload iavf
rmmod iavf 2>/dev/null || true
sleep 1

# Step 4: Create VFs (iavf will try to bind via udev)
echo 2 > /sys/class/net/ens1f0/device/sriov_numvfs
sleep 2

# Step 5: Race udev - unbind iavf immediately if it bound
for dev in 0000:70:02.0 0000:70:02.1; do
    driver=$(readlink /sys/bus/pci/devices/$dev/driver 2>/dev/null | xargs basename)
    if [ "$driver" = "iavf" ]; then
        echo $dev > /sys/bus/pci/drivers/iavf/unbind
    fi
done

# Step 6: Bind vfio-pci
modprobe vfio-pci
/usr/local/bin/dpdk-devbind.py --bind=vfio-pci 70:02.0 70:02.1

# Step 7: NOW configure VLAN after vfio-pci owns the VF
ip link set ens1f0 vf 0 mac 00:11:22:33:44:66 vlan 3 trust on spoofchk off
ip link set ens1f0 vf 1 mac 00:11:22:33:44:66 vlan 3 trust on spoofchk off
sleep 1

echo "Done"
lspci -k -s 70:02.0
