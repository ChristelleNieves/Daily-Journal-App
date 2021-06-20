//
//  MoodReasonView.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/17/21.
//

import UIKit

class MoodReasonView: UIView, UITextFieldDelegate {
    
    private let textField = UITextField()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MoodReasonView {
    private func setupView() {
        self.backgroundColor = ThemeColors.peach
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.5
        self.layer.cornerRadius = 40
    }
    
    private func setupTextField() {
        textField.delegate = self
        textField.attributedPlaceholder = NSAttributedString(string: "Write something here..", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.withAlphaComponent(0.50)])
        textField.tintColor = UIColor.darkGray
        textField.backgroundColor = .clear
        textField.layer.borderColor = UIColor.darkGray.cgColor
        textField.borderStyle = .roundedRect
        self.addSubview(textField)
        
        // Constraints
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30)
        ])
    }
    
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Dismiss the keyboard
        textField.resignFirstResponder()
        
        return true
    }
}
