#!/bin/bash
#[ -f $HOME/.openrc.sh ] && source $HOME/.openrc.sh
echo "# RUNNING: $(dirname $0)/$(basename $0)"

set -xe -o pipefail
function clean() {
[ "$?" -gt 0 ] && notify_failure "Deploy $0: $?"
}
trap clean EXIT QUIT KILL

libdir=/home/debian
[ -f ${libdir}/common_functions.sh ] && source ${libdir}/common_functions.sh

su - debian -c "bash -c /home/debian/launch.sh"

# Simple success signal
notify_success "Post Install success"

echo "*** OK *****"
