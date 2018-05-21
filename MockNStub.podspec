#
# Be sure to run `pod lib lint MockNStub.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MockNStub'
  s.version          = '0.1.0'
  s.summary          = 'Code completed Mocking and Stubbing for Swift protocols and classes.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
The implementations in MockNStub are completely protocol oriented. This allows the interface of class and protocol mocks (and stubs) to be exactly the same. All explicit stubs conform to Stubbing and all mocks conform to Mocking. There's never a need to inherit from a concrete type from this library.
                       DESC

  s.homepage         = 'https://github.com/mennolovink/Mock-N-stub'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'mennolovink' => 'mclovink@me.com' }
  s.source           = { :git => 'https://github.com/mennolovink/Mock-N-stub.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/swiftMclovink'

  s.ios.deployment_target = '8.0'

  s.source_files = 'MockNStub/Classes/**/*'

  s.frameworks = 'XCTest'
  s.dependency 'InjectableLoggers', '~> 1'
end
