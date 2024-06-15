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
    )
    
    public static let frameworkInfoPlist: Self = .extendingDefault(
        with: .framework
    )
}

public extension [String: Plist.Value] {
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
        "CFBundleDisplayName": "$(APP_DISPLAY_NAME)"
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
