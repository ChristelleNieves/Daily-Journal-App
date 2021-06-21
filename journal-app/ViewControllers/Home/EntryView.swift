//
//  entryView.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/18/21.
//

import UIKit

class EntryView: UIView, UITextFieldDelegate {
    
    let textField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupTextField() {
        textField.delegate = self
        
        textField.textColor = ThemeColor.subheading
        textField.backgroundColor = ThemeColor.overlay
        textField.layer.borderColor = ThemeColor.subheading.cgColor
        
        self.addSubview(textField)
        
        // Constraints
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: self.topAnchor),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}

extension EntryView {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
