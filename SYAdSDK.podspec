#
# Be sure to run `pod lib lint SYAdSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SYAdSDK'
  s.version          = '0.1.0'
  s.summary          = 'A short description of SYAdSDK.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = ''
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Thinkman Wang' => 'wangxf1985@gmail.com' }
  s.source           = { :git => 'https://github.com/Thinkman Wang/SYAdSDK.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'SYAdSDK/Classes/**/*.{h,m}'
  s.public_header_files = "SYAdSDK/Classes/**/*.h"
  
  s.static_framework = true
  s.dependency 'Bytedance-UnionAD', '~> 3.3.1.5'
  s.dependency 'AFNetworking', '~> 2.3'
  
  # s.resource_bundles = {
  #   'SYAdSDK' => ['SYAdSDK/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.frameworks = 'UIKit', 'StoreKit', 'MobileCoreServices', 'WebKit', 'MediaPlayer', 'CoreMedia', 'CoreLocation', 'AVFoundation', 'CoreTelephony', 'SystemConfiguration', 'AdSupport', 'CoreMotion', 'Accelerate', 'Security'
  # s.libraries = 'resolv', 'c++', 'z', 'sqlite3', 'bz2', 'xml2', 'iconv'
  s.xcconfig = { "OTHER_LINK_FLAG" => '$(inherited) -ObjC -l"bz2" -l"c++" -l"c++abi" -l"resolv" -l"sqlite3" -l"xml2" -l"z" '}
end
