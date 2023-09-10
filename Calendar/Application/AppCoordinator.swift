//
//  AppCoordinator.swift
//  Calendar
//
//  Created by G G on 10.09.2023.
//

import Foundation
import RxSwift

final class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    private var disposeBag = DisposeBag()
    var navigationController: UINavigationController
    
    // MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Methods
    func start() {
        showCalendarModule()
    }
    
    // MARK: - private Methods
    
}

// MARK: - Module Factories
extension AppCoordinator {
    
    private func showCalendarModule() {
        let module = CalendarModuleAssembly.builModule(payLoad: .init(), dependencies: .init())
        let view = module.view
        let output = module.output
        navigationController.viewControllers = [view]
        
        output.asObservable()
            .subscribe(onNext: { output in
                switch output {
                    
                }
            })
            .disposed(by: disposeBag)
    }
}

