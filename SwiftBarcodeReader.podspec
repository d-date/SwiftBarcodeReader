Pod::Spec.new do |s|
  s.name         = "SwiftBarcodeReader"
  s.version      = "0.1.0"
  s.license      = "MIT"
  s.summary      = "Capturing bar/QR code library written in Swift."
  s.homepage     = "https://github.com/d-date/SwiftBarcodeReader"

  s.social_media_url   = "http://twitter.com/d_date"
  s.author             = { "d_date" => "d.matsudate@gmail.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/d-date/SwiftBarcodeReader.git" }

  s.source_files = 'Source/**/*.swift'
  s.resource_bundles = {'SBRResource' => ['Assets/*.storyboard']}
end
