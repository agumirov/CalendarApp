//
//  CalendarViewModelImpl.swift
//  Calendar
//
//  Created by G G on 10.09.2023.
//

import Foundation
import RxCocoa
import RxSwift

final class CalendarViewModelImpl: CalendarViewModel {
    // MARK: - Properties
    var state: Observable<CalendarState> {
        _state.asObservable()
    }
    private var _state = BehaviorSubject<CalendarState>(value: .initital)
    
    var output: Observable<CalendarOutput> {
        _output.asObservable()
    }
    private lazy var _output = PublishRelay<CalendarOutput>()
    var input: Input
    struct Input {}
    
    // MARK: - Init
    init(input: Input) {
        self.input = input
    }
}

extension CalendarViewModelImpl {
    func sendEvent(event: CalendarEvent) {
        switch event {
        case .addEvent:
            _output.accept(.routeToEventModule)
        case .removeEvent:
            break
        }
    }
}
