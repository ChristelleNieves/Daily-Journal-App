//
//  EditListView.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/20/21.
//

import UIKit

class EditListView: UIView, UITextFieldDelegate {
    
    var changedTitle: Bool = false
    lazy var sectionName = ""
    private let titleLabel = UILabel()
    private let changeTitleLabel = UILabel()
    private let changeTitleTextField = UITextField()
    var colorButtonView = ColorButtonView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupTitleLabel()
        setupChangeTitleLabel()
        setupChangeTitleTextField()
        setupColorButtonView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Subview Setup

extension EditListView {
    private func setupView() {
        self.backgroundColor = ThemeColor.background
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.5
        self.layer.cornerRadius = 40
    }
    
    private func configureLabel(label: UILabel, text: String) {
        label.text = text
        label.textColor = ThemeColor.heading
        label.font = UIFont.systemFont(ofSize: 17, weight: .light)
        self.addSubview(label)
    }
    
    private func setupTitleLabel() {
        configureLabel(label: titleLabel, text: "Edit List")
        
        // Constraints
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    private func setupChangeTitleLabel() {
        configureLabel(label: changeTitleLabel, text: "Change Title:")
        
        // Set Constraints
        changeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            changeTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            changeTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        ])
    }
    
    private func setupChangeTitleTextField() {
        changeTitleTextField.delegate = self
        changeTitleTextField.backgroundColor = .clear
        changeTitleTextField.borderStyle = .roundedRect
        changeTitleTextField.attributedPlaceholder = NSAttributedString(string: "Enter New title here..")
        
        self.addSubview(changeTitleTextField)
        
        // Set Constraints
        changeTitleTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            changeTitleTextField.topAnchor.constraint(equalTo: changeTitleLabel.bottomAnchor, constant: 10),
            changeTitleTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            changeTitleTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
    }
    
    private func setupColorButtonView() {
        self.addSubview(colorButtonView)
        
        colorButtonView.label.text = "Change Color:"
        
        // Set constraints
        colorButtonView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            colorButtonView.topAnchor.constraint(equalTo: changeTitleTextField.bottomAnchor, constant: 20),
            colorButtonView.leadingAnchor.constraint(equalTo: changeTitleLabel.leadingAnchor),
            colorButtonView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            colorButtonView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    // Returns the text from the title textField, or an empty string if text is nil.
    func getName() -> String {
        
        return changeTitleTextField.text?.description ?? ""
    }
}

// MARK: TextField
extension EditListView {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        self.changedTitle = true
        
        return true
    }
    
    // Only allow textfield to accept 30 characters or less
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // get the current text, or use an empty string if that failed
        let currentText = textField.text ?? ""
        
        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        // add their new text to the existing text
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        
        // make sure the result is under 25 characters
        return updatedText.count <= 25
    }
}
