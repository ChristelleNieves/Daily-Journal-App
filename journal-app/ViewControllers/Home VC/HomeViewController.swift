//
//  ViewController.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/16/21.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var sectionname = ""
    let popupVC = PopUpViewController()
    private let noSectionsView = NoSectionsView(frame: CGRect.zero)
    private let headerView = TableHeader(frame: CGRect.zero)
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    private var sections = [String]()
    private var colors = [UIColor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshControl()
        setupMainView()
        setupHeaderView()
        setupNoSectionsView()
        setupTableView()
    }
}

// MARK: UI Setup
extension HomeViewController {
    func setupMainView() {
        overrideUserInterfaceStyle = .light
        view.backgroundColor = JournalColors.peach
    }
    
    func setupHeaderView() {
        view.addSubview(headerView)
        
        // Constraints
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            headerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/10)
        ])
    }
    
    func setupRefreshControl() {
        refreshControl.addAction(UIAction { action in
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }, for: .valueChanged)
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.separatorColor = JournalColors.peach
        tableView.backgroundColor = JournalColors.peach
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = view.frame.height * 1/3
        tableView.refreshControl = refreshControl
        tableView.register(JournalCell.self, forCellReuseIdentifier: "JournalCell")
        view.addSubview(tableView)
        
        // Constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 13),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -13),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupNoSectionsView() {
        view.addSubview(noSectionsView)
        
        // Constraints
        noSectionsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            noSectionsView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noSectionsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            noSectionsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            noSectionsView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3)
        ])
    }
    
    func showPopUp() {
        self.noSectionsView.isHidden = true
        goToPopupVC()
    }
}

// MARK: TableView

extension HomeViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if sections.count == 0 {
            // Display message
            tableView.isHidden = true
            noSectionsView.isHidden = false
            return 0
        }
        else {
            tableView.isHidden = false
            noSectionsView.isHidden = true
            return sections.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JournalCell", for: indexPath) as! JournalCell
        
        cell.setActionHandler { action in
            self.tableView.reloadData()
        }
        
        cell.title.text = sections[indexPath.row]
        cell.contentView.backgroundColor = colors[indexPath.row]
        
        return cell
    }
    
}

// MARK: Pop Up View Action Handlers

extension HomeViewController {
    private func goToPopupVC() {
        let vc = PopUpViewController()
        
        vc.setActionHandler { action in
            guard !vc.sectionName.trimmingCharacters(in: .whitespaces).isEmpty else {
                self.noSectionsView.isHidden = false
                self.tableView.reloadData()
                return
            }
            
            self.addNewSection(name: vc.sectionName, color: vc.colorChoice!)
            self.tableView.reloadData()
        }
        
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
    private func addNewSection(name: String, color: UIColor) {
        sections.append(name)
        colors.append(color)
    }
}
