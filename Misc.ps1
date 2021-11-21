
########################################
#region -- Manage Docker as a non-root user

# The Docker daemon binds to a Unix socket instead of a TCP port. By default that Unix socket is owned by
# the user root and other users can only access it using sudo. The Docker daemon always runs as the root user.

# If you don’t want to preface the docker command with sudo, create a Unix group called docker and add users
# to it. When the Docker daemon starts, it creates a Unix socket accessible by members of the docker group.
# To create the docker group and add your user:

# Create the docker group.
sudo groupadd docker

# Add your user to the docker group.
sudo usermod -aG docker $USER

# Log out and log back in so that your group membership is re-evaluated.

# If testing on a virtual machine, it may be necessary to restart the virtual machine for changes to take effect.
# On a desktop Linux environment such as X Windows, log out of your session completely and then log back in.
# On Linux, you can also run the following command to activate the changes to groups:
newgrp docker

# Verify that you can run docker commands without sudo.
docker run hello-world

#endregion

########################################
#region -- Visual Studio Code on Linux

# RHEL, Fedora, and CentOS based distributions#

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'


# Then update the package cache and install the package using dnf (Fedora 22 and above):

dnf check-update
sudo dnf install code


# Installing .rpm package manually
# ---------------------------------
# The VS Code .rpm package (64-bit) can also be manually downloaded and installed, however, auto-updating won't work unless the repository above is installed.
# Once downloaded it can be installed using your package manager, for example with dnf:

sudo dnf install <file>.rpm




#endregion

########################################
#region -- install dotnet-sdk-6.0 on RHEL8

# On RHEL 8 (for x64, arm64, and s390x), enter:
dnf install dotnet-sdk-6.0
dotnet --version
dotnet new --list

# The .NET 6 SDK and runtime container images are available from the Red Hat Container Registry.
# You can use the container images as standalone images and with OpenShift on all supported architectures:

$ podman run --rm registry.redhat.io/ubi8/dotnet-60 dotnet --version

#endregion

########################################
#region -- GCC on Windows
https://www.mingw-w64.org/downloads/
http://win-builds.org/doku.php
http://win-builds.org/doku.php/download_and_installation_from_windows
http://win-builds.org/1.5.0/win-builds-1.5.0.exe


# Configure VS Code for Microsoft C++
https://code.visualstudio.com/docs/cpp/config-msvc





#endregion

########################################
#region -- GCC on Linux

# GCC, the GNU Compiler Collection
https://gcc.gnu.org/


su
yum group list ids
yum group install "Development Tools"
yum --setopt=group_package_types=mandatory,default,optional groupinstall "Development Tools"

whereis gcc

gcc --version




# Test gcc C compiler with a sample foo.c program
# Create a file called foo.c as follows:

#include<stdio.h>
int main(void){
	printf("Hello World!\n");
	return 0;
}


# To compile foo.c into foo executable file, type:
$ cc foo.c -o foo

# To execute foo program, type:

$ ./foo
Hello World!

#endregion

########################################
#region -- RH repositiries
rhel-9-for-x86_64-appstream-beta-rpms

#endregion

########################################
#region -- Linux Integration services

# Once Linux Integration services are deployed, virtual machines running Linux distributions can use features
# like Live Migration, Jumbo Frames, VLAN Tagging and Trunking, support for Symmetric multiprocessing (SMP),
# Static IP Injection, VHDX resize, Virtual Fibre Channel, Live Virtual Machine Backup and the ability to perform
# hot adding and removal of memory using the Dynamic Memory feature of Hyper-V.
https://www.serverwatch.com/guides/installing-and-activating-hyper-v-linux-integration-services/

# The built-in Red Hat Enterprise Linux Integration Services drivers for Hyper-V (available since Red Hat Enterprise
# Linux 6.4) are sufficient for Red Hat Enterprise Linux guests to run using the high performance synthetic devices
# on Hyper-V hosts.These built-in drivers are certified by Red Hat for this use.
https://docs.microsoft.com/en-us/windows-server/virtualization/hyper-v/supported-centos-and-red-hat-enterprise-linux-virtual-machines-on-hyper-v


VHDX resize

# For built-in LIS, the "hyperv-daemons" package must be installed for this functionality.
ndf install hyperv-daemons
	#-- Package hyperv-daemons-0-0.37.20190303git.el9.x86_64 is already installed.

#endregion

########################################
#region -- Subscription-manager RHSCL

su -
subscription-manager repos --list | egrep rhscl

# If you don’t see any RHSCL repositories in the list, your subscription might not include it.
subscription-manager repos --list
subscription-manager repos --enable rhel-7-server-optional-rpms

#endregion

########################################
#region -- Build REDIS on Linux

https://developer.redis.com/create/from-source/

# Option 1
# https://redis.io/download
# https://download.redis.io/releases/redis-6.2.6.tar.gz
wget https://download.redis.io/releases/redis-6.2.6.tar.gz
tar xvzf redis-6.2.6.tar.gz
cd redis-6.2.6



