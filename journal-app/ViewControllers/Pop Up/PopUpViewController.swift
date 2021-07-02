//
//  PopUpViewController.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/17/21.
//

import Foundation
import UIKit

enum PopupMode {
    case addSection
    case editSection
}

class PopUpViewController: UIViewController {
    
    var changedColor: Bool = false
    var changedTitle: Bool = false
    var colorChoice: UIColor?
    lazy var sectionName = ""
    lazy var mode: PopupMode = .addSection
    lazy var popupView: UIView = UIView()
    private let okButton = UIButton()
    
    typealias ActionHandler = (Action) -> ()
    private var actionHandler: ActionHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupPopupView()
        setupOkButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        willDismissPopup()
    }
}

// MARK: Subview Setup

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
    
    // Set up the correct pop-up view according to the current pop-up mode
    private func setupPopupView() {
        
        switch mode {
        case .addSection:
            popupView = AddSectionView(frame: CGRect.zero)
        case .editSection:
            popupView = EditSectionView(frame: CGRect.zero)
        }
        
        view.addSubview(popupView)
        
        // Constraints
        popupView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            popupView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            popupView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            popupView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            popupView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2)
        ])
    }
    
    // Set up the Ok button
    private func setupOkButton() {
        // Button appearance
        okButton.setTitle("Ok", for: .normal)
        okButton.setTitleColor(UIColor.darkGray, for: .normal)
        okButton.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .light)
        okButton.backgroundColor = ThemeColor.background.withAlphaComponent(0.80)
        okButton.layer.cornerRadius = 20
        okButton.layer.shadowColor = UIColor.gray.cgColor
        okButton.layer.shadowRadius = 3
        okButton.layer.shadowOpacity = 0.5
        okButton.layer.borderWidth = 0.5
        okButton.layer.borderColor = UIColor.darkGray.withAlphaComponent(0.40).cgColor
        okButton.titleEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        
        popupView.addSubview(okButton)
        
        // Add button action
        okButton.addAction(UIAction { action in
            
            // Set the action according to the current mode
            switch self.mode {
            case .addSection:
                self.dismiss(animated: true, completion: nil)
            case .editSection:
                self.willDismissPopup()
                self.dismiss(animated: true, completion: nil)
            }
        }, for: .touchUpInside)
        
        // Set Constraints
        okButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            okButton.bottomAnchor.constraint(equalTo: popupView.bottomAnchor, constant: -100),
            okButton.centerXAnchor.constraint(equalTo: popupView.centerXAnchor),
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
        
        if let popup = popupView as? AddSectionView {
            self.sectionName = popup.getName()
            self.colorChoice = popup.getColorChoice()
        }
        else if let popup = popupView as? EditSectionView {
            if popup.getName() != "" {
                self.changedTitle = true
                self.sectionName = popup.getName()
            }
            if popup.colorButtonView.colorChoice != nil {
                self.changedColor = true
                self.colorChoice = popup.colorButtonView.colorChoice
            }
        }
        
        self.actionHandler?(.dismiss)
    }
}
