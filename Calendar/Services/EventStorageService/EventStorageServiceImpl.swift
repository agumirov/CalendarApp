//
//  EventStorageServiceImpl.swift
//  Calendar
//
//  Created by G G on 11.09.2023.
//

import Foundation
import RealmSwift
import RxSwift
import RxCocoa

final class EventStorageServiceImpl: EventStorageService {
    // MARK: - Properties
    var realm = try! Realm()
    var output: Observable<StorageServiceOutput> {
        _output.asObservable()
    }
    private lazy var _output = PublishRelay<StorageServiceOutput>()
    
    // MARK: - CRUD    
    func createEvent(event: EventModel) {
        do {
            try realm.write({
                let model = RealmEventModel(eventModel: event)
                realm.add(model)
                _output.accept(.success)
            })
        } catch let(error) {
            _output.accept(.error("Error \(error)"))
        }
    }
    
    func readAllEvents() {
        let events = realm.objects(RealmEventModel.self)
        print(events)
    }
    
    func updateEvent(event: EventModel) {
        do {
            try realm.write({
                let model = RealmEventModel(eventModel: event)
                realm.add(model, update: .modified)
                _output.accept(.success)
            })
        } catch let(error) {
            _output.accept(.error("Error \(error)"))
        }
    }
    
    func deleteEvent(event: EventModel) {
        do {
            try realm.write({
                let model = RealmEventModel(eventModel: event)
                realm.delete(model)
                _output.accept(.success)
            })
        } catch let(error) {
            _output.accept(.error("Error \(error)"))
        }
    }
}
