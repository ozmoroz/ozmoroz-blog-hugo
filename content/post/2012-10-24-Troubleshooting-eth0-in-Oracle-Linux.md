---
Title: Troubleshooting eth0 in Oracle Linux
slug: troubleshooting-eth0-in-oracle-linux
Date: 2012-10-24
Author: Sergey Stadnik
Category: technology
Tags: [linux]
Summary: How to make eth0 autostart on Oracle Linux.
---

A few days ago I installed Oracle Linux in an Oracle VirtualBox VM. Once it was installed I found that eth0 interface wasn't starting upon boot.

![ifconfig eth0 isn't starting]({filename}/images/2012-10-24-oralinux1.png)

That was unusual. I am myself a Linux enthusiast, and I regularly download and install lots of distributions, and, by and large, network works in them out of the box.

Today I finally got around to troubleshooting this problem. It took me a couple of hours digging through the scripts, setting trace points, and reading logs; and here's what I found.

For the reference, this was my configuration:

-   Oracle VM VirtualBox 4.1.22 r80657
-   Host: Windows 7 64-bit
-   Linux: Oracle Linux Server release 6.3
-   Kernel 2.6.39-200.24.1.el6uek.x86\_64 on x86\_64

As I said, upon boot eth0 was down. If I tried to bring it up with `ifconfig eth0 up` it came up in IPV6 mode only, no IPV4:

![eth0 only comes up as IPV6]({filename}/images/2012-10-24-oralinux2.png)

Hm, weird. What was even more weird was that if I brought it up with `ifup eth0` instead of `ifconfig eth0 up`, IPV4 network started succesfully:

![IPV4 started successfully]({filename}/images/2012-10-24-oralinux3.png)

Obviously, these 2 were are different. The reason `ifup` worked was because it called `dhclient` to obtain an IP address from a DHCP server

![dhclient]({filename}/images/2012-10-24-oralinux4.png)

Whereas `ifconfig` didn’t make that call. And because the network interface did not have an IP address, it stayed down.

So, what is the difference between `ifup` and `ifconfig up`?

Well, `ifup` is actually a script located in  `/etc/sysconfig/network-scripts`.

During the system boot the network subsystem is brought up via startup
script `/etc/rc2.d/S10network`. That script goes through all the network interfaces it can find and
brings them up during the boot. What’s interesting, I found that it uses a set of configuration files
`/etc/sysconfig/network-scripts/ifcfg-*<interface_name></interface_name>*` to determine if a particular interface needs to be brought up during the boot time. There is one config file for each interface. I’m not sure
when they are created, maybe at install time.

In my case I found that one of the parameters in `ifcfg-eth0` file was `ONBOOT=no`.
Turned out the network startup script uses that parameter to determine if the particular interface should be brought up at the boot time.

So, I changed it to `ONBOOT=yes` and everything worked.
Now when the system starts, eth0 is up and running.

Problem solved!

**Update:**

So, the mystery is finally solved. There is "Connect automatically" checkbox on the installer's network configuration screen (item 10 [here](http://www.oracle-base.com/articles/linux/oracle-linux-6-installation.php)).
If this checkbox is unchecked, network interfaces do not come up at system start-up.

Many thanks to the Oracle Linix team for helping me in this investigation.