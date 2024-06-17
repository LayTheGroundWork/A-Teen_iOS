//
//  AppDelegate.swift
//  ATeen
//
//  Created by 최동호 on 5/15/24.
//

import Core
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var auth: SessionCheckAuth?
    var appContainer: AppContainer?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        appContainer = AppContainer()
        guard
            let auth = auth
        else {
            loadHomeDate()
            return true
        }

        auth.isSessionActive ? loadAllData() : loadHomeDate()
        return true
    }
  
    private func loadAllData() {
        Thread.sleep(forTimeInterval: 1.0)
    }
    
    private func loadHomeDate() {
        Thread.sleep(forTimeInterval: 1.0)
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

