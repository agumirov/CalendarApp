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
        return eventView
    }()
    
    private let viewModel: any CalendarViewModel
    private let disposeBag = DisposeBag()
    
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
        navigationController?.isToolbarHidden = false
        
        let addEventButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addEvent))
        navigationItem.rightBarButtonItem = addEventButton
    }
    
    private func setupAppearance() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(hex: "#00FF00", alpha: 0.3).cgColor,
                                UIColor(hex: "#0000FF", alpha: 0.3).cgColor]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // MARK: - Private methods
    private func subscribe() {
        viewModel.state.asObservable()
            .subscribe(onNext: { state in
                switch state {
                case .initital:
                    break
                case .loading:
                    break
                case .success:
                    break
                case .error:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
    
    @objc private func handleSwipeDown() {
        UIView.animate(withDuration: 1) { [weak self] in
            self?.eventView.isHidden = true
            self?.eventView.layer.opacity = 0
        }
    }
    
    @objc private func addEvent() {
        print("addEvent")
    }
}

// MARK: - UICalendarSelectionSingleDateDelegate
extension CalendarViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
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
