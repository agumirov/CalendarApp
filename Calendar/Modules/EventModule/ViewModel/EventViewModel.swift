//
//  EventViewModel.swift
//  Event
//
//  Created by G G on 11.09.2023.
//

import Foundation
import RxSwift
import RxCocoa

protocol EventViewModel {
    associatedtype InputType
    var state: Observable<EventState> { get }
    var input: InputType { get set }
    var output: Observable<EventOutput> { get }
    func sendEvent(event: EventEvent)
}

enum EventState {
    case initital
    case loading
    case loaded
    case error
    case eventAdded
}

enum EventEvent {
    case addEvent(EventModel)
    case userNotified
}

enum EventOutput {
    case routeToCalendar
}
