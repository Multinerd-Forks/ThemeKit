Pod::Spec.new do |s|

  s.name         = "ThemeKit"
  s.version      = "0.2.1"
  s.license = { :type => "MIT" }  
  s.summary      = "Simple theming of apps for consistent design from TheDistance."
  s.homepage     = "https://github.com/thedistance"
  s.author       = { "The Distance" => "dev@thedistance.co.uk" }
  s.source = { :git => "https://github.com/thedistance/ThemeKit.git", :tag => s.version }
  s.swift_version = '4.2'
  
  s.ios.deployment_target = "8.0"

  s.ios.public_header_files =  "ThemeKit/ThemeKit/**/*.h"
  s.source_files = "ThemeKit/ThemeKit/**/*.swift", "ThemeKit/ThemeKit/**/*.m", "ThemeKit/ThemeKit/**/*.h"
  s.requires_arc = true

  s.module_name = "ThemeKitCore"


end
