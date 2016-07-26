Why
===

The Visual Studio Emulator for Android and the Windows Phone emulator run on Hyper-V and make a bunch of changes to your networking configuration that you may not want, especially if you’re using Hyper-V for running other virtual machines.

Whenever you start the emulator it enumerates all network adapters and creates Hyper-V external networks for all of them. For WIFI networks it creates network bridges as well as Hyper-V external networks.

My problem is that I’m on a WIFI network that will not support bridged connections. DHCP packets are dropped and traffic will only flow to one machine at a time. Ideally I just want to run the emulator on a simple Hyper-V internal network and if it needs internet access I will use NAT.

What
====

This script modifies XDE so it doesn't create external switches OR delete invalid network adapters from the underlying Hyper-V VMs. It uses Mono.Cecil to modify the XDE executable and one of it's DLLS. That means you can configure external networks for the emulators yourself in Hyper-V however you want.

Tips
====
* Backups are made next to the modified files with an extension .backup
* As it runs against files in Program Files you will need to run as administrator.
* If you need the emulator to access the network you will need to add an adapter manually to the virtual machine in Hyper-V
* If you're running Xamarin apps in this emulator and they crash on startup then enable compatibility mode on the virtual CPU in Hyper-V
