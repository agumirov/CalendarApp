//
//  EventStorageService.swift
//  Calendar
//
//  Created by G G on 11.09.2023.
//

import Foundation
import RxSwift
import RealmSwift

protocol EventStorageService {
    func createEvent(event: EventModelDomain)
    func readAllEvents(completion: @escaping (Results<RealmEventModel>) -> Void)
    func updateEvent(event: EventModelDomain)
    func deleteEvent(event: RealmEventModel)
    var output: Observable<StorageServiceOutput> { get }
}

enum StorageServiceOutput {
    case success
    case error(String)
}
