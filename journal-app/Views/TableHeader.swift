//
//  TableHeader.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/16/21.
//

import UIKit

class TableHeader: UIView {
    
    let dayLabel = UILabel()
    let dateLabel = UILabel()
    private let leftButton = UIButton()
    private let rightButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupDayLabel()
        setupLabel()
        setupLeftButton()
        setupRightButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupDayLabel() {
        dayLabel.font = UIFont.systemFont(ofSize: 30, weight: .light)
        dayLabel.textColor = UIColor.darkGray
        self.addSubview(dayLabel)
        
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            dayLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    func setupLabel() {
        dateLabel.font = UIFont.systemFont(ofSize: 17, weight: .light)
        dateLabel.textColor = UIColor.darkGray.withAlphaComponent(0.80)
        self.addSubview(dateLabel)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 5),
            dateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    func setupLeftButton() {
        let config = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 25, weight: .light), scale: .medium)
        leftButton.setImage(UIImage(systemName: "arrowshape.turn.up.left", withConfiguration: config), for: .normal)
        leftButton.tintColor = UIColor.darkGray.withAlphaComponent(0.70)
        self.addSubview(leftButton)
        
        // Constraints
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leftButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            leftButton.trailingAnchor.constraint(equalTo: dayLabel.leadingAnchor, constant: -30)
        ])
    }
    
    func setupRightButton() {
        let config = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 25, weight: .light), scale: .medium)
        rightButton.setImage(UIImage(systemName: "arrowshape.turn.up.right", withConfiguration: config), for: .normal)
        rightButton.tintColor = UIColor.darkGray.withAlphaComponent(0.70)
        self.addSubview(rightButton)
        
        // Constraints
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rightButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            rightButton.leadingAnchor.constraint(equalTo: dayLabel.trailingAnchor, constant: 30)
        ])
    }
}
