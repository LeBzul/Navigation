Pod::Spec.new do |s|
  s.name             = 'Navigation'
  s.version          = '0.1.0'
  s.swift_version    = '4.0'
  s.summary          = 'Simplified use of storyboard'
 
  s.description      = <<-DESC
Simplified use of storyboard and verify existing Controller in project
                       DESC
 
  s.homepage         = 'https://github.com/LeBzul/Navigation'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'LeBzul' => 'drouingui@gmail.com' }
  s.source           = { :git => 'https://github.com/LeBzul/Navigation.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '10.0'
  s.source_files = 'Navigation.swift'
 
end