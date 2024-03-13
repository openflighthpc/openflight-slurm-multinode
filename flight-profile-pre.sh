#!/bin/bash

NFS_SERVER=$((sudo -i /opt/flight/bin/flight hunter show $NFS_SERVER --plain 2>/dev/null | head -1 | awk 'END {if (NR == 0) exit 1 }') && echo $(sudo -i /opt/flight/bin/flight hunter show $NFS_SERVER --plain | head -1 | awk '{print $2}') || echo $NFS_SERVER)

ansible-playbook -i $INVFILE --extra-vars="cluster_name=$CLUSTERNAME default_username=$DEFAULT_USERNAME default_user_password=$DEFAULT_PASSWORD access_host=$ACCESS_HOST default_nfs_server=$NFS_SERVER compute_ip_range=$COMPUTE_IP_RANGE hunter_hosts=$HUNTER_HOSTS ipa_use=$IPA_USE ipa_domain=$IPA_DOMAIN secure_admin_password=$SECURE_ADMIN_PASSWORD" --tags pre $RUN_ENV/openflight-slurm-multinode/main.yml
