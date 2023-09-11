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
    private var coordinator: Coordinator?
    private var storageService: EventStorageService?

    // MARK: - App lifecycle
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        registerDependencies()
        startApp()
        return true
    }

    // MARK: - Methods
    private func registerDependencies() {
        storageService = EventStorageServiceImpl()
        DIContainer.standart.register(storageService!)
    }
    
    private func startApp() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let navigationController = UINavigationController()
        coordinator = AppCoordinator(navigationController: navigationController)
        self.window?.rootViewController = navigationController
        coordinator?.start()
    }
}
