//
//  MoodViewController.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/16/21.
//

import UIKit

class MoodViewController: UIViewController, UITextFieldDelegate {
    
    private let whyLabel = UILabel()
    private let moodLabel = UILabel()
    private let whyView = MoodReasonView(frame: CGRect.zero)
    private let moodView = MoodChoicesView(frame: CGRect.zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainView()
        setupMoodLabel()
        setupMoodView()
        setupWhyLabel()
        setupWhyView()
    }
}

// MARK: Setup
extension MoodViewController {
    private func setupMainView() {
        view.backgroundColor = JournalColors.robinEggBlue
    }
    
    private func setupMoodLabel() {
        configureLabel(label: moodLabel, titleString: "How are you feeling today?")
        
        // Constraints
        moodLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            moodLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            moodLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            moodLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupMoodView() {
        view.addSubview(moodView)
        
        // Constraints
        moodView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            moodView.topAnchor.constraint(equalTo: moodLabel.bottomAnchor, constant: 30),
            moodView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            moodView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            moodView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/7)
        ])
    }
    
    private func setupWhyLabel() {
        configureLabel(label: whyLabel, titleString: "Why?")
        
        // Constraints
        whyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            whyLabel.topAnchor.constraint(equalTo: moodView.bottomAnchor, constant: 50),
            whyLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            whyLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupWhyView() {
        view.addSubview(whyView)
        
        // Constraints
        whyView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            whyView.topAnchor.constraint(equalTo: whyLabel.bottomAnchor, constant: 30),
            whyView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            whyView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            whyView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/6)
        ])
    }
    
    private func configureLabel(label: UILabel, titleString: String) {
        label.text = titleString
        label.font = UIFont.systemFont(ofSize: 30, weight: .light)
        label.textColor = UIColor.darkGray
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        view.addSubview(label)
    }
}
