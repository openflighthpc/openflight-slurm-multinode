#!/bin/bash

ansible-playbook -i $INVFILE --extra-vars="cluster_name=$CLUSTERNAME default_username=$DEFAULT_USERNAME default_user_password=$DEFAULT_PASSWORD access_host=$ACCESS_HOST nfs_server=$NFS_SERVER compute_ip_range=$COMPUTE_IP_RANGE hunter_hosts=$HUNTER_HOSTS ipa_use=$IPA_USE ipa_domain=$IPA_DOMAIN secure_admin_password=$SECURE_ADMIN_PASSWORD" --extra-vars="{"remove_node": [$NODE]}" --tags remove $RUN_ENV/openflight-slurm-multinode/remove.yml
