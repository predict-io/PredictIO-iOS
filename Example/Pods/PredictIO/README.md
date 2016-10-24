# PredictIO-iOS
predict.io offers mobile developers a battery-optimized SDK to get normalised sensor results. Available for iOS and Android. It gives you real-time updates when a user starts or ends a journey. With this trigger come contextual details for the mode of transportation (car vs. non-car).

[![Version](https://img.shields.io/cocoapods/v/PredictIO.svg?style=flat)](http://cocoapods.org/pods/PredictIO)
[![License](https://img.shields.io/cocoapods/l/PredictIO.svg?style=flat)](http://cocoapods.org/pods/PredictIO)
[![Platform](https://img.shields.io/cocoapods/p/PredictIO.svg?style=flat)](http://cocoapods.org/pods/PredictIO)

## Features
##### Arrival 
Detects that a user just arrived at the destination. 

##### Departure
Detects that user just started their journey.

##### Transport Mode
Distinguish car and non-car trips.

##### Use Cases
Look through the [Use Cases](https://github.com/predict-io/PredictIO-iOS/wiki/Use-Cases) where this SDK can be used.

## Requirements
* [Sign up](http://www.predict.io/sdk-sign-up/) for API key
* iOS 7.0+
* ARC

## Installation
### Using CocoaPods
[CocoaPods](http://cocoapods.org/) is a dependency manager for Cocoa projects. Copy and paste the following lines into your podfile:
```ruby
platform :ios, '7.0'
pod 'PredictIO'
```
> You should not use TextEdit to edit the podfile because TextEdit likes to replace standard quotes with more graphically appealing quotes. This can cause CocoaPods to get confused and display errors, so it’s best to just use Xcode or another programming text editor.

### If not using CocoaPods
If you don't use CocoaPods, you can manually add predict.io lib to your Xcode project, check the [Manual Integration Guide](https://github.com/predict-io/PredictIO-iOS/wiki/Manual-integration-of-predict.io) for more details.

### Example
To run the example project, clone the repo, and run `pod install` from the Example directory first.

### Getting Location Events in the Background
predict.io requires location updates even when your application is in the background. Check out [Getting Location Events in the Background](https://github.com/predict-io/PredictIO-iOS/wiki/Getting-Location-Events-in-the-Background) for more details.

## API Documentation
For a complete reference of the API, please check out our API documentation and usage guides for your preferred language.
* [Objective-C Guide](https://github.com/predict-io/PredictIO-iOS/wiki/Objective-C-Guide)
* [Swift Guide](https://github.com/predict-io/PredictIO-iOS/wiki/Swift-Guide).

## Migration Guide
If you are upgrading from the ParkTAG SDK v2.1.2 or lower, please make sure that you update your integration code, so it conforms with the 3.0+ releases. Checkout the appropriate guide for more details.
* [Objective-C Migration Guide](https://github.com/predict-io/PredictIO-iOS/wiki/Objective-C-Migration-Guide-for-predict.io-3.0)
* [Swift Migration Guide](https://github.com/predict-io/PredictIO-iOS/wiki/Swift-Migration-Guide-for-predict.io-3.0)

## FAQ
Look through the [FAQ](https://github.com/predict-io/PredictIO-iOS/wiki/FAQs) for answers to the most commonly-asked questions about predict.io.

## Communication 
If you need help, visit our [Help Center] (https://support.predict.io)

## Author
predict.io, support@predict.io

## Credits
### About predict.io
Our mobile SDK gives you battery friendly background location so you always know where and when a user arrives or departs. No fiddling with geofences. No beacons or NFC needed. It uses the sensors embedded in any modern smartphone. You can embed it in minutes. Rather than spending months fiddling with the Activity APIs yourself, our SDK powers many industry leading Android and iOS apps in mobility, retail, hospitality, lifestyle and banking.
### License
#### Terms of Service 
Terms of service can be found [here](http://www.predict.io/terms-of-service/).
#### Privacy Policy 
Privacy Policy can be found [here](http://www.predict.io/privacy-policy/).
#### License
predict.io is available under the MIT license. See the LICENSE file for more info.
