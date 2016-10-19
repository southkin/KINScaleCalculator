#
# Be sure to run `pod lib lint KinderScaleCalculator.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'KinderScaleCalculator'
s.version          = '0.0.20'
s.summary          = 'scale calculator'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = <<-DESC
작업베이스화면 대비 실제 화면에서의 사이즈,위치를 계산
DESC

s.homepage         = 'https://github.com/southkin/KINScaleCalculator.git'
# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'kin' => 'south.kin@gmail.com' }
s.source           = { :git => 'https://github.com/southkin/KINScaleCalculator.git', :tag => s.version.to_s }
# s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

s.ios.deployment_target = '8.0'

s.source_files = 'KinderScaleCalculator/KinderScaleCalculator/**/*'

# s.resource_bundles = {
#   'KinderScaleCalculator' => ['KinderScaleCalculator/Assets/*.png']
# }

# s.public_header_files = 'Pod/Classes/**/*.h'
# s.frameworks = 'UIKit', 'MapKit'
# s.dependency 'AFNetworking', '~> 2.3'
end
