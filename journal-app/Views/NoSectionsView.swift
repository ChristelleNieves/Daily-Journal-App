//
//  NoSectionsView.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/17/21.
//

import UIKit

class NoSectionsView: UIView {
    
    private let headingLabel = UILabel()
    private let subHeadingLabel = UILabel()
    private let arrowImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAllSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: View Setup

extension NoSectionsView {
    
    // Configure all the views within this view
    private func setupAllSubviews() {
        setupView()
        setupHeadingLabel()
        setupSubheadingLabel()
        setupArrowImageView()
    }
    
    // Configure the main view
    private func setupView() {
        self.backgroundColor = ThemeColor.robinEggBlue
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.5
        self.layer.cornerRadius = 40
    }
    
    // Configure the heading label and add it to the main view
    private func setupHeadingLabel() {
        headingLabel.text = "Looks like you haven't added any sections to your journal yet!"
        headingLabel.textColor = ThemeColor.heading
        headingLabel.font = UIFont.systemFont(ofSize: 30, weight: .light)
        headingLabel.numberOfLines = 0
        headingLabel.lineBreakMode = .byWordWrapping
        
        self.addSubview(headingLabel)
        
        // Constraints
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headingLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            headingLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            headingLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }
    
    // Configure the subHeading label and add it to the main view
    private func setupSubheadingLabel() {
        subHeadingLabel.text = "Add a section using the add button below to get started!"
        subHeadingLabel.textColor = ThemeColor.subheading
        subHeadingLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
        subHeadingLabel.numberOfLines = 0
        subHeadingLabel.lineBreakMode = .byWordWrapping
        
        self.addSubview(subHeadingLabel)
        
        // Constraints
        subHeadingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subHeadingLabel.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 10),
            subHeadingLabel.leadingAnchor.constraint(equalTo: headingLabel.leadingAnchor),
            subHeadingLabel.trailingAnchor.constraint(equalTo: headingLabel.trailingAnchor)
        ])
    }
    
    // Configure the arrow image view and add it to the main view
    private func setupArrowImageView() {
        let config = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 40, weight: .light), scale: .default)
        
        arrowImageView.image = UIImage(systemName: "arrow.down", withConfiguration: config)
        arrowImageView.tintColor = UIColor.darkGray.withAlphaComponent(0.30)
        
        self.addSubview(arrowImageView)
        
        // Constraints
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            arrowImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            arrowImageView.topAnchor.constraint(equalTo: subHeadingLabel.bottomAnchor, constant: 20),
            arrowImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
}
