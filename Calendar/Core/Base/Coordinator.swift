//
//  Coordinator.swift
//  Calendar
//
//  Created by G G on 10.09.2023.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
