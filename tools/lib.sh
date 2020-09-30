#!/bin/sh


openstack_args="${openstack_args:-} --insecure "

function log_error(){
 echo "$@"
 exit $1
}

function get_stack_output_value(){
  [ -z "$1" -o -z "$2" ] && log_error 1 "aucun argument"
  local stack_name=$1
  local output_var=$2
  ret=0
  local output_value="" ; eval $(openstack $openstack_args stack output show -c "output_value" -f shell $stack_name "$output_var" ) ; [ -z "$output_value" ] && ret=1 || echo "$output_var=$output_value ; "
  return $ret
}

function get_stack_parameter_value(){
  [ -z "$1" -o -z "$2" ] && log_error 1 "aucun argument"
  local stack_name=$1
  local parameter=$2
  ret=0
  local parameters="" ;
  eval $(openstack $openstack_args stack show -f shell -c parameters $stack_name || echo "false")
  ret=$?
  output_value=$(echo "$parameters" | jq -r ".$parameter")
  ret=$?
  [ -z "$output_value" ] && ret=1 || echo "$parameter=$output_value ; "
  return $ret
}
