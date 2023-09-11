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
    private lazy var _state = BehaviorRelay<EventState>(value: .initital)
    
    var output: Observable<EventOutput> {
        _output.asObservable()
    }
    private lazy var _output = PublishRelay<EventOutput>()
    var input: Input
    private let storageService: EventStorageService
    private let disposeBag = DisposeBag()
    
    struct Input {}
    
    // MARK: - Init
    init(input: Input, storageService: EventStorageService) {
        self.input = input
        self.storageService = storageService
        subscribe()
    }
    
    private func subscribe() {
        storageService.output
            .asObservable()
            .bind(onNext: { [weak self] output in
                self?._state.accept(.loaded)
                switch output {
                case .success:
                    self?._state.accept(.eventAdded)
                case .error:
                    self?._state.accept(.error)
                }
            })
            .disposed(by: disposeBag)
    }
}

extension EventViewModelImpl {
    func sendEvent(event: EventEvent) {
        switch event {
        case let .addEvent(event):
            self._state.accept(.loading)
            storageService.createEvent(event: event)
        case .userNotified:
            _output.accept(.routeToCalendar)
        }
    }
}
