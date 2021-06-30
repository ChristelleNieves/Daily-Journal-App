//
//  SectionCell.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/16/21.
//

import UIKit

class SectionCell: UITableViewCell {
    
    static var reuseIdentifier = "SectionCell"
    
    private var numberOfEntries = 3
    private var entryViews = [EntryView]()
    private let addEntryButton = UIButton()
    var stackView = UIStackView()
    
    typealias ActionHandler = (Action) -> ()
    private var actionHandler: ActionHandler?
    
    lazy var title: UILabel = {
        let title = UILabel()
        
        title.font = UIFont.systemFont(ofSize: 20, weight: .light)
        title.textColor = ThemeColor.heading
        
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
    func setupAllSubviews() {
        setupContentView()
        setupTitleLabel()
        setupAddEntryButton()
        setupStackView()
    }
    
    func emptyStackview() {
        for view in stackView.subviews {
            stackView.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
    
    // Configure the contentView of the cell
    private func setupContentView() {
        
        let background = UIView()
        
        background.backgroundColor = ThemeColor.background
        backgroundView = background
        contentView.layer.shadowColor = UIColor.lightGray.withAlphaComponent(0.70).cgColor
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.shadowRadius = 4
        contentView.layer.cornerRadius = 23
    }
    
    private func setupTitleLabel() {
        contentView.addSubview(title)
        
        // Set constraints
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 17),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -80),
            title.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    // Configure the addEntry button
    private func setupAddEntryButton() {
        let config = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 25, weight: .light), scale: .small)
        
        addEntryButton.setImage(UIImage(systemName: "plus", withConfiguration: config), for: .normal)
        addEntryButton.tintColor = ThemeColor.subheading
        
        contentView.addSubview(addEntryButton)
        
        // Add button action
        addEntryButton.addAction(UIAction { action in
            
            self.createAndAddEntryView("")
            self.didAddEntry()
            
        }, for: .touchUpInside)
        
        // Set constraints
        addEntryButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addEntryButton.topAnchor.constraint(equalTo: title.topAnchor),
            addEntryButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            addEntryButton.bottomAnchor.constraint(equalTo: title.bottomAnchor),
            addEntryButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setupStackView() {
        contentView.addSubview(stackView)
        
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 10
        
        // Constraints
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
        
        // Add the starter number of entryViews to the stackView
        addStarterStackViewSubViews()
    }
    
    // Add a pre-defined number of entryViews to the stackView
    func addStarterStackViewSubViews() {
        for _ in 1...numberOfEntries {
            createAndAddEntryView("")
            didAddEntry()
        }
    }
    
    // Create a new EntryView and add it to the StackView
    private func createAndAddEntryView(_ text: String) {
        let entryView = EntryView()
        
        entryView.textField.text = text
        entryViews.append(entryView)
        
        entryView.setActionHandler { action in
            
            switch action {
            case .editEntry:
                self.didEditEntry()
            }
        }
        
        stackView.addArrangedSubview(entryView)
    }
}

// MARK: Action Handlers

extension SectionCell {
    enum Action {
        case editEntry([Entry])
        case addEntry
    }
    
    func setActionHandler(_ handler: @escaping ActionHandler) {
        self.actionHandler = handler
    }
    
    // Triggered each time an entry is added to the stackView
    private func didAddEntry() {
        self.actionHandler?(.addEntry)
    }
    
    private func didEditEntry() {
        var entries = [Entry]()
        
        for view in entryViews {
            entries.append(Entry(text: view.textField.text ?? ""))
        }
        
        self.actionHandler?(.editEntry(entries))
    }
}

extension UIStackView {
    func hasEntries() -> Bool {
        for view in self.subviews {
            let textView = view as? EntryView
            if textView?.textField.text != "" {
                return true
            }
        }
        return false
    }
}
