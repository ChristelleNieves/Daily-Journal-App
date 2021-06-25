//
//  ColorButton.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/25/21.
//

import UIKit

class ColorButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        self.backgroundColor = UIColor.clear
        self.layer.cornerRadius = 14
        self.layer.borderWidth = 0.5
        self.layer.borderColor = ThemeColor.heading.cgColor
        self.clipsToBounds = true
    }
    
    func setColor(_ color: UIColor) {
        self.backgroundColor = color
    }
}
