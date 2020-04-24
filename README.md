### Pinger

The app pings all IP addresses in a local network and when done, displays results in a list. For example, if your local network IP address is 192.168.1.x, the app should ping all of the IP addresses from 192.168.1.1 to 192.168.1.254 inclusively.

<p align="center">
  <img src="Pinger/Supporting Files/Git assets/Simulator Screen Shot - iPhone 11 Pro - 2020-04-24 at 16.27.13.png" width="500">
</p> 

* **Real-time connection**
  It uses socket.io for real-time connection to the server and sync its own database with the server.
* **Combine**
  Chat models use combine framework to communicate to eachother.
* **Database**
  It uses coredata to save messages in sqlite DB.
* **Dark-Mode**
  Pokoro supports dark-mode and light-mode in iOS 13.0

