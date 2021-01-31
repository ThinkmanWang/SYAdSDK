Pod::Spec.new do |s|
  s.name = "SYAdSDK"
  s.version = "0.7.2"
  s.summary = "Shiyu Ad SDK for iOS"
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"Thinkman Wang"=>"wangxf1985@gmail.com"}
  s.homepage = "https://github.com/ThinkmanWang/SYAdSDK"
  s.description = "Shiyu Ad SDK for iOS"
  s.frameworks = ["UIKit", "StoreKit", "MobileCoreServices", "WebKit", "MediaPlayer", "CoreMedia", "CoreLocation", "AVFoundation", "CoreTelephony", "SystemConfiguration", "AdSupport", "CoreMotion", "Accelerate", "Security"]
  s.xcconfig = {"OTHER_LINK_FLAG"=>"$(inherited) -ObjC -l\"bz2\" -l\"c++\" -l\"c++abi\" -l\"resolv\" -l\"sqlite3\" -l\"xml2\" -l\"z\" "}
  s.source = { :path => 'https://github.com/ThinkmanWang/SYAdSDK.git', :tag => s.version.to_s }

  s.ios.deployment_target    = '9.0'
  s.ios.vendored_framework   = 'SYAdSDK.framework'
end
