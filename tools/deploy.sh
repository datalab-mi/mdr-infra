#!/bin/bash
#
# script de deploiement
#
set -e

# load lib
[ -f $(dirname $0)/lib.sh ] || exit 1
source $(dirname $0)/lib.sh


get_stack_output_value ${stack_name} deces_dataprep_floating_ip
