//
//  TodayCell.swift
//  journal-app
//
//  Created by Christelle Nieves on 7/1/21.
//

import UIKit

class TodayCell: UITableViewCell {
    
    static var reuseIdentifier = "TodayCell"
    
    var title = UILabel()
    var textView = UITextView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContentView()
        setupTitleLabel()
        setupTextView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let bottomSpace: CGFloat = 5.0
        let topSpace: CGFloat = 10.0
        
        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: topSpace, left: 0, bottom: bottomSpace, right: 0))
    }
    
    // Configure the contentView of the cell
    private func setupContentView() {
        let background = UIView()
        
        background.backgroundColor = ThemeColor.background
        backgroundView = background
        contentView.layer.shadowColor = UIColor.lightGray.withAlphaComponent(0.70).cgColor
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.shadowRadius = 4
        contentView.layer.cornerRadius = 25
    }
    
    private func setupTitleLabel() {
        title.textColor = .white
        title.font = UIFont.systemFont(ofSize: 18, weight: .light)
        title.numberOfLines = 0
        title.lineBreakMode = .byWordWrapping
        contentView.addSubview(title)
        
        // Set constraints
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 17),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
    }
    
    private func setupTextView() {
        textView.backgroundColor = ThemeColor.overlay.withAlphaComponent(0.70)
        textView.textColor = ThemeColor.subheading
        textView.font = UIFont.systemFont(ofSize: 15, weight: .light)
        textView.layer.cornerRadius = 12
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 15, weight: .light),
            .foregroundColor: ThemeColor.subheading
        ]
        
        textView.attributedText = NSAttributedString(string: "Start typing...", attributes: attributes)
        
        contentView.addSubview(textView)
        
        // Constraints
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 17),
            textView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            textView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            textView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -17)
        ])
    }
}

extension UITextView {
    func addDoneButton(title: String, target: Any, selector: Selector) {
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))//1
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)//2
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)//3
        toolBar.setItems([flexible, barButton], animated: false)//4
        self.inputAccessoryView = toolBar//5
    }
}
