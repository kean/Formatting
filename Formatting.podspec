Pod::Spec.new do |s|
  s.name             = 'Formatting'
  s.version          = '0.1.1'
  s.summary          = 'Formatted Localizable Strings'

 
  s.description      = <<-DESC
An example code for kean.blog: Formatted Localizable Strings. Demonstrates how to implement basic string formatting using XML tags.
                       DESC

  s.homepage         = 'https://github.com/kean/Formatting'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Alexander Grebenyuk' => 'https://kean.blog' }
  s.source           = { :git => 'https://github.com/kean/Formatting.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.osx.deployment_target = '10.13'
  s.watchos.deployment_target = '4.0'
  s.tvos.deployment_target = '11.0'

  s.swift_version = '5.3'

  s.source_files = 'Source/**/*.swift'

end
