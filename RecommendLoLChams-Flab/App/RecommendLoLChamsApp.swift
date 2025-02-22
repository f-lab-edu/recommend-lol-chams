//
//  RecommendLoLChamsApp.swift
//  RecommendLoLChams-Flab
//
//  Created by 김혜지 on 1/7/25.
//

import FirebaseCore

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct RecommendLoLChamsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
