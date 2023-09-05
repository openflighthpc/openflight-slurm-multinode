#!/bin/bash

SLURM_SERVER=$((sudo -i /opt/flight/bin/flight hunter show $SLURM_SERVER --plain 2>/dev/null | awk 'END {if (NR == 0) exit 1 }') && echo $(sudo -i /opt/flight/bin/flight hunter show $SLURM_SERVER --plain |awk '{print $2}') || echo $SLURM_SERVER)
IPA_SERVER_FQDN=$((sudo -i /opt/flight/bin/flight hunter show $IPA_SERVER --plain 2>/dev/null | awk 'END {if (NR == 0) exit 1 }') && echo $(sudo -i /opt/flight/bin/flight hunter show $IPA_SERVER --plain |awk '{print $2}') || echo $IPA_SERVER)

ansible-playbook -i $INVFILE --extra-vars="cluster_name=$CLUSTERNAME nfs_server=$NFS_SERVER slurm_server=$SLURM_SERVER default_username=$DEFAULT_USERNAME default_user_password=$DEFAULT_PASSWORD access_host=$ACCESS_HOST compute_ip_range=$COMPUTE_IP_RANGE hunter_hosts=$HUNTER_HOSTS ipa_fqdn=$IPA_SERVER_FQDN secure_admin_password=$SECURE_ADMIN_PASSWORD" --tags update $RUN_ENV/openflight-slurm-multinode/main.yml
