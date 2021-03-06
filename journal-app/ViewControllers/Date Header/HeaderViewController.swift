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
    private var todayDate = Date()
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
        dayLabel.text = getTodayWeekDay(todayDate)
        dayLabel.font = UIFont.systemFont(ofSize: 27, weight: .light)
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
        dateLabel.text = formatDate(todayDate)
        dateLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
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
        
        calendarVC.setActionHandler { action in
            switch action {
            case .selectDate(let date):
                self.dayLabel.text = self.getTodayWeekDay(date)
                self.dateLabel.text = self.formatDate(date)
                break
            }
        }
        
        self.present(calendarVC, animated: true, completion: nil)
    }
    
    private func setupLeftButton() {
        leftButton.setImage(UIImage(named: "previous"), for: .normal)
        leftButton.imageView?.contentMode = .scaleAspectFit
        view.addSubview(leftButton)
        
        leftButton.addAction(UIAction { action in
            self.decrementDate()
        }, for: .touchUpInside)
        
        // Constraints
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            leftButton.centerYAnchor.constraint(equalTo: dayLabel.bottomAnchor),
            leftButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            leftButton.widthAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    private func setupRightButton() {
        rightButton.setImage(UIImage(named: "next"), for: .normal)
        rightButton.imageView?.contentMode = .scaleAspectFit
        view.addSubview(rightButton)
        
        rightButton.addAction(UIAction { action in
            self.incrementDate()
        }, for: .touchUpInside)
        
        // Constraints
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rightButton.centerYAnchor.constraint(equalTo: leftButton.centerYAnchor),
            rightButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            rightButton.widthAnchor.constraint(equalToConstant: 35)
        ])
    }
}

// MARK: Date Helper Functions
extension HeaderViewController {
    
    private func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        return dateFormatter.string(from: date)
    }
    
    private func getTodayWeekDay(_ date: Date)-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let weekDay = dateFormatter.string(from: date)
        return weekDay
      }
    
    private func incrementDate() {
        let modifiedDate = Calendar.current.date(byAdding: .day, value: 1, to: todayDate)
        todayDate = modifiedDate!
        self.dayLabel.text = getTodayWeekDay(todayDate)
        self.dateLabel.text = formatDate(todayDate)
    }
    
    private func decrementDate() {
        let modifiedDate = Calendar.current.date(byAdding: .day, value: -1, to: todayDate)
        todayDate = modifiedDate!
        self.dayLabel.text = getTodayWeekDay(todayDate)
        self.dateLabel.text = formatDate(todayDate)
    }
}

extension HeaderViewController {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
