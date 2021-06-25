//
//  PopUpEditSectionViewController.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/20/21.
//

import UIKit

class PopUpEditSectionViewController: UIViewController {

    var colorChoice: UIColor?
    lazy var sectionName = ""
    private let okButton = UIButton()
    private let popUpView = PopUpEditSectionView(frame: CGRect.zero)
    private let titleLabel = UILabel()
    private let deleteLabel = UILabel()
    private let yesButton = UIButton()
    private let changeTitleLabel = UILabel()
    private let changeTitleTextField = UITextField()
    private let changeColorLabel = UILabel()
    private var deleteSection: Bool = false
    
    typealias ActionHandler = (Action) -> ()
    private var actionHandler: ActionHandler?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupPopUpEditSectionView()
        setupOkButton()
        setupTitleLabel()
        setupDeleteLabel()
        setupYesButton()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
}

extension PopUpEditSectionViewController {
    
    // Setup the main view
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
    
    // Set up the pop-up view
    private func setupPopUpEditSectionView() {
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
    
    private func setupTitleLabel() {
        configureLabel(label: titleLabel, text: "Edit Section")
        
        // Constraints
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: popUpView.topAnchor, constant: 5),
            titleLabel.centerXAnchor.constraint(equalTo: popUpView.centerXAnchor)
        ])
    }
    
    private func setupDeleteLabel() {
        configureLabel(label: deleteLabel, text: "Delete this section?")
        
        // Constraints
        deleteLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            deleteLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            deleteLabel.leadingAnchor.constraint(equalTo: popUpView.leadingAnchor, constant: 10),
        ])
    }
    
    private func setupYesButton() {
        yesButton.layer.cornerRadius = 14
        yesButton.layer.borderWidth = 0.5
        yesButton.layer.borderColor = ThemeColor.subheading.cgColor
        yesButton.backgroundColor = .clear
        yesButton.setTitleColor(ThemeColor.heading, for: .normal)
        popUpView.addSubview(yesButton)
        
        // Add action
        yesButton.addAction(UIAction { action in
            if !self.deleteSection {
                self.deleteSection = true
                self.yesButton.setTitle("X", for: .normal)
            }
            else {
                self.deleteSection = false
                self.yesButton.setTitle("", for: .normal)
            }
        }, for: .touchUpInside)
        
        // Constraints
        yesButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            yesButton.topAnchor.constraint(equalTo: deleteLabel.topAnchor),
            yesButton.leadingAnchor.constraint(equalTo: deleteLabel.trailingAnchor, constant: 50),
            yesButton.heightAnchor.constraint(equalToConstant: 28),
            yesButton.widthAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    /*
    private func setupChangeColorLabel() {
        configureLabel(label: changeColorLabel, text: "Change section color:")
        
        // Constraints
        changeColorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            changeColorLabel.topAnchor.constraint(equalTo: deleteLabel.bottomAnchor, constant: 50),
            changeColorLabel.leadingAnchor.constraint(equalTo: deleteLabel.leadingAnchor)
        ])
    }
 */
    
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
            
            if self.deleteSection {
                self.willDismissPopup()
            }
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

// MARK: Helper Functions
extension PopUpEditSectionViewController {
    private func configureLabel(label: UILabel, text: String) {
        label.text = text
        label.textColor = ThemeColor.heading
        label.font = UIFont.systemFont(ofSize: 17, weight: .light)
        popUpView.addSubview(label)
    }
}

// MARK: Actions
extension PopUpEditSectionViewController {
    
    enum Action {
        case dismiss(Bool)
    }
    
    func setActionHandler(_ handler: @escaping ActionHandler) {
        self.actionHandler = handler
    }
    
    func willDismissPopup() {
        self.actionHandler?(.dismiss(deleteSection))
    }
}
