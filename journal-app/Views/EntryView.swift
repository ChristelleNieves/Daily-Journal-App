//
//  entryView.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/18/21.
//

import UIKit

class EntryView: UIView, UITextFieldDelegate {
    
    typealias ActionHandler = (Action) -> ()
    private var actionHandler: ActionHandler?
    var textField = UITextField()
    private let height: CGFloat = 35
    
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
        textField.font = UIFont.systemFont(ofSize: 17, weight: .light)
        textField.backgroundColor = ThemeColor.overlay.withAlphaComponent(0.7)
        textField.layer.cornerRadius = 10
        
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
    func textFieldDidEndEditing(_ textField: UITextField) {
        didEditEntry()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 1, height: height)
    }
}

extension EntryView {
    enum Action {
        case editEntry
    }
    
    func setActionHandler(_ handler: @escaping ActionHandler) {
        self.actionHandler = handler
    }
    
    func didEditEntry() {
        self.actionHandler?(.editEntry)
    }
}
