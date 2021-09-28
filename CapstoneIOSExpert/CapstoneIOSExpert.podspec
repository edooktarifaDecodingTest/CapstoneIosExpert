Pod::Spec.new do |s|
 
s.platform = :ios
s.ios.deployment_target = '14.0'
s.name = "CapstoneIOSExpert"
s.summary = "Dicoding CapstoneIOSExpert.framework for modularization chapter"
s.requires_arc = true
 
s.version = "1.0.0"
 
s.license = { :type => "MIT", :file => "LICENSE" }
 
s.author = { "edo oktarifa" => "edooktarifa99@gmail.com" }
 
s.homepage = "https://github.com/edooktarifa/EdoOktarifa-ModularApp"
 
s.source = { :git => "https://github.com/edooktarifa/EdoOktarifa-ModularApp.git", 
:tag => '1.0.0' }
 
s.framework = "UIKit"
 
s.source_files = 'CapstoneIOSExpert/**/*.{swift}'
#s.dependency 'Alamofire'
 
#s.resources = "CapstoneIOSExpert/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"
 
s.swift_version = "5"
s.dependency "Cosmos"
 
end
