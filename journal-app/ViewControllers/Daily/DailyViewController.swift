//
//  MoodViewController.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/16/21.
//

import UIKit

class DailyViewController: UIViewController, UITextFieldDelegate {
    
    private let moodLabel = UILabel()
    private let questionsLabel = UILabel()
    private let moodVC = MoodViewController()
    private let questionsVC = QuestionsViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainView()
        setupMoodLabel()
        setupMoodVC()
        setupQuestionsLabel()
        setupQuestionsVC()
    }
}

// MARK: Setup
extension DailyViewController {
    private func setupMainView() {
        view.backgroundColor = ThemeColor.color3
    }
    
    private func setupMoodLabel() {
        moodLabel.text = "How are you feeling today?"
        moodLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        moodLabel.textColor = ThemeColor.heading
        view.addSubview(moodLabel)
        
        // Constraints
        moodLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            moodLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            moodLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
    }
    
    private func setupMoodVC() {
        self.addChild(moodVC)
        self.view.addSubview(moodVC.view)
        
        // Constraints
        moodVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            moodVC.view.topAnchor.constraint(equalTo: moodLabel.bottomAnchor, constant: 20),
            moodVC.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            moodVC.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            moodVC.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/7)
        ])
    }
    
    private func setupQuestionsLabel() {
        questionsLabel.text = "Your daily journal prompts"
        questionsLabel.font = UIFont.systemFont(ofSize: 20, weight: .light)
        questionsLabel.textColor = ThemeColor.heading
        view.addSubview(questionsLabel)
        
        // Constraints
        questionsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            questionsLabel.topAnchor.constraint(equalTo: moodVC.view.bottomAnchor, constant: 40),
            questionsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20)
        ])
    }
    
    private func setupQuestionsVC() {
        addChild(questionsVC)
        view.addSubview(questionsVC.view)
        
        // Constraints
        questionsVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            questionsVC.view.topAnchor.constraint(equalTo: questionsLabel.bottomAnchor, constant: 10),
            questionsVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            questionsVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            questionsVC.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3)
        ])
    }
}
