//
//  QuestionCell.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/30/21.
//

import UIKit

class QuestionCell: UICollectionViewCell {
    
    static let reuseIdentifier = "QuestionCell"
    var question = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContentView()
        setupQuestion()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension QuestionCell {
    private func setupContentView() {
        contentView.backgroundColor = ThemeColor.color1.withAlphaComponent(0.70)
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = UIColor.gray.cgColor
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowOpacity = 0.5
        
    }
    
    private func setupQuestion() {
        question.textColor = UIColor.white
        question.font = UIFont.systemFont(ofSize: 25, weight: .light)
        question.numberOfLines = 0
        question.adjustsFontSizeToFitWidth = true
        question.lineBreakMode = .byWordWrapping
        contentView.addSubview(question)
        
        // Constraints
        question.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            question.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            question.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            question.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ])
    }
}
