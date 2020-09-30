# Send success status to OpenStack WaitCondition
function notify_success() {
    unset http_proxy
    unset https_proxy
    unset no_proxy
    curl_opt="--retry 10 --retry-delay 5 --retry-max-time 60 --connect-timeout 10 --insecure"

    $wc_notify $curl_opt --data-binary \
               "{\"status\": \"SUCCESS\", \"reason\": \"$1\", \"data\": \"$1\"}"
    exit 0
}

# Send success status to OpenStack WaitCondition
function notify_failure() {
    unset http_proxy
    unset https_proxy
    unset no_proxy
    curl_opt="--retry 10 --retry-delay 5 --retry-max-time 60 --connect-timeout 10 --insecure"

    $wc_notify $curl_opt --data-binary \
               "{\"status\": \"FAILURE\", \"reason\": \"$1\", \"data\": \"$1\"}"
    exit 1
}

# Wait network up
function wait_network_up(){
i=0 ; until wget -q -O /dev/null http://169.254.169.254/latest/meta-data/local-hostname ; do logger 'wait http://169.254.169.254/latest/meta-data/local-hostname'; sleep 1 ;  let i=i+1 ; [ $i -gt 180 ] && exit 1 ; done
return 0
}

# Loop on command until timeout
function retry_command() {
  RETRY_NB=10
  RETRY_DELAY_IN_SEC=1
  n=0
  result=1
  until [ $n -ge $RETRY_NB ] || [ $result -eq 0 ]
  do
    # exec command in arg
    eval $@
    result=$?
    if [ "$result" -gt 0 ] ; then
      sleep $RETRY_DELAY_IN_SEC
      ((n++))
    fi
    echo "# try $n/$RETRY_NB second for curl"
  done
  return $result
}
