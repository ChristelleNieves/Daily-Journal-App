//
//  MoodViewController.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/30/21.
//

import UIKit

class MoodViewController: UIViewController {
    
    private let moodImages = [UIImage(named: "happy"), UIImage(named: "mad"), UIImage(named: "sad"), UIImage(named: "neutral")]
    private var moodButtons = [UIButton]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainView()
        setupMoodButtons()
    }
}

extension MoodViewController {
    private func setupMainView() {
        view.backgroundColor = .clear
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 5
    }
    
    private func setupMoodButtons() {
        for i in 0..<moodImages.count {
            let button = UIButton()
            button.setImage(moodImages[i]?.withTintColor(ThemeColor.color1.withAlphaComponent(0.50)), for: .normal)
            button.imageView?.contentMode = .scaleAspectFit
            moodButtons.append(button)
            view.addSubview(button)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            
            if i == 0 {
                NSLayoutConstraint.activate([
                    button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                    button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
                    button.widthAnchor.constraint(equalToConstant: 60),
                    button.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2)
                ])
            }
            else {
                NSLayoutConstraint.activate([
                    button.topAnchor.constraint(equalTo: moodButtons[0].topAnchor),
                    button.leadingAnchor.constraint(equalTo: moodButtons[i - 1].trailingAnchor, constant: 20),
                    button.widthAnchor.constraint(equalToConstant: 60),
                    button.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2)
                ])
            }
        }
    }
}
