# SUSE Cloud Admin Appliance Walk Through

## Prerequisites

Before you proceed with deploying the SUSE Cloud Admin Appliance you should:

* Review the following documentation:
  * [SUSE Cloud 3](https://www.suse.com/products/suse-cloud/) : This explains the overall highlights of the product, and contains links to technical information, other reference material and evaluation downloads.
  * [SUSE Cloud 3 Deployment Guide](https://www.suse.com/documentation/suse-cloud3/book_cloud_deploy/data/book_cloud_deploy.html) : As this is the basis behind the SUSE Cloud Admin Appliance, it provides a great reference to the tasks being performed for you, plus those that will be required once the appliance is setup. It also contains further instructions on how to proceed on setting up your private cloud and operating it.

* Download the SUSE Cloud Admin Appliance in one the following flavors:
  * [SUSE Cloud 3 Admin](https://susestudio.com/a/Mrr6vv/suse-cloud-3-admin) : This image incorporates the SUSE Cloud 3 Deployment Guide and automates it through a simple script and sets of processes. It is pre-populated with all of the right media in order to speed things up for deployment. It will download all patches and updates for the required repositories of software which could take about an hour depending on your internet speed. This image is intended to facilitate production installations of SUSE Cloud instances.
  * [SUSE Cloud 3 Admin Embedded](https://susestudio.com/a/Mrr6vv/suse-cloud-3-admin-embedded) : This Embedded version is based upon the previous image, yet has all of the software repository content pre-populated so you do not have to wait for them to be mirrored down. This image is quite useful to evaluate and get a private cloud instance up and running quickly.
  * *NOTE : The remainder of this document will call out areas where one flavor is materially distinct from the other.*

* Ensure you have sufficient system and network resources to deploy and use a private cloud instance. While the SUSE Cloud Admin Appliance is deployed on a single system, or even virtual machine for evaluations purposes, at least two more systems are typically needed for the smallest, functional instance of a private cloud. Please refer to the above SUSE Cloud Deployment Guide for details on the resources needed for each of these systems. Also noted in the deployment guide are the specific details around the various network ranges, services and boundary conditions needed for a functional instance.

## Initial Installation

With the prerequisites in hand, you can follow the steps below as you go through the installation of the SUSE Cloud Admin Appliance.

* Take the default boot option to ***Install SUSE Cloud Admin*** (or ***Install SUSE Cloud Admin Embedded***, as appropriate)
  * *CAUTION : This will destroy **ALL** data on the primary, selected disk. In some cases you might have more than one disk listed. Be sure to select your desired root disk and select **Yes** to continue.*
![Image of Cloud-Admin1] (https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/Cloud-Admin1.png?raw=true)

* Then wait until the raw image is
  * loaded, unpacked and deployed to the disk you selected
![Image of Cloud-Admin2] (https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/Cloud-Admin2.png?raw=true)
  * followed by the install image being verified and expanded to fit the disk.

* At this point the system will start booting from the installed image.
  * *NOTE: This process may take a few minutes since it executes some first boot steps for the configuration of the SUSE Cloud Administration server. You may see it extracting ISO images to specific locations on disk and installing the proper software required.*

## Installation Localization and Configuration

Driven by an initial series of YaST (Yet another Setup Tool) first boot dialogs, you will be prompted to interactively localize your installation and perform preliminary configurations steps. Many of these tasks are similar to a SUSE Linux Enterprise Server installation, so refer to the [SUSE Linux Enterprise Server Quick Start Guide](https://www.suse.com/documentation/sles11/book_quickstarts/data/art_sles_installquick.html) for more details.

* *NOTE : During the remainder of this document, you may interact with the following screens and menus using the **Alt** key and the highlighted character to perform that action, or simply use the **Tab** to navigate to the various fields.*

1. Select the Language to be used during the remainder of the installation and for the installed system, then select ***Next***.
![Image of Cloud-Admin3] (https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/Cloud-Admin3.png?raw=true)

2. Select the appropriate ***Keyboard Layout*** and then select ***Next***.
![Image of Cloud-Admin4] (https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/Cloud-Admin4.png?raw=true)

3. Enter the desired ***Hostname*** and ***Domain Name***, followed by ***Next***.
![Image of Cloud-Admin5] (https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/Cloud-Admin5.png?raw=true)
  * *NOTE: The SUSE Cloud Administration server is required to have a fully qualified hostname plus domain name, so ensure both values are entered.*

4. For the Network Configuration, select ***Change*** Network Interfaces...
![Image of Cloud-Admin6] (https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/Cloud-Admin6.png?raw=true)

5. Select ***Edit*** to modify your network settings for the primary network interface (e.g. eth0). You might have more than one network interface for your configuration, but it's only necessary to configure the primary one at this time.

6. Choose either ***Dynamic Address*** or ***Statically assigned IP Address*** (recommended) along with entering the respective ***IP Address***, ***Subnet Mask*** and ***Hostname***, then select ***Next***.
![Image of Cloud-Admin9] (https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/Cloud-Admin9.png?raw=true)
  * *NOTE : The default SUSE Cloud Admin Appliance defaults to using a static IP address of 192.168.124.10 (as shown), which corresponds to the default SUSE Cloud networking configuration from the deployment guide.*

7. Select ***Hostname/DNS*** and fill in the IP Addresses for the ordered list of servers providing that information. 
![Image of Cloud-Admin10] (https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/Cloud-Admin10.png?raw=true)
  * *NOTE : As shown, for the name servers you might configure the IP address of the SUSE Cloud Admin Server, since it eventually becomes a DNS server for your private cloud instance. In addition, you may configure appropriate addresses for the subnet gateway, if that provides DNS services, the [Google Public Domain Name System](https://developers.google.com/speed/public-dns/) resolution service for externally routed DNS. Use the values of your internal DNS servers specific to your environment and policy, however what you see here can be used for a lab setup.*

8. When using a static IP configuration, select ***Routing*** and enter the ***Default Gateway***, then select ***OK***. Then select ***Next*** to continue and save the network configuration.
![Image of Cloud-Admin11] (https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/Cloud-Admin11.png?raw=true)
 * *NOTE : Your value may be different than shown, so please adjust according to your local network configurations settings.*

9. Setup the Clock and Time Zone settings. Select the proper ***Region*** and ***Time Zone***, plus select whether your ***Hardware Clock is set to UTC***
![Image of Cloud-Admin12] (https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/Cloud-Admin12.png?raw=true)

10. Then ***Change*** the Date and Time and NTP configuration, as necessary, making sure to synchronize with an available NTP Server. Select your NTP Server from the list or configure one manually if you have an internal NTP Server available for use. Select ***Accept*** when finished and ***Next** to save the time setting changes.
![Image of Cloud-Admin13] (https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/Cloud-Admin13.png?raw=true)

11. If needed, setup the ***Proxy Configuration*** by selecting ***Enable Proxy*** and entering the appropriate settings. No changes are needed if you do not require a proxy to access external network resources. Then select ***Finish*** to save the proxy settings.
![Image of Cloud-Admin14] (https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/Cloud-Admin14.png?raw=true)

12. The Novell Customer Center Configuration is used to activate the SUSE Linux Enterprise Server operating system for support and to obtain software updates. There are a few options at this point:
![Image of Cloud-Admin15] (https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/Cloud-Admin15.png?raw=true)
  * select ***Configure Later*** to skip over this step for now or if external internet access is not available, then ***Next***and proceed to the NU Configuration step
  * if you have access to a local SMT server, select ***Advanced*** and enter the information in the ***Local Registration Server*** settings, and skip to the NU Configuration step
  * by selecting ***Next*** from the above screen as shown, the host will first check connectivity to the Novell Customer Center,
![Image of Cloud-Admin16] (https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/Cloud-Admin16.png?raw=true)
  * then you will then be presented with a W3M Browser where you can use ***Tab*** to skip between fields and ***Enter*** to type in a field. Enter your email address that is associated with your Novell Customer Center account and also enter your activation code for SUSE Linux Enterprise Server 11 SP3 unless you want to use an evaluation key then just leave it blank. When done, ***Submit***, hit ***Enter*** and then Type ***q*** then ***y*** to return back to the curses menu where it will start adding the proper remote product and update repositories to your system.
    * *NOTE : Activation Codes for a 60 day evaluation period may also be obtained at [http://download.suse.com] by selecting **SUSE Linux Enterprise Server 11 SP3 for AMD64/Intel64** followed by **Get Activation Code***
![Image of Cloud-Admin17] (https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/Cloud-Admin17.png?raw=true)
  * After the proper remote product and update repositories are added to this host, the available updates will be shown. Select ***Accept*** to apply the available updates.
    * *NOTE : The Online Update process will take a few moments to complete and also may require two sessions, the first to update the package manager and the second to update the remaining packages*
![Image of Cloud-Admin20] (https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/Cloud-Admin20.png?raw=true)

13. At the NU Configuration screen, a couple of options exist, depending upon your connectivity to the internet and whether you wish to configure the SMT service:
  * if you are unable to access internet based sites or do not wish to setup the SMT service now, enter a bogus ***User*** and ***Password***, then ***OK***, and, then ***Skip Registration*** and ***Yes, Skip it***
  * or enter the NCC ***User*** and ***Password*** fields, then ***Test*** your configuration. If successful, then select ***OK*** to continue
![Image of Cloud-Admin18] (https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/Cloud-Admin18.png?raw=true)
  * *NOTE : The User and Password required here are your NCC mirroring credentials. Follow the steps noted in [SMT Guide](https://www.suse.com/documentation/smt11/book_yep/data/smt_mirroring_getcredentials.html)*

14. Next, you may be asked for a MySQL Database root password in order to proceed. Enter the desired password in the fields provided and select ***OK***.

15. As part of the SMT setup, managing the system certificate authority will be required. A prerequisite step is to set the password for the root user, so enter that in both the ***Password*** and ***Confirm Password*** fields, then select ***OK***
![Image of Cloud-Admin19] (https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/Cloud-Admin19.png?raw=true)
  * if you elected to skip the configuration of SMT, you may ***Skip*** the CA Management setup
  * or to fully configure SMT, select ***Next*** to create the certificate

16. At this point, the configured SMT service will finish its setup and configuration, then proceed to verify and update all its repositories to the latest content.
![Image of Cloud-Admin21] (https://github.com/cseader/suse-cloud-appliances/blob/master/docs/images/Cloud-Admin21.png?raw=true)

## Ready to Use
At this point, the SUSE Cloud Admin Appliance has been prepared according to the SUSE Cloud Deployment Guide. Login, with the root user and the password you supplied during the setup, to your SUSE Cloud Administration Server and you should see the following dialogue:
  * *NOTE : This might be a good time to do a snapshot if you are running this in a virtualized environment. In this way, you have a point in time to restart with a mostly configured SUSE Cloud Admin Appliance, before you further define the private cloud networks and finish the deployment.* 

>                   ____
>                 /@    ~-.
>                 \/ __ .- |     SUSE Cloud 3
>                  // //  @ 
>
>To finish setting up SUSE Cloud 3 you will need to define the network.
>To help you with the network configuration refer to the deployment guide
>and companion deployment questionnaire.
>
>execute yast2 crowbar
>
>Once your network settings are all defined then continue the crowbar install
>
>execute screen install-suse-cloud
>
>Before you proceed with install-suse-cloud its important that
>the network settings are properly defined and that you have 
>everything right otherwise you will need to start over.

Following these few remaining steps will complete the SUSE Cloud Admin Appliance installation and allow you to build a fully functional private cloud instance.
As noted in the SUSE Cloud deployment guide, you are now ready to deploy the various OpenStack services and resource nodes using the administrative web interface.

Congratulations and have fun!
