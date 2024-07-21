# Arch
## Pre-Install
### Ethernet
Let's check you WIFI connection:
```
ip addr show
```
If you aren't connected, let's setup your wifi.\
Enter in wifi manager:
```
iwctl
```
So, we need to get all available wifi aroud us:
```
station ${wifi-name-interface} get-networks
```
Now, let's connect to desired wifi:
```
station ${wifi-name-interface} connect ${ssid}
```
And finaly, enter password.\
Let's check if you have access to internet:
```
ping archlinux.org
```
### Time
Let's check local time:
```
timedatectl
```
If the local time isn't the expected one, change it:
```
timedatectl set-timezone ${location}
```
### File System  
Where are on a Virtual Terminal, let's swap to our file system.\
In a fisrt time, we want to list our partition:
```
fdisk -l
```
Select the desire disk:
```
fdisk /dev/${disk}
```
Create root partition:
```
n
```
Select the number of the patition.\
Remove 8Gb for the swap partition:
```
-8G
```
Give root partition type:
```
t
```
Select the number of the patition.\
Select `Linux filesystem`:
```
20
```
Create swap partition:
```
n
```
Select the number of the patition.\
Give the rest of the disk space:
```
 
```
Give swap partition type:
```
t
```
Select the number of the patition.\
Select `Linux swap`:
```
19
```
Know, exit fdisk manager, and format root partition in `Ext4`:
```
mkfs.ext4 /dev/${root-partition}
```
Do the same for the swap partition:
```
 mkswap /dev/${swap-partition}
```
### Mounting
```
mount /dev/${root-partitiom} /mnt
```
Enable Swap:
```
 swapon /dev/${swap-partition}
```
## Install
### Install essential packages
Use the pacstrap script to install the base package, Linux kernel and firmware for common hardware: 
```
pacstrap -K /mnt base linux linux-firmware
```
## Configure the System
### Fstab
Generate an fstab file (use -U or -L to define by UUID or labels, respectively), used to define how disk partitions, various other block devices, or remote file systems should be mounted into the file system.
```
genfstab -U /mnt >> /mnt/etc/fstab
```
### Arch Install
```
archinstall
```
+ Language
+ Mirrors
+ Locales
+ Disk Configuration (set root partition `/`,set efi partition `/boot`)
+ Bootloader (GRUB)
+ Swap (True)
+ Hostname (archlinux)
+ Root Password 
+ Users Account
+ Profile (Desktop)
+ Audio (Pulseaudio)
+ Kernels (linux)
+ Additional Packages
+ Network Configuration
+ Timezone
+ Automatic Time Sync (NTP)
+ Optional Repositories
### Chroot
Change root into the new system:
```
arch-chroot /mnt
```
### Time
Set the time zone:
```
ln -sf /usr/share/zoneinfo/${location} /etc/localtime
```
Run hwclock to generate /etc/adjtime: 
```
hwclock --systohc
```
### Localization
Edit `/etc/locale.gen` and uncomment `en_US.UTF-8` `UTF-8` and other needed `UTF-8` locales.\
Generate the locales by running:
```
locale-gen
```
Create the locale.conf file, and set the LANG variable accordingly in `/etc/locale.conf`:
```
LANG=en_US.UTF-8
```
### Network configuration
Create the hostname file `/etc/hostname`:
```
${hostname}
```
### Initramfs
Creating a new initramfs is usually not required, because mkinitcpio was run on installation of the kernel package with pacstrap.
For LVM, system encryption or RAID, modify `mkinitcpio.conf` and recreate the initramfs image:
```
mkinitcpio -P
```
The initramfs is a complete set of directories that you would find on a normal root filesystem.
### Root password
Set the root password:
```
passwd
```
## Reboot 
```
exit && reboot
```
## Post-installation
