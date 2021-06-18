//
//  ViewController.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/16/21.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let popupVC = PopUpViewController()
    private let noSectionsView = NoSectionsView(frame: CGRect.zero)
    private let headerView = TableHeader(frame: CGRect.zero)
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    private let colors = [JournalColors.blue, JournalColors.green, JournalColors.lavender, JournalColors.pink]
    private let titles = ["To Do List", "Goals", "Affirmations", "Ideas"]
    private let sections = [String]()
    
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
        tableView.rowHeight = view.frame.height * 1/3
        tableView.refreshControl = refreshControl
        tableView.register(JournalCell.self, forCellReuseIdentifier: "JournalCell")
        view.addSubview(tableView)
        
        // Constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
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
        noSectionsView.isHidden = true
        popupVC.modalPresentationStyle = .overCurrentContext
        present(popupVC, animated: true, completion: nil)
    }
    
    func dismissPopUpView() {
        popupVC.dismiss(animated: true, completion: nil)
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
        cell.journal.title.text = titles[indexPath.row]
        cell.journal.backgroundColor = JournalColors.robinEggBlue
        
        return cell
    }
}
