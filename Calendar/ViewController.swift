//
//  ViewController.swift
//  Calendar
//
//  Created by G G on 09.09.2023.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    private lazy var calendarView: UICalendarView = {
        let calendar = UICalendarView()
        return calendar
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
    }
}

