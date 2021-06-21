//
//  PopUpEditSectionView.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/20/21.
//

import UIKit

class PopUpEditSectionView: UIView {
    
    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAllSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PopUpEditSectionView {
    private func setupAllSubviews() {
        setupView()
    }
    
    private func setupView() {
        
        self.backgroundColor = ThemeColors.peach
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.5
        self.layer.cornerRadius = 40
    }
    
    private func setupTitleLabel() {
        
        titleLabel.text = "Delete Section?"
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
}
