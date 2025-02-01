#!/usr/bin/env bash
## zfs_example_simulated_device.sh
# Run this as root.
# USAGE: $ sudo bash zfs_example_simulated_device.sh


## == CONFIGURATION ==
tmp_dir_hdd="/media/somehdd/temp.zfs_testing.simulated_device/" # Dir to store pretend HDDs in.
tmp_dir_ssd="/media/somessd/temp.zfs_testing.simulated_device/" # Dir to store pretend SSDs in.
zpool_name="test-zpool-001" # Name for the exaple zpool.
fake_dev_filesize="16G" # Format as used by "$truncate -s".

## == No config below this line ==
## Begin actual work...
echo "START: zfs_example_simulated_device.sh"
echo "You should be root."

## Log config values and username
echo "USER=${USER}"
echo "tmp_dir_hdd=${tmp_dir_hdd}"
echo "tmp_dir_ssd=${tmp_dir_ssd}"
echo "zpool_name=${zpool_name}"
echo "fake_dev_filesize=${fake_dev_filesize}"

## (prep)
echo "Simulate HDDs with files on a HDD"
mkdir -vp "${tmp_dir_hdd}"
for n in {0..7}; do truncate -s "${fake_dev_filesize}" "${tmp_dir_hdd}/${n}.raw"; done  # Preallocate disk space.
echo "Simulate SSD cache with file on a SSD"
mkdir -vp "${tmp_dir_ssd}"
truncate -s "${fake_dev_filesize}" "${tmp_dir_ssd}/0.raw" # Preallocate disk space.
ls -lah "${tmp_dir_ssd}"

echo "Create a zpool using files on disk"
zpool create "${zpool_name}" raidz2 "${tmp_dir_hdd}"*".raw"
echo "## == Inspect zpool =="
echo "# df -hT"
df -hT
echo "# zfs list"
zfs list
echo "# zpool status"
zpool status


## (task)
echo "Add cache to a preexisting zpool"
zpool add "${zpool_name}" cache "${tmp_dir_ssd}/0.raw"
echo "## == Inspect zpool(s) =="
echo "# df -hT"
df -hT
echo "# zfs list"
zfs list
echo "# zpool status"
zpool status


## (cleanup)
echo "Destroy the pool after testing is completed:"
zpool destroy "filetest03"
echo "Remove temp dirs"
rm -r "${tmp_dir_ssd}" "${tmp_dir_hdd}"


echo "Demonstrate pool is removed:"
echo "## == Inspect zpool(s) =="
echo "# df -hT"
df -hT
echo "# zfs list"
zfs list
echo "# zpool status"
zpool status


echo "END: zfs_example_simulated_device.sh"
exit