# Option 2
# http://download.redis.io/redis-stable/
# http://download.redis.io/redis-stable.tar.gz
wget http://download.redis.io/redis-stable.tar.gz
tar xvzf redis-stable.tar.gz
cd redis-stable


# Build, Test
# -----------
make
make test


# Running Redis in src
# --------------------
To run Redis with the default configuration, just type:

    % cd src
    % ./redis-server

If you want to provide your redis.conf, you have to run it using an additional
parameter (the path of the configuration file):

    % cd src
    % ./redis-server /path/to/redis.conf

It is possible to alter the Redis configuration by passing parameters directly
as options using the command line. Examples:

    % ./redis-server --port 9999 --replicaof 127.0.0.1 6379
    % ./redis-server /etc/redis/6379.conf --loglevel debug

All the options in redis.conf are also supported as options using the command
line, with exactly the same name.



# Playing with Redis
# ------------------

You can use redis-cli to play with Redis. Start a redis-server instance,
then in another terminal try the following:

    % cd src
    % ./redis-cli
    redis> ping
    PONG
    redis> set foo bar
    OK
    redis> get foo
    "bar"
    redis> incr mycounter
    (integer) 1
    redis> incr mycounter
    (integer) 2
    redis>

You can find the list of all the available commands at https://redis.io/commands.



# INSTALL on this Linux machine
#-------------------------------
sudo cp src/redis-server /usr/local/bin/
sudo cp src/redis-cli /usr/local/bin/
# Or just using
sudo make install

# Alternatively
% cd utils
% ./install_server.sh


#endregion

########################################
#region -- Docker build REDIS-server on Alpine

https://registry.hub.docker.com/_/redis
https://github.com/docker-library/redis/blob/a04a6df0a45894e1a630db4e84e0c12c7bcf326a/6.2/alpine/Dockerfile

docker build -t redis-server .
docker run -d --name redis-server-thierry -p 6379:6379 	redis-server
docker ps
docker exec -ti redis-server-thierry redis-cli ping
docker exec -ti redis-server-thierry redis-cli info

docker rm redis-server-thierry --force

redis bins are here:	/usr/local/bin/
redis conf is here:
redis conf is here:
redis backup is here: /data/dump.rdb

redis conf is here: # Warning: no config file specified, using the default config.
# In order to specify a config file use redis-server /path/to/redis.conf



# Notes:

https://dl-cdn.alpinelinux.org/alpine/v3.14/main/x86_64/APKINDEX.tar.gz
https://dl-cdn.alpinelinux.org/alpine/v3.14/community/x86_64/APKINDEX.tar.gz





#endregion

########################################
#region -- Docker Build REDIS-cli on Alpine

FROM alpine
LABEL Author = "Thierry Brunet <Thierry.Brunet@outlook.com>"

ARG REDIS_VERSION="6.2.6"
ARG REDIS_DOWNLOAD_URL="http://download.redis.io/releases/redis-${REDIS_VERSION}.tar.gz"

