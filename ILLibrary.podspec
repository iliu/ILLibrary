#
# Be sure to run `pod lib lint ILLibrary.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "ILLibrary"
  s.version          = "0.1.4.1"
  s.summary          = "A short description of ILLibrary."
  s.description      = <<-DESC
                       An optional longer description of ILLibrary

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/iliu/ILLibrary"
  s.license          = 'MIT'
  s.author           = { "Isaac Liu" => "liu.isaac@gmail.com" }
  s.source           = { :git => "https://github.com/iliu/ILLibrary.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*.{h,m}'
  s.resource_bundles = {
    'ILLibrary' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'FontAwesomeKit/FontAwesome'
  s.dependency 'AFNetworking'
  s.dependency 'Masonry'
end
