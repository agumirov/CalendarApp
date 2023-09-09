//
//  BaseViewController.swift
//  Calendar
//
//  Created by G G on 10.09.2023.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationSetup()
    }
    
    // MARK: - SetupUI
    func setupUI() {
        view.backgroundColor = .systemBackground
    }
    
    // MARK: - NavigationController appearance setup
    func navigationSetup() {
        navigationController?.isToolbarHidden = true
        navigationController?.isNavigationBarHidden = true
    }
}
