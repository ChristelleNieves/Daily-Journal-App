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
        
        textField.textColor = UIColor.darkGray.withAlphaComponent(0.60)
        textField.backgroundColor = UIColor.init(white: 1, alpha: 0.50)
        textField.layer.borderColor = UIColor.darkGray.withAlphaComponent(0.70).cgColor
        textField.borderStyle = .roundedRect
        
        self.addSubview(textField)
        
        // Constraints
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: self.topAnchor),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

extension EntryView {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
