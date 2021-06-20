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
    private let journalTitleTextField = UITextField()
    private let colorLabel = UILabel()
    private let blueButton = UIButton()
    private let greenButton = UIButton()
    private let pinkButton = UIButton()
    private let peachButton = UIButton()
    private let purpleButton = UIButton()
    private var colorChoice: UIColor?
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupTitleLabel()
        setupJournalTitleLabel()
        setupJournalTitleTextField()
        setupColorLabel()
        setupBlueButton()
        setupPinkButton()
        setupPeachButton()
        setupPurpleButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PopUpAddSectionView {
    private func setupView() {
        self.backgroundColor = JournalColors.peach
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
        
        // Constraints
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    private func setupJournalTitleLabel() {
        configureLabel(label: journalTitleLabel, text: "Section Name:")
        
        // Constraints
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
        
        // Constraints
        journalTitleTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            journalTitleTextField.topAnchor.constraint(equalTo: journalTitleLabel.topAnchor),
            journalTitleTextField.leadingAnchor.constraint(equalTo: journalTitleLabel.trailingAnchor, constant: 5),
            journalTitleTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)
        ])
    }
    
    private func setupColorLabel() {
        configureLabel(label: colorLabel, text: "Section Color:")
        
        // Constraints
        colorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            colorLabel.topAnchor.constraint(equalTo: journalTitleLabel.bottomAnchor, constant: 70),
            colorLabel.leadingAnchor.constraint(equalTo: journalTitleLabel.leadingAnchor)
        ])
    }
    
    private func setupBlueButton() {
        configureColorButton(button: blueButton)
        blueButton.backgroundColor = JournalColors.robinEggBlue
        
        blueButton.addAction(UIAction { action in
            self.colorChoice = JournalColors.robinEggBlue
        }, for: .touchUpInside)
        
        blueButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            blueButton.topAnchor.constraint(equalTo: colorLabel.topAnchor),
            blueButton.leadingAnchor.constraint(equalTo: colorLabel.trailingAnchor, constant: 15)
        ])
    }
    
    private func setupPinkButton() {
        configureColorButton(button: pinkButton)
        pinkButton.backgroundColor = JournalColors.salmonPink
        
        pinkButton.addAction(UIAction { action in
            self.colorChoice = JournalColors.salmonPink
        }, for: .touchUpInside)
        
        pinkButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pinkButton.topAnchor.constraint(equalTo: colorLabel.topAnchor),
            pinkButton.leadingAnchor.constraint(equalTo: blueButton.trailingAnchor, constant: 12)
        ])
    }
    
    private func setupPeachButton() {
        configureColorButton(button: peachButton)
        peachButton.backgroundColor = JournalColors.peachPuff
        
        peachButton.addAction(UIAction { action in
            self.colorChoice = JournalColors.peachPuff
        }, for: .touchUpInside)
        
        peachButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            peachButton.topAnchor.constraint(equalTo: colorLabel.topAnchor),
            peachButton.leadingAnchor.constraint(equalTo: pinkButton.trailingAnchor, constant: 12)
        ])
    }
    
    private func setupPurpleButton() {
        configureColorButton(button: purpleButton)
        purpleButton.backgroundColor = JournalColors.lilac
        
        purpleButton.addAction(UIAction { action in
            self.colorChoice = JournalColors.lilac
        }, for: .touchUpInside)
        
        purpleButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            purpleButton.topAnchor.constraint(equalTo: colorLabel.topAnchor),
            purpleButton.leadingAnchor.constraint(equalTo: peachButton.trailingAnchor, constant: 12)
        ])
    }
}


// MARK: Utility Functions
extension PopUpAddSectionView {
    func getName() -> String {
        return journalTitleTextField.text?.description ?? ""
    }
    
    func getColorChoice() -> UIColor {
        return colorChoice ?? JournalColors.robinEggBlue
    }
    
    func configureLabel(label: UILabel, text: String) {
        label.text = text
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 17, weight: .light)
        self.addSubview(label)
    }
    
    func configureColorButton(button: UIButton) {
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.layer.cornerRadius = button.frame.size.width * 0.5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.clipsToBounds = true
        self.addSubview(button)
    }
}


// MARK: TextField
extension PopUpAddSectionView {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

