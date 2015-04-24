#
# Be sure to run `pod lib lint UIView-SWAnimation.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "SWAnimatedTabBarController"
  s.version          = "1.0.0"
  s.summary          = "Curated list of subtle animations I used."
  s.homepage         = "https://github.com/sarunw/SWAnimatedTabBarController"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Sarun Wongpatcharapakorn" => "artwork.th@gmail.com" }
  s.source           = { :git => "https://github.com/sarunw/SWAnimatedTabBarController.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/sarunw'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'SWAnimatedTabBarController/**/*'
#  s.resource_bundles = {
#    'UIView-SWAnimation' => ['Pod/Assets/*.png']
#  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
