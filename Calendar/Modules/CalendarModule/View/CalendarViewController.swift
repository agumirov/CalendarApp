//
//  ViewController.swift
//  Calendar
//
//  Created by G G on 09.09.2023.
//

import UIKit
import SnapKit
import RxSwift

class CalendarViewController: BaseViewController {
    
    // MARK: - Properties
    private let viewModel: any CalendarViewModel
    private let disposeBag = DisposeBag()
    private lazy var eventDate: Date = .now
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.axis = .vertical
        stack.alignment = .center
        stack.backgroundColor = .clear
        return stack
    }()
    
    private lazy var calendarView: UICalendarView = {
        let calendar = UICalendarView()
        let selection = UICalendarSelectionSingleDate(delegate: self)
        let gregorianCalendar = Calendar(identifier: .gregorian)
        calendar.selectionBehavior = selection
        calendar.calendar = gregorianCalendar
        calendar.tintColor = .white
        calendar.fontDesign = .default
        calendar.backgroundColor = .clear
        return calendar
    }()
    
    private lazy var eventView: EventView = {
        let eventView = EventView()
        let swipeDownGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeDown))
        swipeDownGesture.direction = .down
        eventView.addGestureRecognizer(swipeDownGesture)
        eventView.delegate = self
        return eventView
    }()
    
    // MARK: - Init
    init(viewModel: any CalendarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribe()
        setupAppearance()
    }
    
    // MARK: - ViewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.sendEvent(event: .showEvents(eventDate))
    }
    
    // MARK: - SetupUI
    override func setupUI() {
        super.setupUI()
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackView.addArrangedSubview(calendarView)
        stackView.addArrangedSubview(eventView)
    }
    
    override func navigationSetup() {
        super.navigationSetup()
        navigationController?.isNavigationBarHidden = false
        navigationController?.isToolbarHidden = true
        
        let addEventButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addEvent))
        navigationItem.rightBarButtonItem = addEventButton
    }
    
    private func setupAppearance() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(hex: Constants.gradiendStartColor, alpha: 0.3).cgColor,
                                UIColor(hex: Constants.gradientEndColor, alpha: 0.3).cgColor]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // MARK: - Private methods
    @objc private func handleSwipeDown() {
        UIView.animate(withDuration: 1) { [weak self] in
            self?.eventView.isHidden = true
            self?.eventView.layer.opacity = 0
        }
    }
    
    @objc private func addEvent() {
        viewModel.sendEvent(event: .addEvent(EventModel(eventId: UUID(),
                                                        eventName: "",
                                                        eventDate: eventDate,
                                                        eventTime: .now)))
    }
    
    func deleteEvent(event: EventModelDomain) {
        viewModel.sendEvent(event: .removeEvent(event))
        viewModel.sendEvent(event: .showEvents(eventDate))
    }
}

// MARK: - UICalendarSelectionSingleDateDelegate
extension CalendarViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        eventDate = dateComponents?.date ?? .now
        viewModel.sendEvent(event: .showEvents(eventDate))
        if eventView.isHidden {
            UIView.animate(withDuration: 1) { [weak self] in
                self?.eventView.layer.opacity = 1
                self?.eventView.isHidden = false
                self?.eventView.snp.makeConstraints { make in
                    make.width.equalToSuperview()
                    make.bottom.equalToSuperview()
                }
            }
        }
    }
}

// MARK: - Event and State handler
extension CalendarViewController {
    private func subscribe() {
        viewModel.state.asObservable()
            .subscribe(onNext: { [weak self] state in
                self?.handleState(state: state)
            })
            .disposed(by: disposeBag)
    }
    
    private func handleState(state: CalendarState) {
        switch state {
        case .initital:
            break
        case .loading:
            self.contentView.layer.opacity = 0.3
            self.startActivityIndicator()
        case let .success(events):
            self.contentView.layer.opacity = 1
            self.stopActivityIndicator()
            self.eventView.setData(events: events)
        case .error:
            showAlert(message: "Произошла ошибка", action: {})
        }
    }
}
