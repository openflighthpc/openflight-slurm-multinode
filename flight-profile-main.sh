#!/bin/bash

LOGIN_NODE=$((sudo -i /opt/flight/bin/flight hunter show $LOGIN_NODE --plain 2>/dev/null | awk 'END {if (NR == 0) exit 1 }') && echo $(sudo -i /opt/flight/bin/flight hunter show $LOGIN_NODE --plain |awk '{print $2}') || echo $LOGIN_NODE)

ansible-playbook -i $INVFILE --limit $NODE --extra-vars="cluster_name=$CLUSTERNAME login_node=$LOGIN_NODE default_username=$DEFAULT_USERNAME default_user_password=$DEFAULT_PASSWORD access_host=$ACCESS_HOST compute_ip_range=$COMPUTE_IP_RANGE hunter_hosts=$HUNTER_HOSTS" $RUN_ENV/openflight-slurm-multinode/main.yml
