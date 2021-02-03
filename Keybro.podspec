
Pod::Spec.new do |s|
  s.name     = 'Keybro'
  s.version  = '1.0.0'
  s.ios.deployment_target   = '9.0'
  s.license  = { :type => 'MIT', :file => 'LICENSE' }
  s.summary  = 'Keybro - is a quick wrapper for UIKeyCommand'
  s.description = 'This tool allows easily adding keyboard shortcuts to your app for debugging and testing applications especially in a simulator.'
  s.homepage = 'https://github.com/antongaenko/keybro'
  s.author   = { 'Anton Gaenko' => 'hi@antongaenko.dev' }
  s.source   = {
    :git => 'https://github.com/antongaenko/keybro.git',
    :branch => 'main',
    :tag => s.version.to_s
  }
  s.source_files = 'keybro/Keybro.swift'
  s.swift_version = '5.0'
end
