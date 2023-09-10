//
//  RealmEventModel.swift
//  Calendar
//
//  Created by G G on 11.09.2023.
//

import RealmSwift

class RealmEventModel: Object {
    @objc dynamic var eventId: UUID
    @objc dynamic var eventName: String
    @objc dynamic var eventDate: Date
    @objc dynamic var eventTime: Date
    
    init(eventModel: EventModel) {
        self.eventId = eventModel.eventId
        self.eventName = eventModel.eventName
        self.eventDate = eventModel.eventDate
        self.eventTime = eventModel.eventTime
    }
}
