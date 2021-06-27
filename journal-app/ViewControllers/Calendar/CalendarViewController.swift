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
    var topBar = UIView()
    
    typealias ActionHandler = (Action) -> ()
    private var actionHandler: ActionHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
        
        view.backgroundColor = .white
        setupTopBar()
        setupCalendar()
    }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    
    private func setupTopBar () {
        topBar.backgroundColor = UIColor.lightGray
        topBar.layer.cornerRadius = 2
        
        view.addSubview(topBar)
        
        // Constraints
        topBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            topBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topBar.widthAnchor.constraint(equalToConstant: 50),
            topBar.heightAnchor.constraint(equalToConstant: 4)
        ])
    }
    
    private func setupCalendar() {
        calendar.delegate = self
        calendar.dataSource = self
        calendar.clipsToBounds = false
        
        view.addSubview(calendar)
        
        calendar.backgroundColor = UIColor.white
        calendar.allowsSelection = true
        calendar.appearance.headerTitleColor = ThemeColor.color1
        calendar.appearance.todayColor = ThemeColor.color1.withAlphaComponent(0.5)
        calendar.appearance.selectionColor = ThemeColor.color1
        calendar.appearance.weekdayTextColor = ThemeColor.color1
        calendar.appearance.headerTitleFont = UIFont.systemFont(ofSize: 15, weight: .light)
        
        // Constraints
        calendar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: topBar.bottomAnchor, constant: 5),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            calendar.heightAnchor.constraint(equalTo: view.heightAnchor, constant: -20)
        ])
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        didSelectADate(date)
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

extension CalendarViewController {
    enum Action {
        case selectDate(Date)
    }
    
    func setActionHandler(_ handler: @escaping ActionHandler) {
        self.actionHandler = handler
    }
    
    func didSelectADate(_ date: Date) {
        self.actionHandler?(.selectDate(date))
    }
}
