source 'https://github.com/CocoaPods/Specs'

platform :ios, '11.1'
use_frameworks!

# Add Application pods here
def app_pods
    pod 'Alamofire'                             # https://github.com/Alamofire/Alamofire
    pod 'AlamofireImage'                        # https://github.com/Alamofire/AlamofireImage
    pod 'AsyncSwift'                            # https://github.com/duemunk/Async
    pod 'Crashlytics'                           # https://fabric.io/kits/ios/crashlytics/install
    pod 'Device'                                # https://github.com/Ekhoo/Device
    pod 'DynamicColor'                          # https://github.com/yannickl/DynamicColor
#    pod 'Eureka'                               # https://github.com/xmartlabs/Eureka
    pod 'Fabric'                                # https://docs.fabric.io/apple/fabric/overview.html
    pod 'KeychainAccess'                        # https://github.com/kishikawakatsumi/KeychainAccess
    pod 'NVActivityIndicatorView'               # https://github.com/ninjaprox/NVActivityIndicatorView
    pod 'Moya/RxSwift'                          # https://github.com/Moya/Moya
#    pod 'R.swift'                               # https://github.com/mac-cain13/R.swift
    pod 'RealmSwift'                            # https://github.com/realm/realm-cocoa
    pod 'Result'                                # https://github.com/antitypical/Result
    pod 'RxAlamofire'                           # https://github.com/RxSwiftCommunity/RxAlamofire
    pod 'RxCocoa'                               # https://github.com/ReactiveX/RxSwift
    pod 'RxSwift'                               # https://github.com/ReactiveX/RxSwift
    pod 'SwiftDate'                             # https://github.com/malcommac/SwiftDate
 #   pod 'WebLinking', :git => 'https://github.com/kylef/WebLinking.swift', :branch => 'master'
    pod 'XLSwiftKit'
end

def testing_pods
    pod 'Quick'
    pod 'Nimble'
end

target 'Vote' do
    app_pods
end

target 'VoteTests' do
  testing_pods
end

target 'VoteUITests' do
    testing_pods
end

post_install do |installer|
    puts 'Removing static analyzer support'
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.0'
            config.build_settings['OTHER_CFLAGS'] = "$(inherited) -Qunused-arguments -Xanalyzer -analyzer-disable-all-checks"
        end
    end
end
