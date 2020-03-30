# GameKitExample

[GameKit](https://developer.apple.com/documentation/gamekit) Leaderboard example code

## Step by step

1. Project configuration
   - Under _Signing & Capabilities_, choose a unique bundle identifier for your app target
   - Enable Game Center by clicking the _+ Capability_ button selecting _Game Center_
     <br /><br />
     <img alt="screenshot" src="https://raw.githubusercontent.com/mobilelabclass/MobileLabGameKitExample/master/screenshots/projectsettings.jpg" width="800" height="auto">
     <br /><br />
   - Visit [appstoreconnect.apple.com](appstoreconnect.apple.com) in your web browser. Create a new app under _My Apps_ and enter your app information. Choose the bundle id that you created in the first step. Note: you can enter whatever for SKU - it's just a private identifier for your own purposes.
     <br /><br />
     <img alt="screenshot" src="https://raw.githubusercontent.com/mobilelabclass/MobileLabGameKitExample/master/screenshots/bundleid.jpg" width="800" height="auto">
     <br /><br />
   - Select your new app and under the _Features_ tab, select _Game Center_.
   - Click the plus button under the _Leaderboard_ section and fill out the form according to your application needs. Remember the value that you set for Leaderboard ID as you will need this in your code.
     <br /><br />
     <img alt="screenshot" src="https://raw.githubusercontent.com/mobilelabclass/MobileLabGameKitExample/master/screenshots/leaderboard.jpg" width="800" height="auto">
     <br /><br />

## References

- [GameKit documentation](https://developer.apple.com/documentation/gamekit)
- [GameCenter programming guide](https://developer.apple.com/library/archive/documentation/NetworkingInternet/Conceptual/GameKit_Guide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40008304)
