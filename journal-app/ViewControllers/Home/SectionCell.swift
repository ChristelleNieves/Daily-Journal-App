//
//  SectionCell.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/16/21.
//

import UIKit

class SectionCell: UITableViewCell {
    
    private var entryViews = [EntryView]()
    typealias ActionHandler = (Action) -> ()
    private var actionHandler: ActionHandler?
    private var numberOfEntries = 3
    private let addEntryButton = UIButton()
    private let editSectionButton = UIButton()
    var stackView = UIStackView()
    
    lazy var title: UILabel = {
        let title = UILabel()
        
        title.font = UIFont.systemFont(ofSize: 25)
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
    func setupAllSubviews() {
        setupContentView()
        setupTitleLabel()
        setupAddEntryButton()
        setupEditSectionButton()
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
        
        contentView.layer.cornerRadius = 40
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
        let config = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 30, weight: .light), scale: .small)
        
        addEntryButton.setImage(UIImage(systemName: "plus", withConfiguration: config), for: .normal)
        addEntryButton.tintColor = ThemeColor.overlay
        
        contentView.addSubview(addEntryButton)
        
        // Add button action
        addEntryButton.addAction(UIAction { action in
            
            self.createAndAddEntryView()
            self.didAddEntry()
            
        }, for: .touchUpInside)
        
        // Set constraints
        addEntryButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addEntryButton.topAnchor.constraint(equalTo: title.topAnchor),
            addEntryButton.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 5),
            addEntryButton.bottomAnchor.constraint(equalTo: title.bottomAnchor),
            addEntryButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupEditSectionButton() {
        let config = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 30, weight: .light), scale: .small)
        
        editSectionButton.setImage(UIImage(systemName: "line.horizontal.3", withConfiguration: config), for: .normal)
        editSectionButton.tintColor = ThemeColor.overlay
        
        contentView.addSubview(editSectionButton)
        
        // Add button action
        editSectionButton.addAction(UIAction { action in
            
            // TODO: Present edit section pop-up
            let vc = PopUpViewController()
            vc.mode = .editSection
            
            vc.sectionName = self.title.text ?? ""
            vc.modalPresentationStyle = .overCurrentContext
            
            
            vc.setActionHandler { action in
                
                self.didDeleteSection()
            }
            
            DispatchQueue.main.async {
                self.window?.rootViewController?.present(vc, animated: true, completion: nil)
            }
            
        }, for: .touchUpInside)
        
        // Set constraints
        editSectionButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            editSectionButton.topAnchor.constraint(equalTo: title.topAnchor),
            editSectionButton.leadingAnchor.constraint(equalTo: addEntryButton.trailingAnchor, constant: 8),
            editSectionButton.bottomAnchor.constraint(equalTo: title.bottomAnchor),
            editSectionButton.widthAnchor.constraint(equalToConstant: 30)
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
            stackView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30)
        ])
        
        // Add the starter number of entryViews to the stackView
        addStackViewSubViews()
    }
    
    // Add a pre-defined number of entryViews to the stackView
    func addStackViewSubViews() {
        
        for _ in 1...numberOfEntries {
            createAndAddEntryView()
            didAddEntry()
        }
    }

    // Create a new EntryView and add it to the StackView
    private func createAndAddEntryView() {
        let entryView = EntryView()
        
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
        case deleteSection
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
    
    private func didDeleteSection() {
        for view in stackView.subviews {
            view.removeFromSuperview()
        }
        
        self.actionHandler?(.deleteSection)
    }
}
