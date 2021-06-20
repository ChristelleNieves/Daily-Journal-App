//
//  SectionCell.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/16/21.
//

import UIKit

class SectionCell: UITableViewCell {
    
    typealias ActionHandler = (Action) -> ()
    private var actionHandler: ActionHandler?
    private var numberOfEntries = 3
    private let addEntryButton = UIButton()
    private let stackView = UIStackView()
    
    lazy var title: UILabel = {
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 25, weight: .light)
        title.textColor = .white
        return title
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupAllSubviews()
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
}

// MARK: Setup
extension SectionCell {
    
    // Configure all the views in this cell
    private func setupAllSubviews() {
        setupContentView()
        setupTitleLabel()
        setupAddEntryButton()
        setupStackView()
    }
    
    // Configure the contentView of the cell
    private func setupContentView() {
        
        let background = UIView()
        
        background.backgroundColor = ThemeColors.peach
        backgroundView = background
        
        contentView.layer.cornerRadius = 40
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(title)
        
        // Set constraints
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 17),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            title.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    // Configure the addEntry button
    private func setupAddEntryButton() {
        let config = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 30, weight: .light), scale: .small)
        
        addEntryButton.setImage(UIImage(systemName: "plus", withConfiguration: config), for: .normal)
        addEntryButton.tintColor = UIColor.white
        
        contentView.addSubview(addEntryButton)
        
        // Add button action
        addEntryButton.addAction(UIAction { action in
            
            self.didAddSection()
            
        }, for: .touchUpInside)
        
        // Set constraints
        addEntryButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addEntryButton.topAnchor.constraint(equalTo: title.topAnchor),
            addEntryButton.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 15),
            addEntryButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            addEntryButton.bottomAnchor.constraint(equalTo: title.bottomAnchor)
        ])
    }
    
    private func setupStackView() {
        contentView.addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        // Constraints
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            stackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -20)
        ])
        
        // Add the starter entryViews to the stackView
        addStackViewSubViews()
    }
    
    // Add a defined number of entryViews to the stackView
    func addStackViewSubViews() {
        
        for _ in 1...numberOfEntries {
            let entry = entryView()
            stackView.addArrangedSubview(entry)
        }
    }
}

// MARK: Action Handlers
extension SectionCell {
    
    enum Action {
        case addSection
    }
    
    func setActionHandler(_ handler: @escaping ActionHandler) {
        self.actionHandler = handler
    }
    
    // Add one entryView to the stackView
    private func didAddSection() {
        let entry = entryView()
        
        stackView.addArrangedSubview(entry)
        self.actionHandler?(.addSection)
    }
}