RUN apk update && apk upgrade \
    && apk add --update --no-cache --virtual build-deps gcc make linux-headers musl-dev tar \
    && wget -O redis.tar.gz "$REDIS_DOWNLOAD_URL" \
    && mkdir -p /usr/src/redis \
    && tar -xzf redis.tar.gz -C /usr/src/redis --strip-components=1 \
    && rm redis.tar.gz \
    && make -C /usr/src/redis install redis-cli /usr/bin \
    && rm -r /usr/src/redis \
    && apk del build-deps \
    && rm -rf /var/cache/apk/*

CMD  ["redis-cli"]




# builds of the image
docker build -t thierry/redis-cli . --build-arg REDIS_VERSION=6.2.6

# For example the following command will ping to hostname with port 6379 and will delete container after finish:
docker run --rm --name redis-cli -it thierry/redis-cli redis-cli -h hostname -p 6379 ping

#endregion
########################################
#region -- Build REDIS docker image

https://programmerlib.com/build-a-basic-docker-image-using-dockerfile/

Create a dockerfile
Now let me show you hot to create to build Redis image with dockerfile.

Step 1: Preparation.
Create a clean directory and download Redis source code.

$ cd ~
$ mkdir docker-redis
$ cd docker-redis
$ wget https://download.redis.io/releases/redis-6.2.6.tar.gz
Step 2: Write Dockerfile
# base image: centos7
FROM centos:centos7

# install dependencies to compile redis source code
RUN ["yum" , "install" , "-y" ,"gcc","gcc-c++","net-tools","make"]

# set workdir to /usr/local
WORKDIR /usr/local

# copy a file to workdir
ADD redis-5.0.10.tar.gz .

# reset workdir to compile redis
WORKDIR /usr/local/redis-5.0.10/src

# install redis
RUN make && make install

# reset dir where redis is installed
WORKDIR /usr/local/redis-5.0.10

# expose a port
EXPOSE 6379

# run redis after container starts
CMD ["redis-server"]
Step 3: Build image.
Now we can build image using below command.

docker image build -t redis_demo .
In this command above, the -t parameter is used to specify the name of the image file, and a colon can also be used to specify the label. If not specified, the default label is latest. The last dot represents the path where the Dockerfile file is located. The above example is the current path.

Now run docker image ls to check result.

$ docker image ls


#endregion


########################################
#region -- Transition from Docker CLI to the Podman CLI

# brings with it a new concept of rootless containers. Whereby a docker user would
# need elevated privileges to build and run a docker container, podman does not.
# This makes podman images significantly safer to use.

https://medium.com/technopanti/docker-vs-podman-c03359fabf77

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

# Buildah is the builder of podman images. We can use buildah bud as a replacement
# for docker build. The bud is an acronym for build using dockerfile.

#endregion

########################################
#region -- Docker images for ASP.NET Core

https://docs.microsoft.com/en-us/aspnet/core/host-and-deploy/docker/building-net-docker-images?view=aspnetcore-6.0

# Download the sample by cloning the .NET Docker repository:
git clone https://github.com/dotnet/dotnet-docker

# Run the app locally
# --------------------
# Run the following command to build and run the app locally:
cd ~/projects/dotnet-docker/samples/aspnetapp/aspnetapp
dotnet run

# Go to http://localhost:5000 in a browser to test the app.

# Run in a Linux container
# ------------------------
# Navigate to the Dockerfile folder at dotnet-docker/samples/aspnetapp
cd ~/projects/dotnet-docker/samples/aspnetapp

# Run the following commands to build and run the sample in Docker:
docker build -t aspnetapp .
docker run -it --rm -p 5000:80 --name aspnetcore_sample aspnetapp

#endregion

########################################
#region -- DotNet Docker
https://github.com/dotnet/dotnet-docker
https://github.com/dotnet/dotnet-docker/tree/main/samples

# Build an image for Alpine, Debian or Ubuntu
# .NET multi-platform tags result in Debian-based images, for Linux. For example, you will pull a Debian-based image if you use a simple version-based tag, such as 6.0, as opposed to a distro-specific tag like 6.0-alpine.

# This sample includes Dockerfile examples that explicitly target Alpine, Debian and Ubuntu. Docker makes it easy to use alternate Dockerfiles by using the -f argument.

https://github.com/dotnet/dotnet-docker/blob/main/samples/dotnetapp/README.md

# The following example demonstrates targeting distros explicitly and also shows the size differences between the distros. Tags are added to the image name to differentiate the images.
docker build --pull -t dotnetapp:debian -f Dockerfile.debian-x64 .
docker build --pull -t dotnetapp:ubuntu -f Dockerfile.ubuntu-x64 .
docker build --pull -t dotnetapp:alpine -f Dockerfile.alpine-x64 .

# You can use docker images to see the images you've built and to compare file sizes:

# % docker images dotnetapp
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
dotnetapp           alpine              8933fb9821e8        8 seconds ago       87MB
dotnetapp           ubuntu              373df08a06ec        25 seconds ago      187MB
dotnetapp           debian              229dd121a96b        39 seconds ago      190MB
dotnetapp           latest              303eabf97376        56 seconds ago      190MB

# You can run any of the images you've just built with the following commands:
docker run --rm dotnetapp
docker run --rm dotnetapp:debian
docker run --rm dotnetapp:ubuntu
docker run --rm dotnetapp:alpine

# If you want to double check the distro of an application, you can do that by configuring a different entrypoint when you run the image, as you see in the following example.

% docker run --rm --entrypoint cat dotnetapp /etc/os-release
	# PRETTY_NAME="Debian GNU/Linux 10 (buster)"
	# NAME="Debian GNU/Linux"
	# VERSION_ID="10"
	# VERSION="10 (buster)"
	# VERSION_CODENAME=buster
	# ID=debian
	# HOME_URL="https://www.debian.org/"
	# SUPPORT_URL="https://www.debian.org/support"
	# BUG_REPORT_URL="https://bugs.debian.org/"

% docker run --rm --entrypoint cat dotnetapp:alpine /etc/os-release
	# NAME="Alpine Linux"
	# ID=alpine
	# VERSION_ID=3.10.3
	# PRETTY_NAME="Alpine Linux v3.10"
	# HOME_URL="https://alpinelinux.org/"
	# BUG_REPORT_URL="https://bugs.alpinelinux.org/"

#endregion


########################################
#region -- Alpine Linux

https://alpinelinux.org/releases/

https://dl-cdn.alpinelinux.org/alpine/v3.14/releases/x86_64/alpine-standard-3.14.3-x86_64.iso
https://dl-cdn.alpinelinux.org/alpine/v3.14/releases/x86_64/alpine-minirootfs-3.14.3-x86_64.tar.gz


#endregion


########################################
#region -- CoreOS Fedora Linux

https://getfedora.org/coreos?stream=stable

https://console.cloud.google.com/marketplace/product/fedora-coreos-cloud/fedora-coreos-stable?pli=1


#endregion

