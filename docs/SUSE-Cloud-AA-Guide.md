
# SUSE OpenStack Cloud 4 Admin Appliance Walk Through

## Prerequisites

Before you proceed with deploying the SUSE OpenStack Cloud Admin appliance you should:

* Review the following documentation:
  * [SUSE Cloud](https://www.suse.com/products/suse-cloud/) : This product documentation explains the overall highlights and contains links to technical information, other reference material and evaluation downloads.
  * [SUSE Cloud 4 Deployment Guide](https://www.suse.com/documentation/suse-cloud4/book_cloud_deploy/data/book_cloud_deploy.html) : As this is the basis behind the SUSE OpenStack Cloud 4 Admin appliance, it provides a great reference to the tasks being performed for you, plus those that will be required once the appliance is setup. It also contains further instructions on how to proceed on setting up your private cloud and operating it, along with [SUSE Cloud 4 Admin User Guide](https://www.suse.com/documentation/suse-cloud4/book_cloud_admin/data/book_cloud_admin.html) and [SUSE Cloud 4 End User Guide](https://www.suse.com/documentation/suse-cloud4/book_cloud_user/data/book_cloud_user.html) documents. Here you will also find the [Release Notes](https://www.suse.com/releasenotes/x86_64/SUSE-CLOUD/4/) which details changes from previous releases and any known issues.
    * _NOTE : This software appliance implements the SUSE Cloud 4 Deployment Guide, specifically the "Installing and Configuring the Administration Server" section, through the "Basic Network Configuration" step near the end._

* Download the [SUSE OpenStack Cloud 4 Admin](https://susestudio.com/a/Mrr6vv/suse-openstack-cloud-4-admin--2) appliance. It is pre-populated with all the right media, packages and software to speed up deployment, and is available in one of the following formats:
  * as virtual machine images compatible with either KVM, VMware, or other hypervisors
  * as preload ISO and USB images that are ideal for doing installations on physical machines

* Ensure you have sufficient system and network resources to deploy and use a private cloud instance. While the SUSE OpenStack Cloud 4 Admin appliance is deployed on a single system, or even virtual machine for evaluations purposes, at least two more systems, or virtual machines, are typically needed for the smallest, functional instance of a private cloud. Please refer to the above SUSE Cloud Deployment Guide for details on the resources needed for each of these systems. Also noted in the deployment guide are the specific details around the various network ranges, services and boundary conditions needed for a functional instance.

## Phase 1 - Prepare Initial Installation

With the prerequisites in hand, you can follow the steps below as you go through the installation of the SUSE OpenStack Cloud 4 Admin appliance. For the target SUSE Cloud Administration Server system, present the desired flavor of the appliance as a boot image, then:

* Select the default boot option to _**Install SUSE OpenStack Cloud 4 Admin**_ ![Image of SOC4A-boot](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SOC4A-boot.png?raw=true)
  * *CAUTION : Proceeding beyond this point will destroy **ALL** data on the primary, selected disk for the target system. In some cases you might have more than one disk listed. Be sure to select your desired root disk and select **Yes** to continue.* ![Image of SOC4A-destroy](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SOC4A-destroy.png?raw=true)

* Then wait as the raw image is
  * loaded to the disk you selected, ![Image of SOC4A-loading](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SOC4A-loading.png?raw=true)
  * verified, ![Image of SOC4A-verifying](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SOC4A-verifying.png?raw=true)
  * then expanded to fill the disk, and rebooted from the installed image ![Image of SOC4A-reboot](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SOC4A-reboot.png?raw=true)
    * _NOTE: This process may take a few minutes, as noted on the screen text, since the process executes some first boot steps for the required configuration of the SUSE Cloud Administration server._ ![Image of SOC4A-prep](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SOC4A-prep.png?raw=true)

## Phase 2 - Installation Localization and Configuration

Driven by a simplified series of YaST (Yet another Setup Tool) first boot dialogs, you will be prompted to interactively localize your installation and perform preliminary configurations steps. Many of these tasks are similar to a SUSE Linux Enterprise Server installation, so refer to the [SUSE Linux Enterprise Server Quick Start Guide](https://www.suse.com/documentation/sles11/book_quickstarts/data/art_sles_installquick.html) for more details.

* _NOTE : During the remainder of this document, you may interact with the following screens and menus using the **Alt** key and the highlighted character to perform that action, or simply use the **Tab** to navigate to the various fields._

* **Language and Keyboard Layout** - Select the desired values to be used during the remainder of the installation and for the installed system, then select _**Next**_. ![Image of SOC4A-language](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SOC4A-language.png?raw=true)

* **Password for the System Administrator** - Enter the desired values for _**Password for root User**_ and a matching entry in _**Confirm Password**_, followed by _**Next**_.
![Image of SOC4A-password](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SOC4A-password.png?raw=true)

* **Hostname and Domain Name** - Enter the desired values for _**Hostname**_ and _**Domain Name**_, followed by _**Next**_. ![Image of SOC4A-hostname](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SOC4A-hostname.png?raw=true)

  * _NOTE: The SUSE Cloud Administration server is required to have a fully qualified hostname plus domain name, so ensure both values are correctly entered._

* **Network Configuration II** - To modify the network configuration, select _**Change**_ followed by _**Network Interfaces**_ ![Image of SOC4A-network2](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SOC4A-network2.png?raw=true)
  * Then select _**Edit**_ to modify your network settings for the primary network interface (e.g. eth0). You might have more than one network interface for your configuration, but it's only necessary to configure the primary one at this time.
  * Choose either _**Dynamic Address**_ or _**Statically assigned IP Address**_ (recommended) along with entering the respective _**IP Address**_, _**Subnet Mask**_ and _**Hostname**_, then select _**Next**_.
  * _NOTE : The SUSE OpenStack Cloud 4 Admin appliance defaults to using a hostname of admin.cloud.default.net and static IP address of 192.168.124.10 (as shown), where the IP address corresponds to the default SUSE Cloud networking configuration from the deployment guide._

* **Clock and Time Zone** - For these settings, select the proper _**Region**_ and _**Time Zone**_, plus select whether your _**Hardware Clock is set to UTC**_, then select _**Next**_ ![Image of SOC4A-clock](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SOC4A-clock.png?raw=true)

* **Advance NTP Configuration** - Verify the various settings, changing as necessary to match your local environment preferences and _**OK** to continue. ![Image of SOC4A-ntp](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SOC4A-ntp.png?raw=true)

## Ready to Use

At this point, the SUSE OpenStack Cloud 4 Admin appliance has been prepared according to the relevant sections of the SUSE Cloud Deployment Guide, so select _**Finish**_. ![Image of SOC4A-installation_completed](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SOC4A-installation_completed.png?raw=true)

You may now login as the the root user, with the password you just setup, to your new SUSE Cloud Administration Server ![Image of SOC4A-login](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SOC4A-login.png?raw=true)

* _NOTE : This might be a good time to do a snapshot if you are running this in a virtualized environment. In this way, you have a point in time to restart with a mostly configured SUSE OpenStack Cloud 4 Admin appliance, before you further define the private cloud networks and finish the deployment._

Then complete the final operations to make your SUSE Cloud Administration server ready to use, basically:

* yast2 crowbar

* screen install-suse-cloud

After these two steps have been successfully completed, the SUSE Cloud Administration Server should be fully functional. More details may be found in the SUSE Cloud deployment guide to help guide you through these steps. After that you will be ready to deploy the various OpenStack services and resource nodes using the administrative web interface.

**Congratulations and have fun!**
