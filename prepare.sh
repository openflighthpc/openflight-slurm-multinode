# PDSH package
yum install -y flight-pdsh

# SLURM & Munge Packages
yum install -y munge munge-libs perl-Switch numactl flight-slurm flight-slurm-devel flight-slurm-perlapi flight-slurm-torque flight-slurm-slurmd flight-slurm-example-configs flight-slurm-libpmi flight-slurm-slurmctld

# Install NFS Packages
yum install -y nfs-utils

# IPA 
dnf module reset -y idm
dnf module enable -y idm:DL1
dnf module install -y idm:DL1/dns
ansible-galaxy collection install 'community.general:>6.6.0' --upgrade
