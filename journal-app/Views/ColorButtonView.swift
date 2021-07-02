//
//  ColorButtonView.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/25/21.
//

import UIKit

class ColorButtonView: UIView {
    
    var label = UILabel()
    var buttons = [ColorButton]()
    var colorChoice: UIColor?
    private let colors: [UIColor] = [ThemeColor.today1, ThemeColor.color1, ThemeColor.color2, ThemeColor.color3]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
        setupButtonsArray()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLabel() {
        label.text = ""
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 17, weight: .light)
        
        self.addSubview(label)
        
        // Set Constraints
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }
    
    func setupButtonsArray() {
        for i in 0...colors.count - 1 {
            let button = ColorButton(frame: CGRect.zero)
            
            button.setColor(colors[i])
            buttons.append(button)
            self.addSubview(button)
            // Add button action
            button.addAction(UIAction { action in
                self.colorChoice = self.colors[i]
                self.addBorderToButton(button)
                self.uncheckOtherButtons(button)
            }, for: .touchUpInside)
            
            // Set Constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            
            if i == 0 {
                NSLayoutConstraint.activate([
                    button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
                    button.leadingAnchor.constraint(equalTo: label.leadingAnchor, constant: 80),
                    button.heightAnchor.constraint(equalToConstant: 28),
                    button.widthAnchor.constraint(equalToConstant: 28)
                ])
            }
            else {
                NSLayoutConstraint.activate([
                    button.topAnchor.constraint(equalTo: buttons[i - 1].topAnchor),
                    button.leadingAnchor.constraint(equalTo: buttons[i - 1].trailingAnchor, constant: 12),
                    button.heightAnchor.constraint(equalToConstant: 28),
                    button.widthAnchor.constraint(equalToConstant: 28)
                ])
            }
        }
    }
    
    func addBorderToButton(_ button: ColorButton) {
        button.layer.borderWidth = 2
        button.layer.borderColor = ThemeColor.heading.cgColor
    }
    
    func removeBorderFromButton(_ button: ColorButton) {
        button.layer.borderWidth = 0.5
        button.layer.borderColor = ThemeColor.heading.cgColor
    }
    
    func uncheckOtherButtons(_ choiceButton: ColorButton) {
        for button in buttons {
            if button != choiceButton {
                removeBorderFromButton(button)
            }
        }
    }
    
}
