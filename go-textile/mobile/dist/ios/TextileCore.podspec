require 'json'

package = JSON.parse(File.read(File.join(__dir__, '../../../../package.json')))

Pod::Spec.new do |s|
  s.name                  = 'TextileCore'
  s.version               = package['version']
  s.summary               = 'Encrypted, recoverable, schema-based, cross-application data storage built on IPFS and LibP2P'
  s.description           = <<-DESC
                            Objective C framework and Protobuf files generated from go-textile. You should
                            not usually use this pod directly, but instead use the Textile pod.
                          DESC
  s.homepage              = package['homepage']
  s.license               = package['license']
  s.author                = package['author']
  s.source                = { :git => 'https://github.com/flyskywhy/textiot.git', :tag => s.version.to_s }
  s.platform              = :ios, '7.0'
  s.source_files          = 'protos'
  s.vendored_frameworks   = 'Mobile.framework'
  s.requires_arc          = false
  # https://stackoverflow.com/questions/50024087/gomobile-bind-producing-library-with-pie-disabled-i386-arch
  s.pod_target_xcconfig   = { 'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) GPB_USE_PROTOBUF_FRAMEWORK_IMPORTS=1', 'OTHER_LDFLAGS[arch=i386]' => '-Wl,-read_only_relocs,suppress' }
  s.dependency 'Protobuf', '~> 3.7'
end
