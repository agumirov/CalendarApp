//
//  EventTableView.swift
//  Calendar
//
//  Created by G G on 10.09.2023.
//

import UIKit
import SnapKit

final class EventTableViewCell: UITableViewCell {
    // MARK: - Properties
    static let cellId = "EventTableViewCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "title"
        label.lineBreakStrategy = .hangulWordPriority
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "description"
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    
    private lazy var leftMarker: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: "EventTableViewCell")
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupUI
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        self.addSubview(leftMarker)
        leftMarker.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
            make.height.equalTo(self.frame.size.height - 10)
            make.width.equalTo(5)
        }
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(leftMarker.snp.trailing).offset(10)
            make.centerY.equalTo(leftMarker.snp.centerY)
            make.width.equalTo(self.frame.size.width * 0.8)
        }
        
        self.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(15)
            make.centerY.equalTo(leftMarker.snp.centerY)
        }
    }
    
    func configureCell(titleLabel: String, timeLabel: String) {
        self.titleLabel.text = titleLabel
        self.timeLabel.text = timeLabel
    }
}
