//
//  MoodCell.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/30/21.
//

import UIKit

class MoodCell: UICollectionViewCell {
    
    static var reuseIdentifier = "MoodCell"
    var moodButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupContentView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupContentView() {
        contentView.isUserInteractionEnabled = false
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = UIColor.gray.cgColor
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowOpacity = 0.5
        
    }
    
    func setupMoodButton() {
        moodButton.isUserInteractionEnabled = false
        contentView.addSubview(moodButton)
        
        moodButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            moodButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3),
            moodButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 3),
            moodButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -3),
            moodButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3)
        ])
    }
    
}
