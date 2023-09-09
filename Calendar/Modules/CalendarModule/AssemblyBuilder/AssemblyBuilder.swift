//
//  AssemblyBuilder.swift
//  Calendar
//
//  Created by G G on 10.09.2023.
//

import Foundation
import RxSwift

enum MenuModuleAssembly {
    typealias CalendarModule = (view: CalendarViewController, output: Observable<CalendarOutput>)
    
    struct Dependencies {}
    
    struct PayLoad {}
    
    static func builModule(payLoad: PayLoad, dependencies: Dependencies) -> CalendarModule {
        let viewModel = CalendarViewModelImpl(input: .init())
        let viewController = CalendarViewController(viewModel: viewModel)
        return (view: viewController, output: viewModel.output)
    }
}
