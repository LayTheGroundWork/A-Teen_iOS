//
//  InfoPlist.swift
//  EnvironmentPlugin
//
//  Created by 최동호 on 6/5/24.
//

import ProjectDescription

extension InfoPlist {
    public static let appInfoPlist: Self = .extendingDefault(
        with: .baseInfoPlist
            .merging(.secrets, uniquingKeysWith: { oldValue, newValue in
                newValue
            })
    )
    
    public static let frameworkInfoPlist: Self = .extendingDefault(
        with: .framework
            .merging(.secrets, uniquingKeysWith: { oldValue, newValue in
                newValue
            })
    )
}

public extension [String: Plist.Value] {
    static let secrets: Self = [
        "SERVER_URL": "$(SERVER_URL)"
    ]
    
    static let baseInfoPlist: Self = [
        "UIApplicationSceneManifest": [
            "UIApplicationSupportsMultipleScenes": true,
            "UISceneConfigurations": [
                "UIWindowSceneSessionRoleApplication": [
                    [
                        "UISceneConfigurationName": "Default Configuration",
                        "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                    ]
                ]
            ]
        ],
        "UILaunchStoryboardName": "LaunchScreen.storyboard",
        "UISupportedInterfaceOrientations":
            [
                "UIInterfaceOrientationPortrait",
            ],
        "CFBundleShortVersionString": .shortVersion,
        "CFBundleVersion": .version,
        "CFBundleDisplayName": "$(APP_DISPLAY_NAME)",
        "NSPhotoLibraryUsageDescription": "사진 라이브러리에 접근하여 이미지를 업로드합니다."
    ]
    
    static let framework: Self = [
        "CFBundleDevelopmentRegion": "$(DEVELOPMENT_LANGUAGE)",
        "CFBundleExecutable": "$(EXECUTABLE_NAME)",
        "CFBundleIdentifier": "$(PRODUCT_BUNDLE_IDENTIFIER)",
        "CFBundleInfoDictionaryVersion": "6.0",
        "CFBundleName": "$(PRODUCT_NAME)",
        "CFBundlePackageType": "FMWK",
        "CFBundleShortVersionString": .bundleShortVersionString,
        "CFBundleVersion": .bundleVersion,
    ]
}
