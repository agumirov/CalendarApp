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
            make.edges.equalTo(scrollView.snp.edges)
            make.width.equalTo(scrollView.snp.width)
        }
    }
    
    // MARK: - NavigationController appearance setup
    func navigationSetup() {}
}
