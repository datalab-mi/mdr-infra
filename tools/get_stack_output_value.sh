#!/bin/sh
function get_stack_output_value(){
  [ -z "$1" -o -z "$2" ] && log_error 1 "aucun argument"
  local stack_name=$1
  local output_var=$2
  ret=0
  local output_value="" ; eval $(openstack $openstack_args stack output show -c "output_value" -f shell $stack_name "$output_var" ) ; [ -z "$output_value" ] && ret=1 || echo "$output_var=$output_value ; "
  return $ret
}

get_stack_output_value "$@"; exit
