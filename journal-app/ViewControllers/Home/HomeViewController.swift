//
//  ViewController.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/16/21.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var sectionname = ""
    private var colors = [UIColor]()
    private var sections = [String]()
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    private let headerView = TableHeader(frame: CGRect.zero)
    private let noSectionsView = NoSectionsView(frame: CGRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAllSubviews()
    }
}

// MARK: UI Setup
extension HomeViewController {
    
    private func setupAllSubviews() {
        setupRefreshControl()
        setupMainView()
        setupHeaderView()
        setupNoSectionsView()
        setupTableView()
    }
    
    private func setupMainView() {
        // Force light mode appearance
        overrideUserInterfaceStyle = .light
        
        view.backgroundColor = ThemeColors.peach
    }
    
    private func setupHeaderView() {
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
    
    private func setupRefreshControl() {
        refreshControl.addAction(UIAction { action in
            
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            
        }, for: .valueChanged)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.separatorColor = ThemeColors.peach
        tableView.backgroundColor = ThemeColors.peach
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = view.frame.height * 1/3
        tableView.refreshControl = refreshControl
        tableView.register(SectionCell.self, forCellReuseIdentifier: "SectionCell")
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "SectionCell", for: indexPath) as! SectionCell
        
        cell.setActionHandler { action in
            self.tableView.reloadData()
        }
        
        cell.title.text = sections[indexPath.row]
        cell.contentView.backgroundColor = colors[indexPath.row]
        
        return cell
    }
    
}

// MARK: Pop Up View Helpers

extension HomeViewController {
    
    // Display the pop up vc to add a section
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
    
    func showPopUp() {
        self.noSectionsView.isHidden = true
        goToPopupVC()
    }
}
