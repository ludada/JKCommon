Pod::Spec.new do |s|
  s.name             = 'JKCommon'
  s.version          = '0.1.2'
  s.summary          = 'fundamental codebase'

  s.description      = 'fundamental codebase like categories, utilities'

  s.homepage         = 'https://github.com'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zheng_tao' => 'zhengtao@people.cn' }
  s.source           = { :git => 'http://10.3.37.65/zhengtao/JKCommon.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'Source/**/*.*'

  s.public_header_files = 'Source/**/*.h'

  s.dependency 'SloppySwiper'

end
