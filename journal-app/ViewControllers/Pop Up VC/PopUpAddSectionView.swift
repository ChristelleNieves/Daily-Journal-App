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
    private let journalTypeLabel = UILabel()
    private let journalTypePicker = UIPickerView()
    private let colorLabel = UILabel()
    private let blueButton = UIButton()
    private let greenButton = UIButton()
    private let pinkButton = UIButton()
    
    private var colorChoice: UIColor?
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupTitleLabel()
        setupJournalTitleLabel()
        setupJournalTitleTextField()
        setupJournalTypeLabel()
        setupColorLabel()
        setupBlueButton()
        setupPinkButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PopUpAddSectionView {
    private func setupView() {
        self.backgroundColor = JournalColors.teaGreen.withAlphaComponent(0.70)
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
        journalTitleLabel.text = "Section Name:"
        journalTitleLabel.font = UIFont.systemFont(ofSize: 17, weight: .light)
        journalTitleLabel.textColor = UIColor.darkGray
        self.addSubview(journalTitleLabel)
        
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
    
    private func setupJournalTypeLabel() {
        journalTypeLabel.text = "Section Type:"
        journalTypeLabel.textColor = UIColor.darkGray
        journalTypeLabel.font = UIFont.systemFont(ofSize: 17, weight: .light)
        self.addSubview(journalTypeLabel)
        
        // Constraints
        journalTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            journalTypeLabel.topAnchor.constraint(equalTo: journalTitleLabel.bottomAnchor, constant: 40),
            journalTypeLabel.leadingAnchor.constraint(equalTo: journalTitleLabel.leadingAnchor)
        ])
    }
    
    private func setupColorLabel() {
        colorLabel.text = "Section Color:"
        colorLabel.textColor = UIColor.darkGray
        colorLabel.font = UIFont.systemFont(ofSize: 17, weight: .light)
        self.addSubview(colorLabel)
        
        // Constraints
        colorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            colorLabel.topAnchor.constraint(equalTo: journalTypeLabel.bottomAnchor, constant: 40),
            colorLabel.leadingAnchor.constraint(equalTo: journalTypeLabel.leadingAnchor)
        ])
    }
    
    private func setupBlueButton() {
        // Blue button
        blueButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        blueButton.layer.cornerRadius = blueButton.frame.size.width * 0.5
        blueButton.layer.borderWidth = 1
        blueButton.layer.borderColor = UIColor.darkGray.cgColor
        blueButton.clipsToBounds = true
        blueButton.backgroundColor = JournalColors.robinEggBlue
        self.addSubview(blueButton)
        
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
        // Pink buttton
        pinkButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        pinkButton.layer.cornerRadius = blueButton.frame.size.width * 0.5
        pinkButton.layer.borderWidth = 1
        pinkButton.layer.borderColor = UIColor.darkGray.cgColor
        pinkButton.clipsToBounds = true
        pinkButton.backgroundColor = JournalColors.pink
        self.addSubview(pinkButton)
        
        pinkButton.addAction(UIAction { action in
            self.colorChoice = JournalColors.pink
        }, for: .touchUpInside)
        
        pinkButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pinkButton.topAnchor.constraint(equalTo: colorLabel.topAnchor),
            pinkButton.leadingAnchor.constraint(equalTo: blueButton.trailingAnchor, constant: 15)
        ])
    }
    
    func getName() -> String {
        return journalTitleTextField.text?.description ?? ""
    }
    
    func getColorChoice() -> UIColor {
        return colorChoice ?? JournalColors.lavender
    }
}

extension PopUpAddSectionView {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

