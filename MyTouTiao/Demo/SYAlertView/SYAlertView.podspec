Pod::Spec.new do |s|

  s.name         = "SYAlertView"
  s.version      = "1.0.1"
  s.summary      = "the containerView of SYAlertView can add subviews, which cretated by developer"
  s.homepage     = "https://github.com/potato512/SYAlertView"
  s.license      = "MIT"
  s.author       = { "herman" => "zhangsy757@163.com" }
  s.source       = { :git => 'https://github.com/potato512/SYAlertView.git', :tag => "#{s.version}" }
  s.source_files  = 'SYAlertView/*.{h,m}'
  s.requires_arc = true
  s.platform     = :ios, "9.0"

end
