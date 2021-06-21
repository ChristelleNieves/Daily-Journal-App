//
//  EditSectionViewController.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/20/21.
//

import UIKit

class EditSectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    // Setup the main view
    private func setupView() {
        
        view.backgroundColor = .clear
        
        // Set up the blur effect
        let blurEffect = UIBlurEffect(style: .systemThickMaterial)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = self.view.frame
        blurEffectView.alpha = 0.80
        
        self.view.insertSubview(blurEffectView, at: 0)
    }

}
