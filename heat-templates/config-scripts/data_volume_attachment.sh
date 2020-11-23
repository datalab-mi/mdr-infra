#!/bin/bash
echo "# RUNNING: $(dirname $0)/$(basename $0)"
set -xe
function clean() {
[ "$?" -gt 0 ] && notify_failure "Deploy $0: $?"
}
trap clean EXIT QUIT KILL

libdir=/home/debian
[ -f ${libdir}/common_functions.sh ] && source ${libdir}/common_functions.sh

if [ -z "${partition_name}" ] ; then
 echo "SKIP: $(basename $0) No volume id detected"
 exit 0
fi

echo "# Wait ${partition_name} up"
set +e
ret=0
timeout=120;
test_result=1
until [ "$timeout" -le 0 -o "$test_result" -eq "0" ] ; do
        ( ls -L $partition_name 2>&-)
        test_result=$?
        echo "Wait $timeout seconds: ${partition_name} up $test_result";
        (( timeout-- ))
        sleep 1
done
if [ "$test_result" -gt "0" ] ; then
        ret=$test_result
        echo "ERROR: ${partition_name} en erreur"
        exit $ret
fi

if ! /sbin/blkid -t TYPE=ext4 "${partition_name}" ; then
  mkfs.ext4 ${partition_name}
fi

mkdir -pv /data
echo "${partition_name} /data ext4 defaults 1 2" >> /etc/fstab
mount /data

exit 0
