Pod::Spec.new do |spec|
  spec.name          = 'JWCarousel'
  spec.version       = '1.0.0'
  spec.license       = { :type => 'MIT', :file => 'LICENSE' }
  spec.homepage      = 'https://github.com/JIWON1923/JWCarousel'
  spec.authors       = { 'Jiwon Lee' => 'zest1923@gmail.com' }
  spec.summary       = 'The JWCarousel library for SwiftUI provides a highly customizable carousel view for iOS apps.'
  spec.source        = { :git => 'https://github.com/JIWON1923/JWCarousel.git', :tag => spec.version }
  spec.swift_version = '5.0'
  spec.ios.deployment_target  = '15.0'
  spec.source_files = 'JWCarousel/Classes/**/*'
end
