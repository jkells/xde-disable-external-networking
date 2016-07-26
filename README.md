Why
===

The Visual Studio Emulator for Android and the Windows Phone emulator run on Hyper-V and make a bunch of changes to your networking configuration that you may not want, especially if you’re using Hyper-V for running other virtual machines.

Whenever you start the emulator it enumerates all network adapters and creates Hyper-V external networks for all of them. For WIFI networks it creates network bridges as well as Hyper-V external networks.

My problem is that I’m on a WIFI network that will not support bridged connections. DHCP packets are dropped and traffic will only flow to one machine at a time. Ideally I just want to run the emulator on a simple Hyper-V internal network and if it needs internet access I will use NAT.

If your having problem starting the emulator or networking isn't working as expected, this script will disable the configuration of external switches and the removal of custom network adapters from the virtual machines created by the emulator. It uses Mono.Cecil to modify the XDE executable and one of it's DLLS.

* Backups are made next to the modified files with an extension .backup

* As it runs against files in Program Files you will need to run as administrator.

* If you need the emulator to access the network you will need to add an adapter manually to the virtual machine in Hyper-V

Tips
====
If you're running Xamarin apps in this emulator and they crash on startup then enable compatibility mode on the virtual CPU in Hyper-V
