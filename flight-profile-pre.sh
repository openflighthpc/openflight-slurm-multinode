#!/bin/bash

IPA_SERVER=$((sudo -i /opt/flight/bin/flight hunter show $IPA_SERVER --plain 2>/dev/null | head -1 | awk 'END {if (NR == 0) exit 1 }') && echo $(sudo -i /opt/flight/bin/flight hunter show $IPA_SERVER --plain |head -1 |awk '{print $2}' |sed 's/\..*//g') || echo $IPA_SERVER)

ansible-playbook -i $INVFILE --extra-vars="cluster_name=$CLUSTERNAME default_username=$DEFAULT_USERNAME default_user_password=$DEFAULT_PASSWORD access_host=$ACCESS_HOST compute_ip_range=$COMPUTE_IP_RANGE hunter_hosts=$HUNTER_HOSTS ipa_use=$IPA_USE ipa_server=$IPA_SERVER ipa_domain=$IPA_DOMAIN secure_admin_password=$SECURE_ADMIN_PASSWORD" --tags pre $RUN_ENV/openflight-slurm-multinode/main.yml
