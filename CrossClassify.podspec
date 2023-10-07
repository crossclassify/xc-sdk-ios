Pod::Spec.new do |spec|
  spec.name         = "CrossClassify"
  spec.version      = "1.0.3"
  spec.summary      = "A CrossClassify Tracker written in Swift for iOS apps."
  spec.homepage     = "https://github.com/crossclassify/xc-sdk-ios"
  spec.license      = { :type => 'Apache-2.0', :file => 'LICENSE.md' }
  spec.author       = { "Jasmine Kramer" => "jasmine.km.cc@gmail.com"}
  spec.source       = { :git => "https://github.com/crossclassify/xc-sdk-ios.git", :tag => "v#{spec.version}" }
  # spec.source       = { :path => "Sources/CrossClassify" }
  spec.ios.deployment_target = '13.0'
  spec.requires_arc = true
  spec.default_subspecs = 'Core'
  spec.swift_version = '5.0'
  
  spec.ios.frameworks = 'UIKit'
  spec.dependency 'FingerprintPro', '~> 2.1.8'
  # spec.tvos.frameworks = 'UIKit'
  
  spec.subspec 'Core' do |core|
  	core.source_files = "Sources/CrossClassify/*.swift", "Sources/CrossClassify/**/*.swift", "Sources/CrossClassify/**/**/*.swift"
  end
end
