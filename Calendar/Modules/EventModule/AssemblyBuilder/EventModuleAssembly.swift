//
//  AssemblyBuilder.swift
//  Event
//
//  Created by G G on 11.09.2023.
//

import Foundation
import RxSwift

enum EventModuleAssembly {
    
    // MARK: - Properties
    typealias EventModule = (view: EventViewController, output: Observable<EventOutput>)
    struct Dependencies {
        let storageService: EventStorageService
    }
    struct PayLoad {
        let date: Date
    }
    
    // MARK: - Methods
    static func builModule(payLoad: PayLoad, dependencies: Dependencies) -> EventModule {
        let viewModel = EventViewModelImpl(input: .init(date: payLoad.date),
                                           storageService: dependencies.storageService)
        let viewController = EventViewController(viewModel: viewModel)
        let module = (view: viewController, output: viewModel.output)
        return module
    }
}
