//
//  JournalEntryCell.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/16/21.
//

import UIKit

class JournalEntryCell: UITableViewCell, UITextFieldDelegate {
    
    let textField = UITextField()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupTextField()
    }
}

// MARK: UI Setup

extension JournalEntryCell {
    func setupTextField() {
        textField.delegate = self
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .clear
        textField.layer.borderColor = UIColor.darkGray.withAlphaComponent(0.40).cgColor
        contentView.addSubview(textField)
        
        // Constraints
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            textField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
}

// MARK: TextField Configuration

extension JournalEntryCell {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Dismiss the keyboard
        textField.resignFirstResponder()
        
        return true
    }
}
