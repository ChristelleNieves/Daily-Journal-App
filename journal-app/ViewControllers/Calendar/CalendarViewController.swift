//
//  CalendarViewController.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/26/21.
//

import UIKit
import FSCalendar

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    var calendar = FSCalendar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
        
        setupCalendar()
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    
    private func setupCalendar() {
        view.addSubview(calendar)
        calendar.clipsToBounds = false
        calendar.delegate = self
        calendar.dataSource = self
        
        // Bring to the front of all other views
        //view.layer.zPosition = 1
        
        calendar.backgroundColor = UIColor.white
        calendar.allowsSelection = true
        calendar.tintColor = .systemPink
        calendar.appearance.headerTitleColor = ThemeColor.color1
        calendar.appearance.todayColor = ThemeColor.color1.withAlphaComponent(0.5)
        calendar.appearance.selectionColor = ThemeColor.color1
        calendar.appearance.weekdayTextColor = ThemeColor.color1
        calendar.appearance.headerTitleFont = UIFont.systemFont(ofSize: 15, weight: .light)
        calendar.layer.cornerRadius = 15
        calendar.layer.borderWidth = 0.5
        calendar.layer.borderColor = ThemeColor.subheading.cgColor
        
        //calendar.isHidden = true
        
        // Constraints
        calendar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            calendar.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -20)
        ])
    }
    
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                }
            }
        }
    }
}


