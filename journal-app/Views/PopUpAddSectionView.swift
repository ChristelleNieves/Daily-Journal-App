//
//  PopUpAddSectionView.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/17/21.
//

import UIKit

class PopUpAddSectionView: UIView, UITextFieldDelegate {
    
    private let titleLabel = UILabel()
    private let journalTitleLabel = UILabel()
    private var colorChoice: UIColor?
    private let journalTitleTextField = UITextField()
    private let colorButtonView = ColorButtonView(frame: CGRect.zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAllSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Subview Setup

extension PopUpAddSectionView {
    
    private func setupView() {
        self.backgroundColor = ThemeColor.background
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.5
        self.layer.cornerRadius = 40
    }
    
    private func setupTitleLabel() {
        titleLabel.text = "Add New Section"
        titleLabel.textColor = UIColor.darkGray
        titleLabel.font = UIFont.systemFont(ofSize: 25, weight: .light)
        
        self.addSubview(titleLabel)
        
        // Set Constraints
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    private func setupJournalTitleLabel() {
        configureLabel(label: journalTitleLabel, text: "Section Name:")
        
        // Set Constraints
        journalTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            journalTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            journalTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        ])
    }
    
    private func setupJournalTitleTextField() {
        journalTitleTextField.delegate = self
        journalTitleTextField.backgroundColor = .clear
        journalTitleTextField.borderStyle = .roundedRect
        journalTitleTextField.attributedPlaceholder = NSAttributedString(string: "Enter title here..")
        
        self.addSubview(journalTitleTextField)
        
        // Set Constraints
        journalTitleTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            journalTitleTextField.topAnchor.constraint(equalTo: journalTitleLabel.topAnchor),
            journalTitleTextField.leadingAnchor.constraint(equalTo: journalTitleLabel.trailingAnchor, constant: 5),
            journalTitleTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)
        ])
    }
    
    private func setupColorButtonView() {
        self.addSubview(colorButtonView)
        colorButtonView.label.text = "Section Color:"
        colorButtonView.isUserInteractionEnabled = true
        
        // Set constraints
        colorButtonView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            colorButtonView.topAnchor.constraint(equalTo: journalTitleLabel.bottomAnchor, constant: 70),
            colorButtonView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            colorButtonView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            colorButtonView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

// MARK: Helper Functions

extension PopUpAddSectionView {
    // Add all the subviews to the main view
    private func setupAllSubviews() {
        setupView()
        setupTitleLabel()
        setupJournalTitleLabel()
        setupJournalTitleTextField()
        setupColorButtonView()
    }
    
    // Configures the style aspects of a label
    private func configureLabel(label: UILabel, text: String) {
        label.text = text
        label.textColor = ThemeColor.heading
        label.font = UIFont.systemFont(ofSize: 17, weight: .light)
        
        self.addSubview(label)
    }
    
    // Returns the text from the title textField, or an empty string if text is nil.
    func getName() -> String {
        
        return journalTitleTextField.text?.description ?? ""
    }
    
    func getColorChoice() -> UIColor {
        return colorButtonView.colorChoice
    }
}

// MARK: TextField
extension PopUpAddSectionView {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
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
