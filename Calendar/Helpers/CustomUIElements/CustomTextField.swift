//
//  CustomTextField.swift
//  Calendar
//
//  Created by G G on 11.09.2023.
//

import UIKit
import SnapKit

final class CustomTextField: UIView {
    // MARK: - Properties
    private lazy var textField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - SetupUI
    private func setupUI() {
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(15)
        }
    }
    
    // MARK: - Methods
    private func setupAppearance() {
        layer.cornerRadius = 20
        backgroundColor = .systemGray5
    }
    
    func configure(placeHolder: String, fontSize: CGFloat, color: UIColor) {
        textField.placeholder = placeHolder
        textField.font = .systemFont(ofSize: fontSize)
        textField.textColor = color
    }
    
    func text() -> String {
        return textField.text ?? ""
    }
}
