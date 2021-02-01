#
# Be sure to run `pod lib lint SYAdSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#



Pod::Spec.new do |s|
	
  s.name             = 'SYAdSDK'
  s.version          = '0.7.11'
  s.summary          = 'Shiyu Ad SDK for iOS'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Shiyu Ad SDK for iOS
                       DESC

  s.homepage         = 'https://github.com/ThinkmanWang/SYAdSDK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Thinkman Wang' => 'wangxf1985@gmail.com' }
  s.source           = { :git => '/Users/wangxiaofeng/Github-Thinkman/MyPods/SYAdSDK', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'SYAdSDK/Classes/**/*'
#  s.public_header_files = "SYAdSDK/Classes/**/*.h"
  s.public_header_files = ['SYAdSDK/Classes/SYAdSDK.h', 'SYAdSDK/Classes/SYAdSDKDefines.h', 'SYAdSDK/Classes/SYAdSDKManager.h', 'SYAdSDK/Classes/SYBannerView.h', 'SYAdSDK/Classes/SYExpressAdManager.h', 'SYAdSDK/Classes/SYExpressAdView.h', 'SYAdSDK/Classes/SYInterstitialAd.h', 'SYAdSDK/Classes/SYSplashAdView.h']
  
  s.static_framework = true
  s.vendored_frameworks = 'frameworks/BUAdSDK.framework', 'frameworks/BUFoundation.framework'
  s.resource = 'frameworks/BUAdSDK.bundle'
#  s.dependency 'Bytedance-UnionAD', '~> 3.3.1.5'
  
  # s.resource_bundles = {
  #   'SYAdSDK' => ['SYAdSDK/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.frameworks = 'UIKit', 'StoreKit', 'MobileCoreServices', 'WebKit', 'MediaPlayer', 'CoreMedia', 'CoreLocation', 'AVFoundation', 'CoreTelephony', 'SystemConfiguration', 'AdSupport', 'CoreMotion', 'Accelerate', 'Security'
  # s.libraries = 'resolv', 'c++', 'z', 'sqlite3', 'bz2', 'xml2', 'iconv'
  s.xcconfig = { "OTHER_LINK_FLAG" => '$(inherited) -ObjC -l"bz2" -l"c++" -l"c++abi" -l"resolv" -l"sqlite3" -l"xml2" -l"z" '}
  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
	s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
end
