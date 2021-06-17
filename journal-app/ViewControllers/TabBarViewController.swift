//
//  TabBarViewController.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/16/21.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    private let homeVC = HomeViewController()
    private let moodVC = MoodViewController()
    private let settingsVC = SettingsViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupIcons()
        setupTabBar()
        selectedIndex = 1
    }
}

extension TabBarViewController {
    private func setupTabBar() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = JournalColors.peach
        appearance.shadowColor = UIColor.darkGray
        self.tabBar.standardAppearance = appearance
        self.tabBar.tintColor = UIColor.darkGray
        
        self.setViewControllers([moodVC, homeVC, settingsVC], animated: true)
        setupMiddleButton()
    }
    
    private func setupIcons() {
        let config = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 25, weight: .ultraLight), scale: .medium)
        
        homeVC.tabBarItem.image = UIImage(systemName: "house", withConfiguration: config)
        moodVC.tabBarItem.image = UIImage(systemName: "face.smiling", withConfiguration: config)
        settingsVC.tabBarItem.image = UIImage(systemName: "gear", withConfiguration: config)
    }
    
    private func setupMiddleButton() {
        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
        var menuButtonFrame = menuButton.frame
        
        menuButtonFrame.origin.y = view.bounds.height - menuButtonFrame.height - 40
        menuButtonFrame.origin.x = view.bounds.width/2 - menuButtonFrame.size.width/2
        menuButton.frame = menuButtonFrame
        menuButton.backgroundColor = JournalColors.teaGreen
        menuButton.setTitle("+", for: .normal)
        menuButton.setTitleColor(UIColor.darkGray.withAlphaComponent(0.70), for: .normal)
        menuButton.titleLabel?.font = UIFont.systemFont(ofSize: 35, weight: .ultraLight)
        menuButton.layer.cornerRadius = menuButtonFrame.height/2
        menuButton.tintColor = UIColor.darkGray
        view.addSubview(menuButton)
        
        menuButton.addAction(UIAction { action in
            self.selectedIndex = 1
        }, for: .touchUpInside)
        
        // Set constraints for button title label
        menuButton.titleLabel?.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            menuButton.titleLabel!.centerXAnchor.constraint(equalTo: menuButton.centerXAnchor),
            menuButton.titleLabel!.centerYAnchor.constraint(equalTo: menuButton.centerYAnchor)
        ])
        
        view.layoutIfNeeded()
    }
}
