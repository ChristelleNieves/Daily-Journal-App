//
//  PopUpAddSectionView.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/17/21.
//

import UIKit

class PopUpAddSectionView: UIView {
    
    private let titleLabel = UILabel()
    private let journalTitleLabel = UILabel()
    private let journalTitleTextField = UITextField()
    private let journalTypeLabel = UILabel()
    private let journalTypePicker = UIPickerView()
    private let colorLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupTitleLabel()
        setupJournalTitleLabel()
        setupJournalTitleTextField()
        setupJournalTypeLabel()
        setupColorLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PopUpAddSectionView {
    private func setupView() {
        self.backgroundColor = JournalColors.teaGreen.withAlphaComponent(0.50)
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.5
        self.layer.cornerRadius = 40
    }
    
    private func setupTitleLabel() {
        titleLabel.text = "Create New Section"
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
        journalTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        journalTitleLabel.textColor = UIColor.darkGray
        self.addSubview(journalTitleLabel)
        
        // Constraints
        journalTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            journalTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 35),
            journalTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        ])
    }
    
    private func setupJournalTitleTextField() {
        journalTitleTextField.backgroundColor = .white
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
        journalTypeLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        self.addSubview(journalTypeLabel)
        
        // Constraints
        journalTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            journalTypeLabel.topAnchor.constraint(equalTo: journalTitleLabel.bottomAnchor, constant: 35),
            journalTypeLabel.leadingAnchor.constraint(equalTo: journalTitleLabel.leadingAnchor)
        ])
    }
    
    private func setupColorLabel() {
        colorLabel.text = "Section Color:"
        colorLabel.textColor = UIColor.darkGray
        colorLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        self.addSubview(colorLabel)
        
        // Constraints
        colorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            colorLabel.topAnchor.constraint(equalTo: journalTypeLabel.bottomAnchor, constant: 35),
            colorLabel.leadingAnchor.constraint(equalTo: journalTypeLabel.leadingAnchor)
        ])
    }
}
