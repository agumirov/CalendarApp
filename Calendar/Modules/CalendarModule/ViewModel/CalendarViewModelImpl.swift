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
    var events: [EventModelDomain] = []
    var state: Observable<CalendarState> {
        _state.asObservable()
    }
    private var _state = BehaviorRelay<CalendarState>(value: .initital)
    
    var output: Observable<CalendarOutput> {
        _output.asObservable()
    }
    private lazy var _output = PublishRelay<CalendarOutput>()
    var input: Input
    private let storageService: EventStorageService
    private let disposeBag = DisposeBag()
    
    struct Input {}
    
    // MARK: - Init
    init(input: Input, storageService: EventStorageService) {
        self.input = input
        self.storageService = storageService
    }
    
    private func loadEvents(date: Date) -> [EventModelDomain] {
        let date = DateTimeFormatterService.shared.formatDateToString(date)
        var eventsDomain: [EventModelDomain] = []
        storageService.readAllEvents { events in
            let filtered = events.filter({ $0.eventDate == date })
            filtered.forEach { event in
                let eventModel = EventModelDomain(eventId: event.eventId,
                                                  eventName: event.eventName,
                                                  eventDate: event.eventDate,
                                                  eventTime: event.eventTime)
                eventsDomain.append(eventModel)
            }
        }
        return eventsDomain
    }
}

extension CalendarViewModelImpl {
    func sendEvent(event: CalendarEvent) {
        switch event {
        case let .addEvent(eventModel):
            _output.accept(.routeToEventModule(eventModel))
            
        case let .removeEvent(event):
            _state.accept(.loading)
            let realmModel = RealmEventModel(eventModel: event)
            storageService.deleteEvent(event: realmModel)
            
        case let .showEvents(date):
            self.events = loadEvents(date: date)
            self._state.accept(.success(self.events))
        }
    }
}
