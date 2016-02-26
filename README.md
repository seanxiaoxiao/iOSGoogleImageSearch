# GoogleImageSearch for iOS

A Google Image Search API. Given the keyword, this library can give you a list of the images and their thumbnails.

A Google Image Search API. Given the keyword, this library can give you a list of the images and their thumbnails.

To use this library, you don't need to use any appkey. The implementation behind the scene is to query from the normal google image search path and then use a dummy webview to hold the results in webpage. After this is done, use a javascript to parse the result in the webpage.

The sample demos how to setup this library and get the results showing on a collection view.

[![CI Status](http://img.shields.io/travis/seanxiaoxiao/GoogleImageSearch.svg?style=flat)](https://travis-ci.org/seanxiaoxiao/GoogleImageSearch)
[![Version](https://img.shields.io/cocoapods/v/GoogleImageSearch.svg?style=flat)](http://cocoapods.org/pods/GoogleImageSearch)
[![License](https://img.shields.io/cocoapods/l/GoogleImageSearch.svg?style=flat)](http://cocoapods.org/pods/GoogleImageSearch)
[![Platform](https://img.shields.io/cocoapods/p/GoogleImageSearch.svg?style=flat)](http://cocoapods.org/pods/GoogleImageSearch)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

GoogleImageSearch is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "GoogleImageSearch"
```

## Author

seanxiaoxiao, seanxiaoxiao@hotmail.com

## License

GoogleImageSearch is available under the MIT license. See the LICENSE file for more info.
