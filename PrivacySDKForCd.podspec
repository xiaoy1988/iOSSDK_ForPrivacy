Pod::Spec.new do |s|
    s.name         = "PrivacySDKForCd"
    s.version      = "1.0.2"
    s.summary      = "IDFA、IDFV统一收口"
    s.ios.deployment_target = "15.0"
    s.osx.deployment_target = "17.0"
    s.description  = <<-DESC
测试用SDK, 使用OC实现
    DESC
    s.homepage     = "https://github.com/xiaoy1988/iOSSDK_ForPrivacy"
    s.author           = { 'chendan6' => '694708086@qq.com' }
    s.platform     = :ios, "15.0"
    s.source       = { :git => "https://github.com/xiaoy1988/iOSSDK_ForPrivacy", :tag => s.version }
    s.source_files = 'PrivacySDKForCd/*'
  # 过不支持真机调试则加上下面的
    s.pod_target_xcconfig = {
        'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
    }
    s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  # 不支持真机结束
  
    s.vendored_frameworks = 'PrivacySDKForCd.framework'
end