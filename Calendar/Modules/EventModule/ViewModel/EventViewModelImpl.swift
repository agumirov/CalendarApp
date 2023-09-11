//
//  EventViewModelImpl.swift
//  Event
//
//  Created by G G on 11.09.2023.
//

import Foundation
import RxCocoa
import RxSwift

final class EventViewModelImpl: EventViewModel {
    // MARK: - Properties
    var state: Observable<EventState> {
        _state.asObservable()
    }
    private var _state = BehaviorSubject<EventState>(value: .initital)
    
    var output: Observable<EventOutput> {
        _output.asObservable()
    }
    private lazy var _output = PublishRelay<EventOutput>()
    var input: Input
    private let storageService: EventStorageService
    
    struct Input {}
    
    // MARK: - Init
    init(input: Input, storageService: EventStorageService) {
        self.input = input
        self.storageService = storageService
    }
}

extension EventViewModelImpl {
    func sendEvent(event: EventEvent) {
        switch event {
        case let .addEvent(event):
            storageService.createEvent(event: event)
        }
    }
}

