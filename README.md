# SwiftBarcodeReader

[![CI Status](http://img.shields.io/travis/Daiki Matsudate/SwiftBarcodeReader.svg?style=flat)](https://travis-ci.org/Daiki Matsudate/SwiftBarcodeReader)
[![Version](https://img.shields.io/cocoapods/v/SwiftBarcodeReader.svg?style=flat)](http://cocoapods.org/pods/SwiftBarcodeReader)
[![License](https://img.shields.io/cocoapods/l/SwiftBarcodeReader.svg?style=flat)](http://cocoapods.org/pods/SwiftBarcodeReader)
[![Platform](https://img.shields.io/cocoapods/p/SwiftBarcodeReader.svg?style=flat)](http://cocoapods.org/pods/SwiftBarcodeReader)

This is a helper library for capturing barcode or QR written in Swift.

## Usage

On calling `presentBarcodeReader`, capturing View Controller will be modaled.

You can specifiy `AVMetadataObjectTypes` as enum, requirement of change camera position button and handling result/error using closure.

```swift
import SwiftBarcodeReader

presentBarcodeReader(scanTypes: [.EAN13Code],
                             needChangePositionButton: true,
                             success: {[unowned self] (type, value) in
            print("type:\(type) value:\(value)")
            self.resultLabel.text = "\(value)"

        }) {(canceled, error) in
            
            //cancel handler when tapped back button
            if canceled {
                print("canceled")
            }
            
            //error handler when occured some error
            if error != nil {
                print("error:\(error)")
            }
        }
```


## Requirements
* Xcode 8 and Swift 3.0
* iOS 8.0 and later

## Installation

### Cocoapod

```ruby
pod "SwiftBarcodeReader"
```

### Carthage

``` ruby
carthage update --platform-iOS
```

## Author

Daiki Matsudate([@d_date](https://twitter.com/d_date))

## Contribute

 If you want to add new feature or fix bug, make an issue first and try to contact me.

## License

SwiftBarcodeReader is available under the MIT license. See the LICENSE file for more info.
