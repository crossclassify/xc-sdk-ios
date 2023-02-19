Pod::Spec.new do |spec|
  spec.name         = "CrossClassify"
  spec.version      = "1.0.0"
  spec.summary      = "A CrossClassify Tracker written in Swift for iOS apps."
  spec.homepage     = "https://github.com/crossclassify/xc-sdk-ios"
  spec.license      = { :type => 'MIT', :file => 'LICENSE.md' }
  spec.author       = { "Jasmine Kramer" => "jasmine.km.cc@gmail.com"}
  spec.source       = { :git => "https://github.com/crossclassify/xc-sdk-ios.git", :tag => "v#{spec.version}" }
  spec.ios.deployment_target = '13.0'
  spec.requires_arc = true
  spec.default_subspecs = 'Core'
  spec.swift_version = '5.0'
  
  spec.ios.frameworks = 'UIKit'
  spec.dependency 'FingerprintPro', '~> 2.0'
  # spec.tvos.frameworks = 'UIKit'
  
  spec.subspec 'Core' do |core|
  	core.source_files = 'CrossClassify/*.swift'
  end
end
