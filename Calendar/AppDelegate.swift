//
//  AppDelegate.swift
//  Calendar
//
//  Created by G G on 09.09.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Properties
    var window: UIWindow?

    // MARK: - App lifecycle
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        startApp()
        return true
    }

    // MARK: - Methods
    private func startApp() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let navigationController = UINavigationController()
        self.window?.rootViewController = navigationController
        navigationController.viewControllers = [CalendarViewController()]
    }
}
