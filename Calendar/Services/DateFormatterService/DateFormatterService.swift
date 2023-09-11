//
//  DateFormatterService.swift
//  Calendar
//
//  Created by G G on 11.09.2023.
//

import Foundation

class DateTimeFormatterService {
    // MARK: - Properties
    static let shared = DateTimeFormatterService()

    private init() { }

    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()

    private lazy var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    // MARK: - Methods
    func formatDateToString(_ date: Date) -> String {
        return dateFormatter.string(from: date)
    }

    func formatTimeToString(_ date: Date) -> String {
        return timeFormatter.string(from: date)
    }
}
