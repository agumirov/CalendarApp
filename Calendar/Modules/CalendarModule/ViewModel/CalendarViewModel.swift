//
//  CalendarViewModel.swift
//  Calendar
//
//  Created by G G on 10.09.2023.
//

import Foundation
import RxSwift
import RxCocoa

protocol CalendarViewModel {
    associatedtype InputType
    var state: Observable<CalendarState> { get }
    var input: InputType { get set }
    var output: Observable<CalendarOutput> { get }
    func sendEvent(event: CalendarEvent)
}

enum CalendarState {
    case initital
    case loading
    case success
    case error
}

enum CalendarEvent {
    case addEvent
    case removeEvent
}

enum CalendarOutput {
    case routeToEventModule
}
