

########################################
#region Visual Studio Code on Linux

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
#region install dotnet-sdk-6.0 on RHEL8

# On RHEL 8 (for x64, arm64, and s390x), enter:
dnf install dotnet-sdk-6.0
dotnet --version
dotnet new --list

# The .NET 6 SDK and runtime container images are available from the Red Hat Container Registry.
# You can use the container images as standalone images and with OpenShift on all supported architectures:

$ podman run --rm registry.redhat.io/ubi8/dotnet-60 dotnet --version

#endregion

########################################
#region GCC on Windows
https://www.mingw-w64.org/downloads/
http://win-builds.org/doku.php
http://win-builds.org/doku.php/download_and_installation_from_windows
http://win-builds.org/1.5.0/win-builds-1.5.0.exe


# Configure VS Code for Microsoft C++
https://code.visualstudio.com/docs/cpp/config-msvc





#endregion

########################################
#region GCC on Linux

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
#region RH repositiries
rhel-9-for-x86_64-appstream-beta-rpms

#endregion


########################################
#region Linux Integration services

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
#region Subscription-manager RHSCL

su -
subscription-manager repos --list | egrep rhscl

# If you don’t see any RHSCL repositories in the list, your subscription might not include it.
subscription-manager repos --list
subscription-manager repos --enable rhel-7-server-optional-rpms

#endregion


########################################
#region Build REDIS on Linux

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


Running Redis
-------------

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

Running Redis with TLS:
------------------

Please consult the [TLS.md](TLS.md) file for more information on
how to use Redis with TLS.

Playing with Redis
------------------

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



# INSTALL
#--------
sudo cp src/redis-server /usr/local/bin/
sudo cp src/redis-cli /usr/local/bin/
# Or just using
sudo make install

# Alternatively
% cd utils
% ./install_server.sh



#endregion


