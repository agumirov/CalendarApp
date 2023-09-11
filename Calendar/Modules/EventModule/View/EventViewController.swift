//
//  EventViewController.swift
//  Calendar
//
//  Created by G G on 11.09.2023.
//

import UIKit
import SnapKit

final class EventViewController: BaseViewController {
    // MARK: - Properties
    // Title elements
    private lazy var eventTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Event title"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .gray
        return label
    }()
    
    private lazy var eventTitleField: CustomTextField = {
        let view = CustomTextField()
        view.configure(placeHolder: "Event title", fontSize: 24, color: .black)
        return view
    }()
    
    // Date elements
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .gray
        return label
    }()
    
    private lazy var dateField: CustomTextField = {
        let view = CustomTextField()
        view.configure(placeHolder: "Date", fontSize: 24, color: .black)
        return view
    }()
        
    // Time elements
    private lazy var eventTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Time"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .gray
        return label
    }()
    
    private lazy var eventTimeField: CustomTextField = {
        let view = CustomTextField()
        view.configure(placeHolder: "Time", fontSize: 24, color: .black)
        return view
    }()
    
    private let viewModel: any EventViewModel
    
    // MARK: - Init
    init(viewModel: any EventViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func navigationSetup() {
        super.navigationSetup()
        
        navigationController?.isNavigationBarHidden = false
        
        self.title = "New Event"
        if let navigationController = self.navigationController {
            let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemGray2]
            navigationController.navigationBar.titleTextAttributes = textAttributes
        }
        
        let addEventButton = UIBarButtonItem(title: "Add",
                                             style: .plain,
                                             target: self,
                                             action: #selector(confirmAddingEvent))
        navigationItem.rightBarButtonItem = addEventButton
    }
    
    // MARK: - SetupUI
    override func setupUI() {
        super.setupUI()
        
        // Title elements
        contentView.addSubview(eventTitleLabel)
        eventTitleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(15)
            make.top.equalToSuperview()
        }
        
        contentView.addSubview(eventTitleField)
        eventTitleField.snp.makeConstraints { make in
            make.top.equalTo(eventTitleLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }
        
        // Date elements
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(15)
            make.top.equalTo(eventTitleField.snp.bottom).offset(15)
        }
        
        contentView.addSubview(dateField)
        dateField.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(15)
            make.width.equalTo(view.frame.width * 0.6)
            make.height.equalTo(50)
        }
        
        // Time elements
        contentView.addSubview(eventTimeLabel)
        eventTimeLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(15)
            make.top.equalTo(eventTitleField.snp.bottom).offset(15)
            make.width.equalTo(view.frame.width * 0.3)
        }
        
        contentView.addSubview(eventTimeField)
        eventTimeField.snp.makeConstraints { make in
            make.top.equalTo(eventTimeLabel.snp.bottom).offset(10)
            make.leading.equalTo(eventTimeLabel.snp.leading)
            make.width.equalTo(view.frame.width * 0.3)
            make.height.equalTo(50)
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Private methods
    @objc private func confirmAddingEvent() {
        let eventName = eventTitleField.text()
        let eventDate = dateField.text()
        let eventTime = eventTimeField.text()
        viewModel.sendEvent(event: .addEvent(EventModel(eventId: UUID(),
                                                        eventName: eventName,
                                                        eventDate: eventDate,
                                                        eventTime: eventTime)))
    }
}

// MARK: - UITextFieldDelegate
extension EventViewController: UITextFieldDelegate {}
