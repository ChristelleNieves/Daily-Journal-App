//
//  JournalView.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/16/21.
//

import UIKit

class JournalView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    private var numberOfEntries = 3
    private let addEntryButton = UIButton()
    private let tableView = UITableView()
    let stackView = UIStackView()
    
    lazy var title: UILabel = {
       let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 25, weight: .light)
        
        title.textColor = UIColor.systemGray
        return title
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupTitleLabel()
        setupAddEntryButton()
        //setupTableView()
        setupStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension JournalView {
    func setupView() {
        //self.clipsToBounds = true
        self.backgroundColor = JournalColors.green
        self.layer.cornerRadius = 40
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.5
    }
    
    func setupTitleLabel() {
        title.translatesAutoresizingMaskIntoConstraints = false
        addSubview(title)
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: self.topAnchor, constant: 17),
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 50),
        ])
    }
    
    /*
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(JournalEntryCell.self, forCellReuseIdentifier: "JournalEntryCell")
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.rowHeight = 55
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.separatorStyle = .none
        addSubview(tableView)
        
        // Constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12)
        ])
    }
 */
    
    func setupAddEntryButton() {
        let config = UIImage.SymbolConfiguration(font: UIFont.systemFont(ofSize: 30, weight: .light), scale: .small)
        addEntryButton.setImage(UIImage(systemName: "plus", withConfiguration: config), for: .normal)
        addEntryButton.tintColor = UIColor.darkGray.withAlphaComponent(0.50)
        addSubview(addEntryButton)
        
        addEntryButton.addAction(UIAction { action in
            self.numberOfEntries += 1
            //self.tableView.reloadData()
            let v = entryView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
            self.stackView.addArrangedSubview(v)
            self.heightAnchor.constraint(equalTo: self.stackView.heightAnchor).isActive = true
        }, for: .touchUpInside)
        
        addEntryButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            addEntryButton.topAnchor.constraint(equalTo: title.topAnchor),
            addEntryButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
        ])
    }
    
    func setupStackView() {
        self.addSubview(stackView)
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant:  -10)
        ])
 
        for _ in 0...numberOfEntries {
            let entry = entryView()
            stackView.addArrangedSubview(entry)
        }
    }
}

// MARK: Tableview Setup
extension JournalView {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfEntries
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JournalEntryCell", for: indexPath) as! JournalEntryCell
        
        if indexPath.row == 0 {
            cell.textField.attributedPlaceholder = NSAttributedString(string: "Write something here..")
        }
        cell.backgroundColor = .clear
        cell.layoutMargins = UIEdgeInsets.zero
        
        return cell
    }
}
