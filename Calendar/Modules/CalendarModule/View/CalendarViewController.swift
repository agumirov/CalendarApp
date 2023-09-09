//
//  ViewController.swift
//  Calendar
//
//  Created by G G on 09.09.2023.
//

import UIKit
import SnapKit
import RxSwift

class CalendarViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var calendarView: UICalendarView = {
        let calendar = UICalendarView()
        let selection = UICalendarSelectionSingleDate(delegate: self)
        let gregorianCalendar = Calendar(identifier: .gregorian)
        calendar.selectionBehavior = selection
        calendar.calendar = gregorianCalendar
        calendar.backgroundColor = .white
        calendar.tintColor = .red
        return calendar
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
        view.backgroundColor = .orange
        setupUI()
        subscribe()
    }
    
    // MARK: - SetupUI
    private func setupUI() {
        view.addSubview(calendarView)
        calendarView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
        }
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
}

// MARK: - UICalendarSelectionSingleDateDelegate
extension CalendarViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        print(selection.selectedDate?.date)
        
    }
}
