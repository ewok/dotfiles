# Void Linux installation (EFI, btrfs, LVM, full disk encryption using LUKS, SSD TRIM, GPT)

set -e

# setting some vars:
## Virtualbox
WPA_INTERFACE=""
KEYMAP=en
DISK=/dev/sda
BOOT_DISK=/dev/sda1
VOID_DISK=/dev/sda2
SWAP_SIZE=1G
export XBPS_ARCH=x86_64
XBPS_REPO="https://mirror.ps.kz/voidlinux/current"
HOSTNAME=void
HARDWARECLOCK="Asia/Bishkek"
TIMEZONE="Asia/Bishkek"
MOUNT_OPTS="rw,noatime"

## Thinkpad t14s
# WPA_INTERFACE="wlp0s20f3"
# WPA_SSID=${WPA_SSID:-""}
# WPA_PASSPHRASE=${WPA_PASSPHRASE:-""}
# KEYMAP=en
# DISK=/dev/nvme0n1
# BOOT_DISK=/dev/nvme0n1p1
# VOID_DISK=/dev/nvme0n1p2
# SWAP_SIZE=17G
# export XBPS_ARCH=x86_64
# XBPS_REPO="https://mirror.ps.kz/voidlinux/current"
# HOSTNAME=void
# HARDWARECLOCK="Asia/Bishkek"
# TIMEZONE="Asia/Bishkek"
# MOUNT_OPTS="rw,noatime,ssd,compress=lzo,space_cache,commit=60"

cat << EOFF > cleanup.sh
DISK=/dev/sda
EOFF
cat << 'EOFF' >> cleanup.sh
if [ "$1" != "-y" ]; then
    echo "This script will destroy all data on $DISK"
    echo "Press Ctrl+C to abort"
    read -p "Press any key to continue"
fi
umount /mnt/proc
umount /mnt/sys
umount /mnt/dev/pts
umount /mnt/dev
umount /mnt/boot/efi
umount /mnt/.snapshots
umount /mnt/home
umount /mnt
vgremove vg0 -f
cryptsetup luksClose crypt
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk ${DISK}
  o # clear the in memory partition table
  w # write the partition table
EOF
lsblk
EOFF

if [ "$1" != "-y" ]; then
    echo "This script will destroy all data on $DISK"
    echo "Press Ctrl+C to abort"
    read -p "Press any key to continue"
fi


read -s -p "Enter LUKS password: " LUKS_PASSWORD

## Script part
loadkeys $KEYMAP

if [ "${WPA_INTERFACE}" != "" ]; then
    cp /etc/wpa_supplicant/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant-${WPA_INTERFACE}.conf
    wpa_passphrase ${WPA_SSID} ${WPA_PASSPHRASE} >> /etc/wpa_supplicant/wpa_supplicant-${WPA_INTERFACE}.conf
    wpa_supplicant -B -i ${WPA_INTERFACE} -c /etc/wpa_supplicant/wpa_supplicant-${WPA_INTERFACE}.conf
fi

sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk ${DISK}
  o # clear the in memory partition table
  g # create a new GPT partition table
  n # new partition
  1 # partition number 1
    # default - start at beginning of disk 
  +500M # 500 MB boot parttion
  t 1 # set partition type to EFI
  1 # EFI
  n # new partition
  2 # partion number 2
    #
    #
  p # print the in-memory partition table
  w # write the partition table
EOF
#
echo -n $LUKS_PASSWORD | cryptsetup luksFormat --type=luks1 ${VOID_DISK} -
echo -n $LUKS_PASSWORD | cryptsetup open ${VOID_DISK} crypt -

# prepare LVM
vgcreate vg0 /dev/mapper/crypt
lvcreate --name swap -L ${SWAP_SIZE} vg0
lvcreate --name void -l +100%FREE vg0

# filesystems
mkfs.vfat -n BOOT -F 32 ${BOOT_DISK}
mkswap /dev/mapper/vg0-swap
mkfs.btrfs -L void /dev/mapper/vg0-void

mount -o ${MOUNT_OPTS} /dev/mapper/vg0-void /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@snapshots
umount /mnt
mount -o ${MOUNT_OPTS},subvol=@ /dev/mapper/vg0-void /mnt
mkdir -p /mnt/home
mkdir -p /mnt/.snapshots
mount -o ${MOUNT_OPTS},subvol=@home /dev/mapper/vg0-void /mnt/home/
mount -o ${MOUNT_OPTS},subvol=@snapshots /dev/mapper/vg0-void /mnt/.snapshots/
mkdir -p /mnt/boot/efi
mount -o rw,noatime ${BOOT_DISK} /mnt/boot/efi/
mkdir -p /mnt/var/cache
btrfs subvolume create /mnt/var/cache/xbps
btrfs subvolume create /mnt/var/tmp
btrfs subvolume create /mnt/srv
xbps-install -Sy -R "${XBPS_REPO}" -r /mnt base-system btrfs-progs cryptsetup grub-x86_64-efi lvm2
modprobe efivarfs || true  # ignore error
mount -t proc proc /mnt/proc/
mount -t sysfs sys /mnt/sys/
mount -o bind /sys/firmware/efi/efivars /mnt/sys/firmware/efi/efivars
mount -o bind /dev /mnt/dev
mount -t devpts pts /mnt/dev/pts
cp -L /etc/resolv.conf /mnt/etc/

