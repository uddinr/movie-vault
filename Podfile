platform :ios, '17.0'

use_frameworks!
inhibit_all_warnings!

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '17.0'
    end
  end
end

target 'MovieVault' do
  
  pod 'Alamofire'
  pod 'SnapKit'
  pod 'UIColor_Hex_Swift'
  pod 'Moya'
  pod 'SDWebImage'
  
  target 'MovieVaultTests' do
    inherit! :search_paths
  end

  target 'MovieVaultUITests' do
  end

end
