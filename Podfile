source 'https://cdn.cocoapods.org/'

abstract_target :example do
  use_frameworks!
  inhibit_all_warnings!
  project 'CrossClassify'
  workspace 'CrossClassify'
  
  target :FirebaseUIKit do
    platform :ios, '13.0'
    project 'Example/FirebaseUIKit/FirebaseUIKit'
    # pod 'CrossClassify'
   pod 'CrossClassify', :path => './'
    
    pod 'Firebase/Auth'
    pod 'Firebase/Database'
    pod 'GoogleUtilities'
  end
  
end
