Pod::Spec.new do |s|
  s.name         = "MyLimeWallet"
  s.version      = "1.0.0"
  s.summary      = "Wallet for MyLime"
  s.description  = <<-DESC
    Demo
  DESC
  s.homepage     = "https://github.com/cbarbera80/MlWallet"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Claudio Barbera" => "barbera.claudio@gmail.com" }
  s.ios.deployment_target = "13.0"
  s.source       = { :git => "https://github.com/cbarbera80/MlWallet", :tag => s.version.to_s }
  s.source_files  = "Sources/**/*"
  s.dependency = "web3swift"
  s.frameworks  = "Foundation"
  s.swift_versions = ['5.1']
end
