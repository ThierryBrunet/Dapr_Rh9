

##############
### Step 1 ### -- Transition from Docker CLI to the Podman CLI
##############
#region
# One of Podman's greatest advantages is its complete CLI compatibility with Docker.
# In fact, when building Podman, Docker users can adapt without any significant changes.
# For example, you can use the alias command to create a docker alias for Podman:
ssh rh9wroot
podman --version
# podman version 3.3.1
docker
yum -y install 'podman-docker'
docker --version
exit
#endregion


# Complete Podman Uninstall/Re-install
# ------------------------------------
# Sometimes it’s necessary to uninstall completely, and reinstall when testing software.

if ($false)
{
    Remove-Item -rf /etc/containers/* /var/lib/containers/* /etc/docker /etc/subuid* /etc/subgid*
    yum remove buildah skopeo podman containers-common atomic-registries docker

    # Remember to delete any users and their associated containers storage:

    Remove-Item -rf /home/fatherlinux/.local/share/containers/

    # Or:
    userdel -r fatherlinux

    # Fresh Install
    yum install podman buildah skopeo
}


# Install Docker Engine on RHEL
# ----------------------------
# https://docs.docker.com/engine/install/rhel/

# Remove podman
dnf -y remove podman

# Setup the repository
yum install -y yum-utils
# yum-config-manager --add-repo https://download.docker.com/linux/rhel/docker-ce.repo  # No docker-ce exists for Redhat
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo  # Therefore use CentOS repo

# https://www.linuxfordevices.com/tutorials/centos/dnf-command
yum-config-manager --help
yum-config-manager --dump
yum-config-manager --dump-variables
dnf list all
dnf search docker
dnf repolist all
dnf list installed
dnf list installed | grep docker
yum-config-manager --disablerepo https://download.docker.com/linux/rhel/docker-ce.repo

# Instrall Docker Engine
yum install docker-ce docker-ce-cli containerd.io
dnf install docker-ce docker-ce-cli containerd.io

dnf-config-manager --enable docker-ce-nightly | dnf-config-manager --disable docker-ce-nightly
yum-config-manager --enable docker-ce-test
dnf-config-manager --disable docker-ce-stable

# Install from Package
# --------------------
# https://download.docker.com/linux/rhel/
# https://download.docker.com/linux/rhel/docker-ce.repo
# https://download.docker.com/linux/centos/8/x86_64/stable/Packages/
# Downlaod all these packages from the Docker website
# - containerd.io-1.4.9-3.1.el8.x86_64.rpm
# - docker-ce-20.10.9-3.el8.x86_64.rpm
# - docker-ce-cli-20.10.9-3.el8.x86_64.rpm
# - docker-ce-rootless-extras-20.10.9-3.el8.x86_64.rpm
# - docker-scan-plugin-0.9.0-3.el8.x86_64.rpm

# Then copy them with WinSCP into the /home/thierry/Downloads folder

dnf remove podman
dnf remove buildah

# Install the RPM packages
# ------------------------
dnf install http://mirror.centos.org/centos/8/BaseOS/x86_64/os/Packages/libcgroup-0.41-19.el8.i686.rpm

dnf install /home/thierry/Downloads/containerd.io-1.4.9-3.1.el8.x86_64.rpm
dnf install /home/thierry/Downloads/docker-scan-plugin-0.9.0-3.el8.x86_64.rpm
dnf install /home/thierry/Downloads/docker-ce-cli-20.10.9-3.el8.x86_64.rpm
dnf install /home/thierry/Downloads/docker-ce-rootless-extras-20.10.9-3.el8.x86_64.rpm
dnf install /home/thierry/Downloads/docker-ce-20.10.9-3.el8.x86_64.rpm

# Alternatively, try this
# -----------------------
dnf install http://mirror.centos.org/centos/8/BaseOS/x86_64/os/Packages/libcgroup-0.41-19.el8.i686.rpm

dnf install https://download.docker.com/linux/centos/8/x86_64/stable/Packages/containerd.io-1.4.9-3.1.el8.x86_64.rpm
dnf install https://download.docker.com/linux/centos/8/x86_64/stable/Packages/docker-scan-plugin-0.9.0-3.el8.x86_64.rpm
dnf install https://download.docker.com/linux/centos/8/x86_64/stable/Packages/docker-ce-cli-20.10.9-3.el8.x86_64.rpm
dnf install https://download.docker.com/linux/centos/8/x86_64/stable/Packages/docker-ce-rootless-extras-20.10.9-3.el8.x86_64.rpm
dnf install https://download.docker.com/linux/centos/8/x86_64/stable/Packages/docker-ce-20.10.9-3.el8.x86_64.rpm

$docker_ce_repo = @"
[docker-ce-stable]
name=Docker CE Stable - x86_64
baseurl=https://download.docker.com/linux/centos/8/x86_64/stable
enabled=1
gpgcheck=1
gpgkey=https://download.docker.com/linux/centos/gpg

[docker-ce-stable-debuginfo]
name=Docker CE Stable - Debuginfo x86_64
baseurl=https://download.docker.com/linux/centos/8/debug-x86_64/stable
enabled=0
gpgcheck=1
gpgkey=https://download.docker.com/linux/centos/gpg

[docker-ce-stable-source]
name=Docker CE Stable - Sources
baseurl=https://download.docker.com/linux/centos/8/source/stable
enabled=0
gpgcheck=1
gpgkey=https://download.docker.com/linux/centos/gpg
"@
$docker_ce_repo | Out-File "/home/thierry/Downloads/docker-ce.repo" -Force

dnf config-manager --add-repo /home/thierry/Downloads/docker-ce.repo
dnf repolist -v

# Install dependancies
dnf install http://mirror.centos.org/centos/8/BaseOS/x86_64/os/Packages/libcgroup-0.41-19.el8.i686.rpm
dnf install docker-ce

# it WORKS !!!!
# ----------------
# Installed products updated.

# Installed:
#   docker-ce-3:20.10.10-3.el8.x86_64                              docker-ce-cli-1:20.10.10-3.el8.x86_64
#   docker-ce-rootless-extras-20.10.10-3.el8.x86_64                docker-scan-plugin-0.9.0-3.el8.x86_64

# Complete!
# [root@rh9w ~]#

# Test Docker
# -----------
systemctl enable --now docker
systemctl is-active docker
systemctl is-enabled docker

systemctl start docker
docker run hello-world

# Uninstall Docker Engine
# -----------------------
# Uninstall the Docker Engine, CLI, and Containerd packages:

# dnf remove docker-ce docker-ce-cli containerd.io

# Images, containers, volumes, or customized configuration files on your host are not automatically removed.

# To delete all images, containers, and volumes:

#  sudo rm -rf /var/lib/docker
#  sudo rm -rf /var/lib/containerd

#endregion


##############
### Step 2 ### -- Enter PS Remoting as root
##############
#region
Enter-PSSession -HostName 172.17.195.137 -KeyFilePath ~/.ssh/id_rsa_redhat9 -UserName root
#endregion


##############
### Step 3 ### -- Install Dapr CLI
##############
#region
wget -q https://raw.githubusercontent.com/dapr/cli/master/install/install.sh -O - | /bin/bash
dapr
#endregion


##############
### Step 3 ### -- Initialize Dapr
##############
#region

# Emulate Docker CLI using podman. Create /etc/containers/nodocker to quiet msg.
Get-ChildItem /etc/containers
New-Item -Path /etc/containers/nodocker -ItemType file


# Initialize Dapr
dapr init

# [root@rh9w ~]# dapr init
# ⌛  Making the jump to hyperspace...
# ℹ️  Installing runtime version 1.5.0
# ↖  Downloading binaries and setting up components...
# Dapr runtime installed to /root/.dapr/bin, you may run the following to add it to your path if you want to run daprd directly:
#     export PATH=$PATH:/root/.dapr/bin
# ✅  Downloading binaries and setting up components...
# ✅  Downloaded binaries and completed components set up.
# ℹ️  daprd binary has been installed to /root/.dapr/bin.
# ℹ️  dapr_placement container is running.
# ℹ️  dapr_redis container is running.
# ℹ️  dapr_zipkin container is running.
# ℹ️  Use `docker ps` to check running containers.
# ✅  Success! Dapr is up and running. To get started, go here: https://aka.ms/dapr-getting-started
# [root@rh9w ~]#

docker ps

# [root@rh9w ~]# docker ps
# CONTAINER ID   IMAGE               COMMAND                  CREATED         STATUS                   PORTS                                                 NAMES
# e1e3a04fdbcf   daprio/dapr:1.5.0   "./placement"            5 minutes ago   Up 5 minutes             0.0.0.0:50005->50005/tcp, :::50005->50005/tcp         dapr_placement
# 399aa0056000   openzipkin/zipkin   "start-zipkin"           5 minutes ago   Up 5 minutes (healthy)   9410/tcp, 0.0.0.0:9411->9411/tcp, :::9411->9411/tcp   dapr_zipkin
# 80c74b5b1b0c   redis               "docker-entrypoint.s…"   5 minutes ago   Up 5 minutes             0.0.0.0:6379->6379/tcp, :::6379->6379/tcp             dapr_redis
# [root@rh9w ~]#

ls $HOME/.dapr

    # bin  components  config.yaml

#endregion