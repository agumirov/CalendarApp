//
//  EventView.swift
//  Calendar
//
//  Created by G G on 10.09.2023.
//

import UIKit
import SnapKit

final class EventView: UIView {
    // MARK: - Properties
    var delegate: CalendarViewController?
    
    let emptyEventLabel: UILabel = {
        let label = UILabel()
        label.text = "Нет событий"
        label.textAlignment = .center
        label.textColor = .gray // или другой цвет на ваш выбор
        return label
    }()
    
    private lazy var eventTableView: UITableView = {
        let table = UITableView()
        table.register(EventTableViewCell.self,
                       forCellReuseIdentifier: EventTableViewCell.cellId)
        table.delegate = self
        table.dataSource = self
        table.allowsFocus = false
        table.showsVerticalScrollIndicator = false
        table.separatorStyle = .none
        table.backgroundColor = .white
        return table
    }()
    
    private lazy var dragElement: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private lazy var events: [EventModelDomain] = []
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAppearance()
        setupUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupUI
    private func setupUI() {
        addSubview(dragElement)
        dragElement.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.centerX.equalToSuperview()
            make.width.equalTo(50)
            make.height.equalTo(5)
        }
        
        addSubview(eventTableView)
        eventTableView.snp.makeConstraints { make in
            make.top.equalTo(dragElement.snp.bottom).offset(15)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Private methods
    private func configureAppearance() {
        backgroundColor = .white
        clipsToBounds = true
        layer.cornerRadius = 20
        isHidden = true
        layer.opacity = 0
    }
    
    func setData(events: [EventModelDomain]) {
        self.events = events
        if self.events.isEmpty {
            eventTableView.backgroundView = emptyEventLabel
        } else {
            eventTableView.backgroundView = nil
        }
        self.eventTableView.reloadData()
    }
}

// MARK: - UITableViewDelegate
extension EventView: UITableViewDelegate {
    // delete tableView row
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            delegate?.deleteEvent(event: events[indexPath.row])
        }
    }
    
    // cell height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

// MARK: - UITableViewDataSource
extension EventView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventTableViewCell.cellId) as? EventTableViewCell else {
            return UITableViewCell()
        }
        cell.configureCell(titleLabel: events[indexPath.row].eventName,
                           timeLabel: events[indexPath.row].eventTime)
        return cell
    }
}
