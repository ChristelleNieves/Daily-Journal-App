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
    private var date = Date()
    private let leftButton = UIButton()
    private let rightButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupDayLabel()
        setupDateLabel()
        setupLeftButton()
        setupRightButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: UI Setup
extension TableHeader {
    func setupDayLabel() {
        dayLabel.text = getTodayWeekDay()
        dayLabel.font = UIFont.systemFont(ofSize: 30, weight: .light)
        dayLabel.textColor = UIColor.darkGray
        dayLabel.adjustsFontSizeToFitWidth = true
        dayLabel.numberOfLines = 0
        self.addSubview(dayLabel)
        
        // Constraints
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            dayLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    func setupDateLabel() {
        dateLabel.text = formatDate()
        dateLabel.font = UIFont.systemFont(ofSize: 17, weight: .light)
        dateLabel.textColor = UIColor.darkGray.withAlphaComponent(0.80)
        dateLabel.adjustsFontSizeToFitWidth = true
        dateLabel.numberOfLines = 0
        self.addSubview(dateLabel)
        
        // Constraints
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
        
        leftButton.addAction(UIAction { action in
            self.decrementDate()
        }, for: .touchUpInside)
        
        // Constraints
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leftButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            leftButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30)
        ])
    }
    
    func setupRightButton() {
        let config = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 25, weight: .light), scale: .medium)
        rightButton.setImage(UIImage(systemName: "arrowshape.turn.up.right", withConfiguration: config), for: .normal)
        rightButton.tintColor = UIColor.darkGray.withAlphaComponent(0.70)
        self.addSubview(rightButton)
        
        rightButton.addAction(UIAction { action in
            self.incrementDate()
        }, for: .touchUpInside)
        
        // Constraints
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rightButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            rightButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30)
        ])
    }
}

// MARK: Date Helper Functions
extension TableHeader {
    
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        return dateFormatter.string(from: date)
    }
    
    func getTodayWeekDay()-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let weekDay = dateFormatter.string(from: date)
        return weekDay
      }
    
    func incrementDate() {
        let modifiedDate = Calendar.current.date(byAdding: .day, value: 1, to: date)
        date = modifiedDate!
        self.dayLabel.text = getTodayWeekDay()
        self.dateLabel.text = formatDate()
    }
    
    func decrementDate() {
        let modifiedDate = Calendar.current.date(byAdding: .day, value: -1, to: date)
        date = modifiedDate!
        self.dayLabel.text = getTodayWeekDay()
        self.dateLabel.text = formatDate()
    }
}
