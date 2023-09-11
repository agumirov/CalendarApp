//
//  AssemblyBuilder.swift
//  Calendar
//
//  Created by G G on 10.09.2023.
//

import Foundation
import RxSwift

enum CalendarModuleAssembly {
    
    // MARK: - Properties
    typealias CalendarModule = (view: CalendarViewController, output: Observable<CalendarOutput>)
    struct Dependencies {}
    struct PayLoad {}
    
    // MARK: - Methods
    static func builModule(payLoad: PayLoad, dependencies: Dependencies) -> CalendarModule {
        let viewModel = CalendarViewModelImpl(input: .init(), storageService: DIContainer.standart.resolve())
        let viewController = CalendarViewController(viewModel: viewModel)
        let module = (view: viewController, output: viewModel.output)
        return module
    }
}
