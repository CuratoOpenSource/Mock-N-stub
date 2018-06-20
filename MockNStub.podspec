Pod::Spec.new do |s|
  s.name             = 'MockNStub'
  s.version          = '3.0.0'
  s.summary          = 'Code completed Mocking and Stubbing for Swift protocols and classes.'
  s.description      = <<-DESC
The implementations in MockNStub are completely protocol oriented. This allows the interface of class and protocol mocks (and stubs) to be exactly the same. All explicit stubs conform to Stubbing and all mocks conform to Mocking. There's never a need to inherit from a concrete type from this library.
                       DESC

  s.homepage         = 'https://github.com/mennolovink/Mock-N-stub'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'mennolovink' => 'mclovink@me.com' }
  s.source           = { :git => 'https://github.com/mennolovink/Mock-N-stub.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'MockNStub/Classes/**/*'

  s.frameworks = 'XCTest'
  s.dependency 'InjectableLoggers', '~> 1'
  s.dependency 'ArrayPlusTuple', '~> 1'
end
