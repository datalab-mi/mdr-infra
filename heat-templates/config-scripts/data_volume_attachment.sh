#!/bin/bash
echo "# RUNNING: $(dirname $0)/$(basename $0)"
set -xe
function clean() {
[ "$?" -gt 0 ] && notify_failure "Deploy $0: $?"
}
trap clean EXIT QUIT KILL

libdir=/home/debian
[ -f ${libdir}/common_functions.sh ] && source ${libdir}/common_functions.sh

volume_id="$data_volume_id"
if [ -z "${volume_id}" ] ; then
 echo "SKIP: $(basename $0) No volume id detected"
 exit 0
fi
volume_dev="/dev/disk/by-id/scsi-0QEMU_QEMU_HARDDISK_$(echo ${volume_id})"

echo "# Wait ${volume_dev} up"
set +e
ret=0
timeout=120;
test_result=1
until [ "$timeout" -le 0 -o "$test_result" -eq "0" ] ; do
        ( ls -L $volume_dev 2>&-)
        test_result=$?
        echo "Wait $timeout seconds: ${volume_dev} up $test_result";
        (( timeout-- ))
        sleep 1
done
if [ "$test_result" -gt "0" ] ; then
        ret=$test_result
        echo "ERROR: ${volume_dev} en erreur"
        exit $ret
fi

if ! /sbin/blkid -t TYPE=ext4 "${volume_dev}" ; then
  mkfs.ext4 ${volume_dev}
fi

mkdir -pv /data
chown debian /data -R
echo "${volume_dev} /data ext4 defaults 1 2" >> /etc/fstab
mount /data
