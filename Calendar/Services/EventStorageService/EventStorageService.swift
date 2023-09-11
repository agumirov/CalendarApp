//
//  EventStorageService.swift
//  Calendar
//
//  Created by G G on 11.09.2023.
//

import Foundation
import RxSwift

protocol EventStorageService {
    func createEvent(event: EventModel)
    func readAllEvents()
    func updateEvent(event: EventModel)
    func deleteEvent(event: EventModel)
    var output: Observable<StorageServiceOutput> { get }
}

enum StorageServiceOutput {
    case success
    case error(String)
}
