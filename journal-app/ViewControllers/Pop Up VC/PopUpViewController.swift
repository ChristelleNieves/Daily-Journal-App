//
//  PopUpViewController.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/17/21.
//

import Foundation
import UIKit

class PopUpViewController: UIViewController {
    
    let popUpView = PopUpAddSectionView(frame: CGRect.zero)
    let okButton = UIButton()
    var sectionName = ""
    var colorChoice: UIColor?
    
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
    private func setupView() {
        view.backgroundColor = .clear
        overrideUserInterfaceStyle = .light
        
        // Set up the blur effect
        let blurEffect = UIBlurEffect(style: .systemThickMaterial)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = self.view.frame
        blurEffectView.alpha = 0.80
        
        self.view.insertSubview(blurEffectView, at: 0)
    }
    
    private func setupPopUpView() {
        view.addSubview(popUpView)
        
        // Constraints
        popUpView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            popUpView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            popUpView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            popUpView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            popUpView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2.5)
        ])
    }
    
    private func setupOkButton() {
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
        
        okButton.addAction(UIAction { action in
            self.dismiss(animated: true, completion: nil)
        }, for: .touchUpInside)
        
        // Constraints
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
        case dismiss(String, UIColor)
    }
    
    func setActionHandler(_ handler: @escaping ActionHandler) {
        self.actionHandler = handler
    }
    
    private func willDismissPopup() {
        self.sectionName = popUpView.getName()
        self.colorChoice = popUpView.getColorChoice()
        self.actionHandler?(.dismiss(sectionName, colorChoice!))
    }
}
