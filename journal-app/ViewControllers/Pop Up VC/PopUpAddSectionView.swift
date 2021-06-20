//
//  PopUpAddSectionView.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/17/21.
//

import UIKit

class PopUpAddSectionView: UIView, UITextFieldDelegate {
    
    // Labels
    private let titleLabel = UILabel()
    private let colorLabel = UILabel()
    private let journalTitleLabel = UILabel()
    
    // Buttons
    private var buttons = [UIButton]()
    
    // Other
    private var colorChoice: UIColor?
    private let journalTitleTextField = UITextField()
    private let buttonColors = [JournalColors.robinEggBlue, JournalColors.salmonPink, JournalColors.peachPuff, JournalColors.lilac]
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAllSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Subview Setup

extension PopUpAddSectionView {
    
    private func setupView() {
        
        self.backgroundColor = JournalColors.peach
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.5
        self.layer.cornerRadius = 40
    }
    
    private func setupTitleLabel() {
        
        titleLabel.text = "Add New Section"
        titleLabel.textColor = UIColor.darkGray
        titleLabel.font = UIFont.systemFont(ofSize: 25, weight: .light)
        
        self.addSubview(titleLabel)
        
        // Set Constraints
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    private func setupJournalTitleLabel() {
        
        configureLabel(label: journalTitleLabel, text: "Section Name:")
        
        // Set Constraints
        journalTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            journalTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            journalTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        ])
    }
    
    private func setupJournalTitleTextField() {
        
        journalTitleTextField.delegate = self
        journalTitleTextField.backgroundColor = .clear
        journalTitleTextField.borderStyle = .roundedRect
        journalTitleTextField.attributedPlaceholder = NSAttributedString(string: "Enter title here..")
        
        self.addSubview(journalTitleTextField)
        
        // Set Constraints
        journalTitleTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            journalTitleTextField.topAnchor.constraint(equalTo: journalTitleLabel.topAnchor),
            journalTitleTextField.leadingAnchor.constraint(equalTo: journalTitleLabel.trailingAnchor, constant: 5),
            journalTitleTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)
        ])
    }
    
    private func setupColorLabel() {
        
        configureLabel(label: colorLabel, text: "Section Color:")
        
        // Set Constraints
        colorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            colorLabel.topAnchor.constraint(equalTo: journalTitleLabel.bottomAnchor, constant: 70),
            colorLabel.leadingAnchor.constraint(equalTo: journalTitleLabel.leadingAnchor)
        ])
    }
    
    // Sets up all the cholor choice buttons
    private func setupColorButtons() {
        
        for i in 0...buttonColors.count - 1 {
            let button = UIButton()
            
            configureColorButton(button: button)
            buttons.append(button)
            
            button.backgroundColor = buttonColors[i]
            
            // Add button action
            button.addAction(UIAction { action in
                
                self.colorChoice = self.buttonColors[i]
                
            }, for: .touchUpInside)
            
            // Set constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            
            // Only the first button will be constrained to the colorLabel, every other button will be constrained to the previous button in the buttons array
            if i == 0 {
                NSLayoutConstraint.activate([
                    button.topAnchor.constraint(equalTo: colorLabel.topAnchor),
                    button.leadingAnchor.constraint(equalTo: colorLabel.trailingAnchor, constant: 15)
                ])
            }
            else {
                NSLayoutConstraint.activate([
                    button.topAnchor.constraint(equalTo: colorLabel.topAnchor),
                    button.leadingAnchor.constraint(equalTo: buttons[i - 1].trailingAnchor, constant: 12)
                ])
            }
        }
    }
}


// MARK: Helper Functions

extension PopUpAddSectionView {
    
    // Add all the subviews to the main view
    private func setupAllSubviews() {
        setupView()
        setupTitleLabel()
        setupJournalTitleLabel()
        setupJournalTitleTextField()
        setupColorLabel()
        setupColorButtons()
        
    }
    
    // Configures the style aspects of a label
    private func configureLabel(label: UILabel, text: String) {
        
        label.text = text
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 17, weight: .light)
        
        self.addSubview(label)
    }
    
    // Configures the style aspects of a color choice button
    private func configureColorButton(button: UIButton) {
        
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.layer.cornerRadius = button.frame.size.width * 0.5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.clipsToBounds = true
        
        self.addSubview(button)
    }
    
    // Returns the text from the title textField, or an empty string if text is nil.
    func getName() -> String {
        
        return journalTitleTextField.text?.description ?? ""
    }
    
    // Returns the color chosen by the user
    func getColorChoice() -> UIColor {
        
        return colorChoice ?? JournalColors.robinEggBlue
    }
}


// MARK: TextField
extension PopUpAddSectionView {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    // Only allow textfield to accept 30 characters or less
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // get the current text, or use an empty string if that failed
        let currentText = textField.text ?? ""

        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }

        // add their new text to the existing text
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        // make sure the result is under 30 characters
        return updatedText.count <= 30
    }
}
