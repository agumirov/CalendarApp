//
//  RealmEventModel.swift
//  Calendar
//
//  Created by G G on 11.09.2023.
//

import RealmSwift

class RealmEventModel: Object {
    @objc dynamic var eventId = ""
    @objc dynamic var eventName = ""
    @objc dynamic var eventDate = ""
    @objc dynamic var eventTime = ""
}

extension RealmEventModel {
    convenience init(eventModel: EventModel) {
        self.init()
        self.eventId = "\(eventModel.eventId)"
        self.eventName = "\(eventModel.eventName)"
        self.eventDate = "\(eventModel.eventDate)"
        self.eventTime = "\(eventModel.eventTime)"
    }
}
