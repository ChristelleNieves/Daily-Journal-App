//
//  TabBarViewController.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/16/21.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    private let homeVC = HomeViewController()
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
        appearance.backgroundColor = .white
        appearance.selectionIndicatorTintColor = .red
        appearance.shadowColor = UIColor.darkGray
        appearance.selectionIndicatorTintColor = .black
        tabBar.standardAppearance = appearance
        
        self.setViewControllers([homeVC, settingsVC], animated: true)
    }
    
    func setupIcons() {
        let config = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 25, weight: .ultraLight), scale: .medium)
        homeVC.tabBarItem.image = UIImage(systemName: "house", withConfiguration: config)
        settingsVC.tabBarItem.image = UIImage(systemName: "gear", withConfiguration: config)
    }
}
