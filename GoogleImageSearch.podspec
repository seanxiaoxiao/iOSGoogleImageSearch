#
# Be sure to run `pod lib lint GoogleImageSearch.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "GoogleImageSearch"
  s.version          = "1.0.0"
  s.summary          = "A Google Image Search API. Given the keyword, this library can give you a list of the images and their thumbnails."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
  A Google Image Search API. Given the keyword, this library can give you a list of the images and their thumbnails.

  To use this library, you don't need to use any appkey. The implementation behind the scene is to query from the normal google image search path and then use a dummy webview to hold the results in webpage. After this is done, use a javascript to parse the result in the webpage.

  The sample demos how to setup this library and get the results showing on a collection view.
                       DESC

  s.homepage         = "https://github.com/seanxiaoxiao/iOSGoogleImageSearch"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "seanxiaoxiao" => "seanxiaoxiao@hotmail.com" }
  s.source           = { :git => "https://github.com/seanxiaoxiao/iOSGoogleImageSearch.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'GoogleImageSearch' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
