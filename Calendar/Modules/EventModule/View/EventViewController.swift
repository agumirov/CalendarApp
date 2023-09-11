//
//  EventViewController.swift
//  Calendar
//
//  Created by G G on 11.09.2023.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class EventViewController: BaseViewController {
    // MARK: - Properties
    private let disposeBag = DisposeBag()
    private let formatter = DateFormatter()

    private lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        configureDatePicker(datePicker)
        return datePicker
    }()

    private lazy var timePicker: UIDatePicker = {
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.addTarget(self, action: #selector(timePickerValueChanged), for: .valueChanged)
        configureDatePicker(timePicker)
        return timePicker
    }()

    private lazy var eventTitleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.eventTitleLabel
        configureLabel(label)
        return label
    }()

    private lazy var eventTitleField: CustomDateView = {
        let view = CustomDateView()
        view.configure(placeHolder: Constants.eventTitlePlaceholder,
                       fontSize: Constants.standartFontSize,
                       color: .black,
                       isEnabled: true)
        return view
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.dateLabel
        configureLabel(label)
        return label
    }()

    private lazy var dateField: CustomDateView = {
        let field = CustomDateView()
        field.configure(placeHolder: "",
                        fontSize: Constants.standartFontSize,
                        color: .black,
                        isEnabled: false)
        return field
    }()

    private lazy var eventTimeLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.eventTimeLabel
        configureLabel(label)
        return label
    }()

    private lazy var eventTimeField: CustomDateView = {
        let field = CustomDateView()
        field.configure(placeHolder: "",
                        fontSize: Constants.standartFontSize,
                        color: .black,
                        isEnabled: false)
        return field
    }()

    private let viewModel: any EventViewModel

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
        subscribeOnVM()
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
            make.horizontalEdges.equalToSuperview().inset(Constants.horizontalInset)
            make.top.equalToSuperview()
        }

        contentView.addSubview(eventTitleField)
        eventTitleField.snp.makeConstraints { make in
            make.top.equalTo(eventTitleLabel.snp.bottom).offset(Constants.verticalInset)
            make.horizontalEdges.equalToSuperview().inset(Constants.horizontalInset)
            make.height.equalTo(Constants.textFieldHeight)
        }

        // Date elements
        contentView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(Constants.horizontalInset)
            make.top.equalTo(eventTitleField.snp.bottom).offset(Constants.verticalInset)
        }

        contentView.addSubview(dateField)
        dateField.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(Constants.verticalInset)
            make.leading.equalToSuperview().offset(Constants.horizontalInset)
            make.width.equalTo(view.frame.width * Constants.datePickerWidthMultiplier)
            make.height.equalTo(Constants.textFieldHeight)
        }

        contentView.addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(dateField.snp.bottom).offset(Constants.verticalInset)
            make.leading.equalTo(dateLabel.snp.leading)
            make.bottom.equalToSuperview()
        }
        
        // Time elements
        contentView.addSubview(eventTimeLabel)
        eventTimeLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(Constants.horizontalInset)
            make.top.equalTo(eventTitleField.snp.bottom).offset(Constants.verticalInset)
            make.width.equalTo(view.frame.width * Constants.timePickerWidthMultiplier)
        }
        
        contentView.addSubview(eventTimeField)
        eventTimeField.snp.makeConstraints { make in
            make.top.equalTo(eventTimeLabel.snp.bottom).offset(Constants.verticalInset)
            make.leading.equalTo(eventTimeLabel.snp.leading)
            make.width.equalTo(view.frame.width * Constants.timePickerWidthMultiplier)
            make.height.equalTo(50)
        }
        
        contentView.addSubview(timePicker)
        timePicker.snp.makeConstraints { make in
            make.top.equalTo(eventTimeField.snp.bottom).offset(Constants.verticalInset)
            make.leading.equalTo(eventTimeLabel.snp.leading)
        }
    }
    
    // MARK: - Configure methods
    private func configureDatePicker(_ datePicker: UIDatePicker) {
        datePicker.backgroundColor = .systemGray6
        datePicker.preferredDatePickerStyle = .compact
        datePicker.layer.cornerRadius = Constants.datePickerCornerRadius
    }
    
    private func configureLabel(_ label: UILabel) {
        label.font = .systemFont(ofSize: Constants.labelFontSize)
        label.textColor = .gray
    }
    
    // MARK: - Private methods
    @objc private func confirmAddingEvent() {
        if eventTitleField.text().isEmpty {
            showAlert(message: Constants.alertMessage, action: {})
            return
        }
        let eventName = eventTitleField.text()
        let eventDate = dateField.text()
        let eventTime = eventTimeField.text()
        let model = EventModelDomain(eventId: "\(UUID())",
                                     eventName: eventName,
                                     eventDate: eventDate,
                                     eventTime: eventTime)
        viewModel.sendEvent(event: .addEvent(model))
    }
    
    @objc private func datePickerValueChanged() {
        formatter.dateFormat = "dd.MM.yyyy"
        let date = formatter.string(from: datePicker.date)
        dateField.setText(text: date)
    }
    
    @objc private func timePickerValueChanged() {
        formatter.dateFormat = "HH:mm"
        let time = formatter.string(from: timePicker.date)
        eventTimeField.setText(text: time)
    }
}

// MARK: - Event and State handler
extension EventViewController {
    private func subscribeOnVM() {
        viewModel.state.asObservable()
            .subscribe(onNext: { [weak self] state in
                self?.handleState(state: state)
            })
            .disposed(by: disposeBag)
    }
    
    private func handleState(state: EventState) {
        switch state {
        case .initital:
            break
        case .loading:
            self.handleLoadingState()
        case let .loaded(date, time):
            self.handleLoadedState(date: date, time: time)
        case .error:
            self.showAlert(message: Constants.errorMessage, action: {})
        case .eventAdded:
            self.showAlert(message: Constants.successMessage, action: {
                self.viewModel.sendEvent(event: .userNotified)
            })
        }
    }
    
    private func handleLoadingState() {
        contentView.layer.opacity = 0.3
        startActivityIndicator()
    }
    
    private func handleLoadedState(date: String, time: String) {
        contentView.layer.opacity = 1
        stopActivityIndicator()
        dateField.setText(text: date)
        eventTimeField.setText(text: time)
    }
}

// MARK: - UITextFieldDelegate
extension EventViewController: UITextFieldDelegate {}

// MARK: - Constants
private extension Constants {
    // Strings
    static let eventTitleLabel = "Event title"
    static let eventTitlePlaceholder = "Event title"
    static let dateLabel = "Date"
    static let eventTimeLabel = "Time"
    static let errorMessage = "Произошла ошибка, попробуйте снова"
    static let successMessage = "Событие добавлено"
    static let alertMessage = "Введите название"
    
    // Constaints
    static let datePickerCornerRadius: CGFloat = 15
    static let labelFontSize: CGFloat = 18
    static let textFieldHeight: CGFloat = 50.0
    static let datePickerWidthMultiplier: CGFloat = 0.6
    static let timePickerWidthMultiplier: CGFloat = 0.3
}
