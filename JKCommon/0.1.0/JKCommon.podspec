Pod::Spec.new do |s|
  s.name             = 'JKCommon'
  s.version          = '0.1.0'
  s.summary          = 'fundamental codebase'

  s.description      = 'fundamental codebase like categories, utilities'

  s.homepage         = 'https://github.com'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zheng_tao' => 'zhengtao@people.cn' }
  s.source           = { :git => 'https://Sid_Zheng@bitbucket.org/Sid_Zheng/jkcommon.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Source/**/*.*'

  s.public_header_files = 'Source/**/*.h'

end