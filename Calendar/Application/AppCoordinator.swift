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

// MARK: - Modules Factory
extension AppCoordinator {
    
    private func showCalendarModule() {
        let module = CalendarModuleAssembly.builModule(payLoad: .init(), dependencies: .init())
        let view = module.view
        let output = module.output
        navigationController.viewControllers = [view]
        
        output.asObservable()
            .subscribe(onNext: { [weak self] output in
                switch output {
                case let .routeToEventModule(model):
                    self?.showEventModule(model: model)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func showEventModule(model: EventModel) {
        let module = EventModuleAssembly.builModule(payLoad: .init(date: model.eventDate),
                                                    dependencies: .init(storageService: DIContainer.standart.resolve()))
        let view = module.view
        let output = module.output
        navigationController.pushViewController(view, animated: true)
        
        output.asObservable()
            .subscribe(onNext: {  [weak self] output in
                switch output {
                case .routeToCalendar:
                    self?.navigationController.popViewController(animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
}
