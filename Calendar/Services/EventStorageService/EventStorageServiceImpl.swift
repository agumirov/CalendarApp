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
    func createEvent(event: EventModelDomain) {
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
    
    func readAllEvents(completion: @escaping (Results<RealmEventModel>) -> Void) {
        let events = realm.objects(RealmEventModel.self)
        completion(events)
    }
    
    func updateEvent(event: EventModelDomain) {
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
    
    func deleteEvent(event: RealmEventModel) {
        do {
            try realm.write({
                let events = realm.objects(RealmEventModel.self)
                let event = events.filter( "eventId=%@", event.eventId)
                realm.delete(event)
                _output.accept(.success)
            })
        } catch let(error) {
            _output.accept(.error("Error \(error)"))
        }
    }
}
