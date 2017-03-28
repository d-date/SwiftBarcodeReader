# SwiftBarcodeReader

This is a helper library for capturing barcode or QR written in Swift.

## Usage

On calling `presentBarcodeReader`, capturing View Controller will be modaled.

You can specifiy `AVMetadataObjectTypes` as enum, requirement of change camera position button and handling result/error using closure.

```swift
import SwiftBarcodeReader

func appear(){
        presentBarcodeReader(scanTypes: [.EAN13Code], //you can specify code type to scan type as enum value
                             needChangePositionButton: true, // If you need change position button, pass `true`
                             success: { (type, value) in
            print("type:\(type) value:\(value)")
            self.resultLabel.text = "\(value)"

        }) {(canceled, error) in
            
            //cancel handle when tapped back button
            if canceled {
                print("canceled")
            }
            
            //error handle when occured some error
            if error != nil {
                print("error:\(error)")
            }
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

Prepare Cartfile, then add below.

``` ruby
github "d-date/SwiftBarcodeReader"
```

Run below on Terminal.

``` ruby
carthage update --platform-iOS
```

## Author

Daiki Matsudate([@d_date](https://twitter.com/d_date))

## Contribute

 If you want to add new feature or fix bug, make an issue first and try to contact me.

## License

SwiftBarcodeReader is available under the MIT license. See the LICENSE file for more info.

## TODO

* Custermizable Capturing UI
* Show Capturing Rect
