//
//  PopUpViewController.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/17/21.
//

import Foundation
import UIKit

class PopUpViewController: UIViewController {
    
    lazy var sectionName = ""
    var colorChoice: UIColor?
    private let okButton = UIButton()
    private let popUpView = PopUpAddSectionView(frame: CGRect.zero)
    typealias ActionHandler = (Action) -> ()
    private var actionHandler: ActionHandler?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupPopUpView()
        setupOkButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        willDismissPopup()
    }
}

extension PopUpViewController {
    
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
    
    // Set up the pop-up view
    private func setupPopUpView() {
        view.addSubview(popUpView)
        
        // Constraints
        popUpView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            popUpView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            popUpView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            popUpView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            popUpView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3)
        ])
    }
    
    // Set up the Ok button
    private func setupOkButton() {
        // Button appearance
        okButton.setTitle("Ok", for: .normal)
        okButton.setTitleColor(UIColor.darkGray, for: .normal)
        okButton.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .light)
        okButton.backgroundColor = UIColor.lightGray.withAlphaComponent(0.10)
        okButton.layer.cornerRadius = 20
        okButton.layer.shadowColor = UIColor.gray.cgColor
        okButton.layer.shadowRadius = 3
        okButton.layer.shadowOpacity = 0.5
        okButton.layer.borderWidth = 0.5
        okButton.layer.borderColor = UIColor.darkGray.withAlphaComponent(0.40).cgColor
        okButton.titleEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        
        view.addSubview(okButton)
        
        // Add button action
        okButton.addAction(UIAction { action in
    
            self.dismiss(animated: true, completion: nil)
            
        }, for: .touchUpInside)
        
        // Set Constraints
        okButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            okButton.topAnchor.constraint(equalTo: popUpView.bottomAnchor, constant: 20),
            okButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            okButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/5)
        ])
    }
}

// MARK: Action Handlers
extension PopUpViewController {
    enum Action {
        case dismiss
    }
    
    func setActionHandler(_ handler: @escaping ActionHandler) {
        self.actionHandler = handler
    }
    
    // Set the corresponding variables whenever the pop-up is being dismissed
    private func willDismissPopup() {
        self.sectionName = popUpView.getName()
        self.colorChoice = popUpView.getColorChoice()
        self.actionHandler?(.dismiss)
    }
}
