//
//  PopUpEditSectionView.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/20/21.
//

import UIKit

class EditSectionView: UIView {
    
    lazy var sectionName = ""
    var colorChoice: UIColor?
    var deleteSection: Bool = false
    private let titleLabel = UILabel()
    private let deleteLabel = UILabel()
    private let yesButton = UIButton()
    private let changeTitleLabel = UILabel()
    private let changeTitleTextField = UITextField()
    private let changeColorLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupTitleLabel()
        setupDeleteLabel()
        setupYesButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Subview Setup

extension EditSectionView {
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
        configureLabel(label: titleLabel, text: "Edit Section")
        
        // Constraints
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    private func setupDeleteLabel() {
        configureLabel(label: deleteLabel, text: "Delete this section?")
        
        // Constraints
        deleteLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            deleteLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            deleteLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
        ])
    }
    
    private func setupYesButton() {
        yesButton.layer.cornerRadius = 14
        yesButton.layer.borderWidth = 0.5
        yesButton.layer.borderColor = ThemeColor.subheading.cgColor
        yesButton.backgroundColor = .clear
        yesButton.setTitleColor(ThemeColor.heading, for: .normal)
        self.addSubview(yesButton)
        
        // Add action
        yesButton.addAction(UIAction { action in
            if !self.deleteSection {
                self.deleteSection = true
                self.yesButton.setTitle("X", for: .normal)
            }
            else {
                self.deleteSection = false
                self.yesButton.setTitle("", for: .normal)
            }
        }, for: .touchUpInside)
        
        // Constraints
        yesButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            yesButton.topAnchor.constraint(equalTo: deleteLabel.topAnchor),
            yesButton.leadingAnchor.constraint(equalTo: deleteLabel.trailingAnchor, constant: 50),
            yesButton.heightAnchor.constraint(equalToConstant: 28),
            yesButton.widthAnchor.constraint(equalToConstant: 28)
        ])
    }
}
