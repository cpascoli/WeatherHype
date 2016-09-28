platform :ios, '9.0'
use_frameworks!
 
target 'WeatherHype' do
    pod 'SwiftyJSON',  :git => 'https://github.com/SwiftyJSON/SwiftyJSON.git'
    pod 'NVActivityIndicatorView',  :git => 'https://github.com/ninjaprox/NVActivityIndicatorView.git'
end

target 'WeatherHypeTests' do
    pod 'SwiftyJSON',  :git => 'https://github.com/SwiftyJSON/SwiftyJSON.git'
    pod 'NVActivityIndicatorView',  :git => 'https://github.com/ninjaprox/NVActivityIndicatorView.git'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
