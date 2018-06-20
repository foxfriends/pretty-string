Pod::Spec.new do |s|
  s.name             = 'PrettyString'
  s.version          = '0.1.0'
  s.summary          = 'NSAttributedString is ugly. PrettyString is pretty.'

  s.description      = <<-DESC

                       DESC
  s.homepage         = 'https://github.com/OinkIguana/pretty-string'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Cameron Eldridge' => 'cameldridge+git@gmail.com' }
  s.source           = { :git => 'https://github.com/OinkIguana/pretty-string.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'PrettyString/Classes/**/*'
end
