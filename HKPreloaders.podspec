#
# Be sure to run `pod lib lint HKPreloaders.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HKPreloaders'
  s.version          = '0.1.2'
  s.summary          = 'A set of preloader animations written in Swift.'
  
  s.description      = <<-DESC
Contains a set of preloader animations that are written in Swift and primarily uses CAKeyframeAnimation to achieve the effects. Please feel free to use this cocoapod in your projects.

The views are easily customizable since all of them are loaded through .xib files.
                       DESC

  s.homepage         = 'https://github.com/Thisura98/HKPreloaders'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Thisura98' => 'thisura1998@gmail.com' }
  s.source           = { :git => 'https://github.com/Thisura98/HKPreloaders.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.swift_version    = '5.0'

  s.source_files = 'HKPreloaders/Classes/**/*'
  
  s.resource_bundles = {
    'HKPreloaders' => ['HKPreloaders/Assets/*.png', 'HKPreloaders/Assets/*.xib']
  }
  
  s.frameworks = 'UIKit'
  
end
