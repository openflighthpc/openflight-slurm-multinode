# OpenFlight Slurm Multinode

## Overview

An Ansible playbook to configure a Multi Node Research Environment sharing data through NFS, running SLURM and Flight User/Web Suite.

## Prereqs

The steps in `prepare.sh` have been performed on the system.

## Notes

This playbook _configures_ the services within it, it does not perform any installation. This is partnered with the Flight Solo image that can be found in the AWS Marketplace.

## Usage

- Login as root
- Clone repository
- Set variables
    - `cluster_name`: The name for this cluster to go by, it will appear in the command prompt and web suite
    - `default_nfs_server`: The hostname or IP of the default NFS server
        - This defaults to empty, if left empty then no NFS mounts will be setup. Additional mounts can be added to `roles/nfs/vars/main.yml` following the style of the existing mounts. The NFS servers to be setup will need to be done with this playbook so the `server` key must match the `inventory_hostname` of the NFS server to be configured.
    - `slurm_server`: The hostname or IP of the SLURM controller
        - This defaults to the first node in the `login` group as that will also be configured as the SLURM controller
    - `default_username`: The default user on the system (e.g. on a Flight Solo image this will be `flight`) 
    - `default_password`: The password to set for this user to enable access to Flight Web Suite (defaults to `0penfl1ght`)
    - `access_host`: The hostname or IP address that this system can be reached on, used for both Web Suite and Desktop sessions
    - `generate_certs`: Whether the playbook should attempt to generate SSL certs for the Web Suite (initially attempting a Let's Encrypt certificate and falling back to a self-signed if Let's Encrypt isn't able to reach the provided `access_host`) 
    - `compute_ip_range`: The network range for NFS server exports to be shared with
    - `hunter_hosts`: When set to true - this will make appropriate changes to `/etc/hosts` and system firewalls to trust hosts in [flight-hunter](https://github.com/openflighthpc/flight-hunter)
    - `ipa_use`: When set to true this will perform IPA operations to setup a server (optional) and clients and will require the following to be set appropriately
        - `ipa_server`: The short hostname of the IPA server
            - This defaults to the first node in the `ipa` group, if that doesn't exist then the string `infra01` will be used
        - `ipa_domain`: The domain to be used for IPA connections 
        - `secure_admin_password`: The password used for logging into the admin user and adding hosts to IPA
- Create ansible inventory file (e.g. `mycluster.inv`) that looks like the following (note: The `ipa` group is optional and only used if `ipa_use` is set to true) 
  ```shell
  [login]
  chead1

  [compute]
  cnode01
  cnode02

  [ipa]
  infra01
  ```
- Run the playbook 
  ```shell
  ansible-playbook -i mycluster.inv main.yml
  ```

## Other Usage Info

### Providing SLURM Configuration

If a SLURM config file is not provided then one will be generated. To provide a SLURM config file create one and place it at `files/{{cluster_name}}-slurm.conf`.

### Node-At-A-Time Configuration

If deploying with a node at a time then the generated slurm.conf file will not match, after all nodes have been added to the inventory and been configured, run the following to put a correct SLURM configuration in place:

```shell
ansible-playbook -i mycluster.inv --tags update main.yml
```
