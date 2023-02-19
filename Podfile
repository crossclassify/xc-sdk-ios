source 'https://cdn.cocoapods.org/'

abstract_target :example do
  use_frameworks!
  inhibit_all_warnings!
  project 'CrossClassify'
  workspace 'CrossClassify'
  
  target :CrossClassify do
    platform :ios, '13.0'
  end
  
  target :FirebaseSwiftUI do
    platform :ios, '13.0'
    project 'Example/FirebaseSwiftUI/FirebaseSwiftUI'
    pod 'CrossClassify', path: './'
    
    pod 'Firebase/Analytics'
    pod 'Firebase/Auth'
    pod 'GoogleUtilities'
  end
  
  target :FirebaseUIKit do
    platform :ios, '13.0'
    project 'Example/FirebaseUIKit/FirebaseUIKit'
    pod 'CrossClassify', path: './'

    pod 'Firebase/Database'
    pod 'Firebase/Auth'
    pod 'GoogleUtilities'
  end
  
end