if [ "$WPA_INTERFACE" != "" ]; then
    cp -L /etc/wpa_supplicant/wpa_supplicant-${WPA_INTERFACE}.conf /mnt/etc/wpa_supplicant/
fi

### Post-chroot
cat << EOFF > /mnt/post-chroot.sh
set -e
KEYMAP="$KEYMAP"
DISK="$DISK"
BOOT_DISK="$BOOT_DISK"
VOID_DISK="$VOID_DISK"
HOSTNAME="$HOSTNAME"
HARDWARECLOCK="$HARDWARECLOCK"
TIMEZONE="$TIMEZONE"
MOUNT_OPTS="$MOUNT_OPTS"

EOFF

cat << 'EOFF' >> /mnt/post-chroot.sh

read -s -p "Enter LUKS password: " LUKS_PASSWORD

## Not to be asked twice on boot
dd bs=512 count=4 if=/dev/urandom of=/boot/volume.key
echo $LUKS_PASSWORD | cryptsetup luksAddKey ${VOID_DISK} /boot/volume.key -
chmod 000 /boot/volume.key
chmod -R g-rwx,o-rwx /boot

## LUKS
cat <<EOF >> /etc/crypttab
crypt ${VOID_DISK} /boot/volume.key luks
EOF

echo
echo Set up root password:
passwd root
chown root:root /
chmod 755 /

#  Set up hostname
echo $HOSTNAME > /etc/hostname
cat <<EOF > /etc/rc.rc.conf
# /etc/rc.conf - system configuration for void

HOSTNAME="$HOSTNAME"
HARDWARECLOCK="$HARDWARECLOCK"
TIMEZONE="$TIMEZONE"
KEYMAP="$KEYMAP"
EOF
echo 'en_US.UTF-8 UTF-8' > /etc/default/libc-locales
echo LANG=en_US.UTF-8 > /etc/locale.conf

## Disk setup
export UEFI_UUID=$(blkid -s UUID -o value ${BOOT_DISK})
export LUKS_UUID=$(blkid -s UUID -o value ${VOID_DISK})
export ROOT_UUID=$(blkid -s UUID -o value /dev/mapper/vg0-void)
export SWAP_UUID=$(blkid -s UUID -o value /dev/mapper/vg0-swap)

cat <<EOF > /etc/fstab
UUID=$ROOT_UUID / btrfs ${MOUNT_OPTS},subvol=@ 0 1
UUID=$ROOT_UUID /home btrfs ${MOUNT_OPTS},subvol=@home 0 2
UUID=$ROOT_UUID /.snapshots btrfs ${MOUNT_OPTS},subvol=@snapshots 0 2
UUID=$UEFI_UUID /boot/efi vfat defaults,noatime 0 2
UUID=$SWAP_UUID none swap defaults 0 1
tmpfs /tmp tmpfs defaults,noatime,mode=1777 0 0
EOF

## Bootloader
cat <<EOF >> /etc/default/grub
GRUB_ENABLE_CRYPTODISK=y
EOF
sed -i "/GRUB_CMDLINE_LINUX_DEFAULT=/s/\"$/ rd.auto=1 cryptdevice=UUID=$LUKS_UUID:lvm:allow-discards&/" /etc/default/grub

## Dracut
cat <<EOF >> /etc/dracut.conf.d/10-crypt.conf
install_items+=" /boot/volume.key /etc/crypttab "
EOF
echo 'add_dracutmodules+=" crypt btrfs lvm resume "' >> /etc/dracut.conf
echo 'tmpdir=/tmp' >> /etc/dracut.conf
KERNEL_INSTALLED=$(ls /lib/modules | sort -V | tail -n 1)
dracut --force --hostonly --kver ${KERNEL_INSTALLED}

mkdir /boot/grub
grub-mkconfig -o /boot/grub/grub.cfg
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=void --boot-directory=/boot  --recheck

ln -s /etc/sv/dhcpcd /etc/runit/runsvdir/default
ln -s /etc/sv/wpa_supplicant/ /etc/runit/runsvdir/default
sed -i 's/issue_discards = 0/issue_discards = 1/' /etc/lvm/lvm.conf
EOFF

echo "Run 'bash post-chroot.sh' to proceed."

chroot /mnt /bin/bash
