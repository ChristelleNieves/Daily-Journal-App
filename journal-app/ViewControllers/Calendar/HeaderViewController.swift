//
//  HeaderViewController.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/26/21.
//

import UIKit
import FSCalendar

class HeaderViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, UIViewControllerTransitioningDelegate {
    
    let dayLabel = UILabel()
    let dateLabel = UILabel()
    private var date = Date()
    private let leftButton = UIButton()
    private let rightButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear

        // Do any additional setup after loading the view.
        setupDayLabel()
        setupDateLabel()
        setupLeftButton()
        setupRightButton()
    }
}

// MARK: UI Setup
extension HeaderViewController {
    private func setupDayLabel() {
        dayLabel.text = getTodayWeekDay()
        dayLabel.font = UIFont.systemFont(ofSize: 30, weight: .light)
        dayLabel.textColor = ThemeColor.heading
        dayLabel.adjustsFontSizeToFitWidth = true
        dayLabel.numberOfLines = 0
        view.addSubview(dayLabel)
        
        // Constraints
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            dayLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // Set up the tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openCalendar))
        dayLabel.isUserInteractionEnabled = true
        dayLabel.addGestureRecognizer(tapGesture)
    }
    
    private func setupDateLabel() {
        dateLabel.text = formatDate()
        dateLabel.font = UIFont.systemFont(ofSize: 17, weight: .light)
        dateLabel.textColor = ThemeColor.subheading
        dateLabel.adjustsFontSizeToFitWidth = true
        dateLabel.numberOfLines = 0
        view.addSubview(dateLabel)
        
        // Constraints
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 5),
            dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // Set up the tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openCalendar))
        dateLabel.isUserInteractionEnabled = true
        dateLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc private func openCalendar() {
        let calendarVC = CalendarViewController()
        calendarVC.modalPresentationStyle = .custom
        calendarVC.transitioningDelegate = self
        self.present(calendarVC, animated: true, completion: nil)
    }
    
    private func setupLeftButton() {
        let config = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 25, weight: .light), scale: .medium)
        leftButton.setImage(UIImage(systemName: "arrowshape.turn.up.left", withConfiguration: config), for: .normal)
        leftButton.tintColor = ThemeColor.subheading
        view.addSubview(leftButton)
        
        leftButton.addAction(UIAction { action in
            self.decrementDate()
        }, for: .touchUpInside)
        
        // Constraints
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leftButton.topAnchor.constraint(equalTo: dayLabel.bottomAnchor),
            leftButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        ])
    }
    
    private func setupRightButton() {
        let config = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 25, weight: .light), scale: .medium)
        
        rightButton.setImage(UIImage(systemName: "arrowshape.turn.up.right", withConfiguration: config), for: .normal)
        rightButton.tintColor = ThemeColor.subheading
        view.addSubview(rightButton)
        
        rightButton.addAction(UIAction { action in
            self.incrementDate()
        }, for: .touchUpInside)
        
        // Constraints
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rightButton.topAnchor.constraint(equalTo: dayLabel.bottomAnchor),
            rightButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
        ])
    }
}

// MARK: Date Helper Functions
extension HeaderViewController {
    
    private func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        return dateFormatter.string(from: date)
    }
    
    private func getTodayWeekDay()-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let weekDay = dateFormatter.string(from: date)
        return weekDay
      }
    
    private func incrementDate() {
        let modifiedDate = Calendar.current.date(byAdding: .day, value: 1, to: date)
        date = modifiedDate!
        self.dayLabel.text = getTodayWeekDay()
        self.dateLabel.text = formatDate()
    }
    
    private func decrementDate() {
        let modifiedDate = Calendar.current.date(byAdding: .day, value: -1, to: date)
        date = modifiedDate!
        self.dayLabel.text = getTodayWeekDay()
        self.dateLabel.text = formatDate()
    }
}

extension HeaderViewController {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
