
# SUSE Cloud Admin Appliance Walk Through

## Prerequisites

Before you proceed with deploying the SUSE Cloud Admin Appliance you should:

* Review the following documentation:
  * [SUSE Cloud 3](https://www.suse.com/products/suse-cloud/) : This product documentation explains the overall highlights and contains links to technical information, other reference material and evaluation downloads.
  * [SUSE Cloud 3 Deployment Guide](https://www.suse.com/documentation/suse-cloud3/book_cloud_deploy/data/book_cloud_deploy.html) : As this is the basis behind the SUSE Cloud Admin Appliance, it provides a great reference to the tasks being performed for you, plus those that will be required once the appliance is setup. It also contains further instructions on how to proceed on setting up your private cloud and operating it, along with [SUSE Cloud 3 Admin User Guide](https://www.suse.com/documentation/suse-cloud3/book_cloud_admin/data/book_cloud_admin.html) and [SUSE Cloud 3 End User Guide](https://www.suse.com/documentation/suse-cloud3/book_cloud_user/data/book_cloud_user.html) documents.
    * _NOTE : This software appliance implements the SUSE Cloud 3 Deployment Guide, specifically the "Installing and Configuring the Administration Server" section, through the "Custom Network Configuration" step near the end._

* Download the SUSE Cloud Admin Appliance in one the following flavors:
  * [SUSE Cloud 3 Admin](https://susestudio.com/a/Mrr6vv/suse-cloud-3-admin) : This image incorporates the SUSE Cloud 3 Deployment Guide and automates it through a simple script and sets of processes. It is pre-populated with all of the right media in order to speed things up for deployment. It will download all patches and updates for the required repositories of software which will take some time depending on your Internet connection speed/bandwidth. This image is intended to facilitate production installations of SUSE Cloud instances.
  * [SUSE Cloud 3 Admin Embedded](https://susestudio.com/a/Mrr6vv/suse-cloud-3-admin-embedded) : This Embedded version is based upon the previous image, yet has all of the software repository content pre-populated so you do not have to wait for them to be mirrored down. This image is quite useful to evaluate and get a private cloud instance up and running quickly (typically in 15 minutes or less).
  * _NOTE : The remainder of this document will call out areas where one flavor is materially distinct from the other._

* Ensure you have sufficient system and network resources to deploy and use a private cloud instance. While the SUSE Cloud Admin Appliance is deployed on a single system, or even virtual machine for evaluations purposes, at least two more systems, or virtual machines, are typically needed for the smallest, functional instance of a private cloud. Please refer to the above SUSE Cloud Deployment Guide for details on the resources needed for each of these systems. Also noted in the deployment guide are the specific details around the various network ranges, services and boundary conditions needed for a functional instance.

## Phase 1 - Prepare Initial Installation of the Appliance

With the prerequisites in hand, you can follow the steps below as you go through the installation of the SUSE Cloud Admin Appliance. For the target SUSE Cloud Administration Server system, present the desired flavor of the appliance as a boot image, then:

* Select the default boot option to _**Install SUSE Cloud Admin**_ (shown, or _**Install SUSE Cloud Admin Embedded**_, as appropriate) ![Image of SC3A-boot](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SC3A-boot.png?raw=true)
  * *CAUTION : Proceeding beyond this point will destroy **ALL** data on the primary, selected disk for the target system. In some cases you might have more than one disk listed. Be sure to select your desired root disk and select **Yes** to continue.*
![Image of SC3A-destroy](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SC3A-destroy.png?raw=true)

* Then wait as the raw image is
  * loaded to the disk you selected, ![Image of SC3A-loading](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SC3A-loading.png?raw=true)
  * verified, ![Image of SC3A-verifying](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SC3A-verifying.png?raw=true)
  * and then expanded to fill the disk.

* At this point the system will boot from the installed image.
  * _NOTE: This process may take a few minutes since it executes some first boot steps for the configuration of the SUSE Cloud Administration server._ ![Image of SC3A-prep](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SC3A-prep.png?raw=true)

## Phase 2 - Installation Localization and Configuration

Driven by an initial series of YaST (Yet another Setup Tool) first boot dialogs, you will be prompted to interactively localize your installation and perform preliminary configurations steps. Many of these tasks are similar to a SUSE Linux Enterprise Server installation, so refer to the [SUSE Linux Enterprise Server Quick Start Guide](https://www.suse.com/documentation/sles11/book_quickstarts/data/art_sles_installquick.html) for more details.

* _NOTE : During the remainder of this document, you may interact with the following screens and menus using the **Alt** key and the highlighted character to perform that action, or simply use the **Tab** to navigate to the various fields._

* **Language** - Select the desired language to be used during the remainder of the installation and for the installed system, then select _**Next**_.  ![Image of SC3A-language](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SC3A-language.png?raw=true)

* **Keyboard Configuration** - Select the appropriate _**Keyboard Layout**_ and then select _**Next**_. ![Image of SC3A-keyboard](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SC3A-keyboard.png?raw=true)

* **Hostname and Domain Name** - Enter the desired values for _**Hostname**_ and _**Domain Name**_, followed by _**Next**_.
![Image of SC3A-hostname](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SC3A-hostname.png?raw=true)
  * _NOTE: The SUSE Cloud Administration server is required to have a fully qualified hostname plus domain name, so ensure both values are correctly entered._

* **Network Configuration II** - To modify the network configuration, select _**Change**_ followed by _**Network Interfaces**_ ![Image of SC3A-network2](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SC3A-network2.png?raw=true)
  * Then select _**Edit**_ to modify your network settings for the primary network interface (e.g. eth0). You might have more than one network interface for your configuration, but it's only necessary to configure the primary one at this time.
  * Choose either _**Dynamic Address**_ or _**Statically assigned IP Address**_ (recommended) along with entering the respective _**IP Address**_, _**Subnet Mask**_ and _**Hostname**_, then select _**Next**_.
![Image of SC3A-network-edit](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SC3A-network-edit.png?raw=true)
  * _NOTE : The SUSE Cloud Admin Appliance defaults to using a static IP address of 192.168.124.10 (as shown), which corresponds to the default SUSE Cloud networking configuration from the deployment guide._

  * Select _**Hostname/DNS**_ and fill in the IP Addresses for the ordered list of servers providing that information. ![Image of SC3A-dns](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SC3A-dns.png?raw=true)
    * _NOTE : As shown, for the name servers you might configure the IP address of the SUSE Cloud Admin Server, since it eventually becomes a DNS server for your private cloud instance. In addition, you may configure appropriate addresses for the subnet gateway, if that provides DNS services, the [Google Public Domain Name System](https://developers.google.com/speed/public-dns/) resolution service for externally routed DNS. Use the values of your internal DNS servers specific to your environment and policy, however what you see here can be used for a lab setup._

  * When using a static IP configuration, select _**Routing**_ and enter the _**Default Gateway**_, then select _**OK**_. Then select _**Next**_ to continue and save the network configuration. ![Image of SC3A-routing](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SC3A-routing.png?raw=true)
 * _NOTE : Your value may be different than shown, so please adjust according to your local network configurations settings._

* **Clock and Time Zone** - For these settings, select the proper _**Region**_ and _**Time Zone**_, plus select whether your _**Hardware Clock is set to UTC**_ ![Image of SC3A-clock](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SC3A-clock.png?raw=true)
  * Then _**Change**_ the Date and Time and NTP configuration, as necessary, making sure to synchronize with an available NTP Server. Select your NTP Server from the list or configure one manually if you have an internal NTP Server available for use. Select _**Accept**_ when finished and _**Next** to save the time setting changes. ![Image of SC3A-ntp](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SC3A-ntp.png?raw=true)

* **Proxy Configuration** - If needed, setup the _**Proxy Configuration**_ by selecting _**Enable Proxy**_ and entering the appropriate settings. No changes are needed if you do not require a proxy to access external network resources. Then select _**Finish**_ to save the proxy settings. ![Image of SC3A-proxy](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SC3A-proxy.png?raw=true)

> _NOTE : For SUSE Cloud 3 Admin Embedded flavor, the configuration phase is complete, you may now skip to the **Prepare SUSE Cloud 3 Admin** step._

* **Novell Customer Center Configuration** - To activate the SUSE Linux Enterprise Server operating system for support and to obtain software updates, there are a few options at this point: ![Image of SC3A-ncc](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SC3A-ncc.png?raw=true)
  * select _**Configure Later**_ to skip over this step for now or if external Internet access is not available, then _**Next**_ and proceed to the NU Configuration step
  * if you have access to a local SMT server, select _**Advanced**_ and enter the information in the _**Local Registration Server**_ settings, and skip to the NU Configuration step
  * by selecting _**Next**_ from the above screen as shown, the host will first check connectivity to the Novell Customer Center ![Image of SC3A-ncc-manual](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SC3A-ncc-manual.png?raw=true)
  * then you will then be presented with a W3M Browser where you can use _**Tab**_ to skip between fields and _**Enter**_ to type in a field. Enter your email address that is associated with your Novell Customer Center account and also enter your activation code for SUSE Linux Enterprise Server 11 SP3 unless you want to use an evaluation key then just leave it blank and when done, _**Submit**_ ![Image of SC3A-Cloud-ncc-w3m](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SC3A-ncc-w3m.png?raw=true)
    * _NOTE : Activation Codes for a 60 day evaluation period may also be obtained at [http://download.suse.com] by selecting **SUSE Linux Enterprise Server 11 SP3 for AMD64/Intel64** followed by **Get Activation Code**_
  * when complete type _**q**_ then _**y**_ to exit this browser and return back to the curses menu where it will start adding the proper remote product and update repositories to your system. ![Image of SC3A-Cloud-ncc-w3m-close](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SC3A-ncc-w3m-close.png?raw=true)
  * After the proper remote product and update repositories are added to this host, the available updates will be shown and can be applied. Select _**Accept**_ to apply the available updates. ![Image of SC3A-update](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SC3A-update.png?raw=true)
    * _NOTE : The Online Update process will take a few moments to complete and also may require two sessions, the first to update the package manager (shown) and the second to update the remaining packages. Then select **OK** to complete the Novell Customer Center Configuration._ ![Image of SC3A-ncc-success](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SC3A-ncc-success.png?raw=true)

* **NU Configuration** - Used to enable and configure the SUSE [Subscription Management Tool](https://www.suse.com/documentation/smt11/) to mirror necessary updates, a couple of options exist, depending upon your connectivity to the Internet and whether you wish to configure the SMT service:
  * if you are unable to access Internet-based sites or do not wish to setup the SMT service now, enter a bogus _**User**_ and _**Password**_, then _**OK**_, and, then _**Skip Registration**_ and _**Yes, Skip it**_
  * or enter the NCC _**User**_ and _**Password**_ fields, then _**Test**_ your configuration. If successful, then select _**OK**_ to continue ![Image of SC3A-smt](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SC3A-smt.png?raw=true)
  * *NOTE : The User and Password required here are your NCC mirroring credentials. Follow the steps noted in [SMT Guide](https://www.suse.com/documentation/smt11/book_yep/data/smt_mirroring_getcredentials.html)*
  * Next, you may be asked for a MySQL Database root password in order to proceed. Enter the desired password in the fields provided and select _**OK**_. ![Image of SC3A-mysql](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SC3A-mysql.png?raw=true)
  * As part of a functioning SMT setup, creating a system certificate will be required. Select _**Run CA Management**_ to complete this step or _**Skip**_ if you want to defer setup of the SMT server. ![Image of SC3A-certificate](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SC3A-certificate.png?raw=true)
  * A prerequisite step for a system certificate is to set the password for the root user, so enter that in both the _**Password**_ and _**Confirm Password**_ fields, then select _**OK**_ ![Image of SC3A-root-password](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SC3A-root-password.png?raw=true)
    * _NOTE : Entering the password at this step sets the new root, superuser password for the installed system, so take care to choose a reasonable, memorable password._
  * then select _**Next**_ to create the certificate ![Image of SC3A-certificate-create](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SC3A-certificate-create.png?raw=true)
  * and the Any remaining operating system updates will now be applied to the system. ![Image of SC3A-ncc-complete](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SC3A-ncc-complete.png?raw=true)
  * At this point, the configured SMT service will finish its setup and configuration ![Image of SC3A-smt-complete](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SC3A-smt-complete.png?raw=true)
  * then verify and update all its repositories to the latest content. ![Image of SC3A-smt-mirror](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SC3A-smt-mirror.png?raw=true)
    * _NOTE : This will take a considerable amount of time, depending upon your Internet connection speed/bandwidth, as SUSE Linux Enterprise Server and SUSE Cloud packages and updates are mirrored._

* **Prepare SUSE Cloud 3 Admin** - Regardless of which flavor is used, the signal for a successful completion will denote **Preparation #2 Complete!** (as shown) ![Image of SC3A-prep2](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SC3A-prep2.png?raw=true)


## Ready to Use
At this point, the SUSE Cloud Admin Appliance has been prepared according to the relevant sections of the SUSE Cloud Deployment Guide. Login as the the root user your new SUSE Cloud Administration Server where you should see the following guidance as what to do next. ![Image of SC3A-login](https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/SC3A-login.png?raw=true)
  * _NOTE : For both flavors of the appliance, the default root password is "linux", unless you specifically set this in the **NU Configuration** steps above for the non-embedded flavor._
  * _NOTE : This might be a good time to do a snapshot if you are running this in a virtualized environment. In this way, you have a point in time to restart with a mostly configured SUSE Cloud Admin Appliance, before you further define the private cloud networks and finish the deployment._

Following these two remaining steps to complete the SUSE Cloud Admin Appliance installation and allow you to build a fully functional private cloud instance.  More details may be found in the SUSE Cloud deployment guide to help guide you through these steps. After that you will be ready to deploy the various OpenStack services and resource nodes using the administrative web interface.

**Congratulations and have fun!**
