//
//  MoodChoicesView.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/17/21.
//

import UIKit

class MoodChoicesView: UIView {
    
    private let happyButton = UIButton()
    private let sadButton = UIButton()
    private let madButton = UIButton()
    private let neutralButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupHappyButton()
        setupSadButton()
        setupMadButton()
        setupNeutralButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MoodChoicesView {
    private func setupView() {
        self.backgroundColor = ThemeColor.background
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.5
        self.layer.cornerRadius = 40
    }
    
    private func setupHappyButton() {
        happyButton.setImage("🙂".image(), for: .normal)
        self.addSubview(happyButton)
        
        // Constraints
        happyButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            happyButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            happyButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30)
        ])
    }
    
    private func setupSadButton() {
        sadButton.setImage("😢".image(), for: .normal)
        self.addSubview(sadButton)
        
        // Constraints
        sadButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sadButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            sadButton.leadingAnchor.constraint(equalTo: happyButton.trailingAnchor, constant: 15)
        ])
    }
    
    private func setupMadButton() {
        madButton.setImage("😠".image(), for: .normal)
        self.addSubview(madButton)
        
        // Constraints
        madButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            madButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            madButton.leadingAnchor.constraint(equalTo: sadButton.trailingAnchor, constant: 15)
        ])
    }
    
    private func setupNeutralButton() {
        neutralButton.setImage("😐".image(), for: .normal)
        self.addSubview(neutralButton)
        
        // Constraints
        neutralButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            neutralButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            neutralButton.leadingAnchor.constraint(equalTo: madButton.trailingAnchor, constant: 15)
        ])
    }
}

extension String
{
    func image(fontSize:CGFloat = 50, bgColor:UIColor = UIColor.clear, imageSize:CGSize? = nil) -> UIImage? {
        let font = UIFont.systemFont(ofSize: fontSize)
        let attributes = [NSAttributedString.Key.font: font]
        let imageSize = imageSize ?? self.size(withAttributes: attributes)

        UIGraphicsBeginImageContextWithOptions(imageSize, false, 0)
        bgColor.set()
        let rect = CGRect(origin: .zero, size: imageSize)
        UIRectFill(rect)
        self.draw(in: rect, withAttributes: [.font: font])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
