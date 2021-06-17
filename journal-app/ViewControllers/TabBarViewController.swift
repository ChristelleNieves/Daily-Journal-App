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
    }
}

extension TabBarViewController {
    func setupTabBar() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = JournalColors.peach
        appearance.shadowColor = UIColor.darkGray
        tabBar.standardAppearance = appearance
        tabBar.tintColor = JournalColors.lavender
        
        self.setViewControllers([homeVC, moodVC, settingsVC], animated: true)
    }
    
    func setupIcons() {
        let config = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 25, weight: .ultraLight), scale: .medium)
        homeVC.tabBarItem.image = UIImage(systemName: "house", withConfiguration: config)
        moodVC.tabBarItem.image = UIImage(systemName: "face.smiling", withConfiguration: config)
        settingsVC.tabBarItem.image = UIImage(systemName: "gear", withConfiguration: config)
    }
}
