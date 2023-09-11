//
//  BaseViewController.swift
//  Calendar
//
//  Created by G G on 10.09.2023.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    // MARK: - Properties
    let activityIndicatorView = UIActivityIndicatorView(style: .large)
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
        
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
        
        scrollViewSetup()
        contentViewSetup()
    }
    
    func scrollViewSetup() {
        view.addSubview(scrollView)
        
        scrollView.isDirectionalLockEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = .zero
        scrollView.bounces = false
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func contentViewSetup() {
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    func showAlert(message: String, action: @escaping () -> Void) {
        let alertController = UIAlertController(title: "Уведомление",
                                                message: message,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { _ in action() })
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    // loading indicator methods
    func startActivityIndicator() {
        activityIndicatorView.center = view.center
        activityIndicatorView.color = .gray
        activityIndicatorView.hidesWhenStopped = true
        view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
    }
    
    func stopActivityIndicator() {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.removeFromSuperview()
    }
    
    // MARK: - NavigationController appearance setup
    func navigationSetup() {}
}
