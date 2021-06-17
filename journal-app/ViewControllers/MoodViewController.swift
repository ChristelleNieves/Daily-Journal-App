//
//  MoodViewController.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/16/21.
//

import UIKit

class MoodViewController: UIViewController, UITextFieldDelegate {
    
    private let moodLabel = UILabel()
    private let moodView = UIView()
    private let happyButton = UIButton()
    private let sadButton = UIButton()
    private let madButton = UIButton()
    private let neutralButton = UIButton()
    private let whyLabel = UILabel()
    private let whyView = UIView()
    private let textField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainView()
        setupMoodLabel()
        setupMoodView()
        setupHappyButton()
        setupSadButton()
        setupMadButton()
        setupNeutralButton()
        setupWhyLabel()
        setupWhyView()
        setupTextField()
    }
}

extension MoodViewController {
    func setupMainView() {
        view.backgroundColor = JournalColors.green
    }
    
    func setupMoodLabel() {
        moodLabel.text = "How are you feeling today?"
        moodLabel.font = UIFont.systemFont(ofSize: 30, weight: .light)
        moodLabel.textColor = UIColor.darkGray
        moodLabel.adjustsFontSizeToFitWidth = true
        moodLabel.numberOfLines = 0
        moodLabel.lineBreakMode = .byWordWrapping
        view.addSubview(moodLabel)
        
        // Constraints
        moodLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            moodLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            moodLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            moodLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    func setupMoodView() {
        moodView.backgroundColor = JournalColors.peach
        moodView.layer.shadowColor = UIColor.gray.cgColor
        moodView.layer.shadowRadius = 5
        moodView.layer.shadowOpacity = 0.5
        moodView.layer.cornerRadius = 40
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
    
    func setupHappyButton() {
        happyButton.setImage("🙂".image(), for: .normal)
        moodView.addSubview(happyButton)
        
        // Constraints
        happyButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            happyButton.centerYAnchor.constraint(equalTo: moodView.centerYAnchor),
            happyButton.leadingAnchor.constraint(equalTo: moodView.leadingAnchor, constant: 30)
        ])
    }
    
    func setupSadButton() {
        sadButton.setImage("😢".image(), for: .normal)
        moodView.addSubview(sadButton)
        
        // Constraints
        sadButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sadButton.centerYAnchor.constraint(equalTo: moodView.centerYAnchor),
            sadButton.leadingAnchor.constraint(equalTo: happyButton.trailingAnchor, constant: 15)
        ])
    }
    
    func setupMadButton() {
        madButton.setImage("😠".image(), for: .normal)
        moodView.addSubview(madButton)
        
        // Constraints
        madButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            madButton.centerYAnchor.constraint(equalTo: moodView.centerYAnchor),
            madButton.leadingAnchor.constraint(equalTo: sadButton.trailingAnchor, constant: 15)
        ])
    }
    
    func setupNeutralButton() {
        neutralButton.setImage("😐".image(), for: .normal)
        moodView.addSubview(neutralButton)
        
        // Constraints
        neutralButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            neutralButton.centerYAnchor.constraint(equalTo: moodView.centerYAnchor),
            neutralButton.leadingAnchor.constraint(equalTo: madButton.trailingAnchor, constant: 15)
        ])
    }
    
    func setupWhyLabel() {
        whyLabel.text = "Why?"
        whyLabel.font = UIFont.systemFont(ofSize: 30, weight: .light)
        whyLabel.textColor = UIColor.darkGray
        whyLabel.adjustsFontSizeToFitWidth = true
        whyLabel.numberOfLines = 0
        whyLabel.lineBreakMode = .byWordWrapping
        view.addSubview(whyLabel)
        
        // Constraints
        whyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            whyLabel.topAnchor.constraint(equalTo: moodView.bottomAnchor, constant: 50),
            whyLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            whyLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    func setupWhyView() {
        whyView.backgroundColor = JournalColors.peach
        whyView.layer.shadowColor = UIColor.gray.cgColor
        whyView.layer.shadowRadius = 5
        whyView.layer.shadowOpacity = 0.5
        whyView.layer.cornerRadius = 40
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
    
    func setupTextField() {
        textField.delegate = self
        textField.attributedPlaceholder = NSAttributedString(string: "Write something here..", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.withAlphaComponent(0.50)])
        textField.tintColor = UIColor.darkGray
        textField.backgroundColor = .clear
        textField.layer.borderColor = UIColor.darkGray.cgColor
        textField.borderStyle = .roundedRect
        whyView.addSubview(textField)
        
        // Constraints
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: whyView.topAnchor, constant: 30),
            textField.leadingAnchor.constraint(equalTo: whyView.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: whyView.trailingAnchor, constant: -20),
            textField.bottomAnchor.constraint(equalTo: whyView.bottomAnchor, constant: -30)
        ])
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Dismiss the keyboard
        textField.resignFirstResponder()
        
        return true
    }
}

extension String
{
    func image(fontSize:CGFloat = 50, bgColor:UIColor = UIColor.clear, imageSize:CGSize? = nil) -> UIImage?
    {
        let font = UIFont.systemFont(ofSize: fontSize)
        let attributes = [NSAttributedString.Key.font: font]
        let imageSize = imageSize ?? self.size(withAttributes: attributes)

        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
        bgColor.set()
        let rect = CGRect(origin: .zero, size: imageSize)
        UIRectFill(rect)
        self.draw(in: rect, withAttributes: [.font: font])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
