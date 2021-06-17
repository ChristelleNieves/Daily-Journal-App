//
//  ViewController.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/16/21.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let date = Date()
    private let headerView = TableHeader(frame: CGRect.zero)
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    private let colors = [JournalColors.blue, JournalColors.green, JournalColors.lavender, JournalColors.peach, JournalColors.pink]
    private let titles = ["To Do List", "Goals", "Affirmations", "Ideas", "Notes"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupRefreshControl()
        setupMainView()
        setupHeaderView()
        setupTableView()
    }
}

// MARK: UI Setup
extension HomeViewController {
    func setupMainView() {
        overrideUserInterfaceStyle = .light
        view.backgroundColor = UIColor.white
    }
    
    func setupHeaderView() {
        headerView.dayLabel.text = getTodayWeekDay()
        headerView.dateLabel.text = formatDate()
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
    
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        return dateFormatter.string(from: date)
    }
    
    func getTodayWeekDay()-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let weekDay = dateFormatter.string(from: Date())
        return weekDay
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
        tableView.separatorColor = .white
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
}

// MARK: TableView
extension HomeViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JournalCell", for: indexPath) as! JournalCell
        cell.journal.title.text = titles[indexPath.row]
        cell.journal.backgroundColor = colors[indexPath.row]
        
        return cell
    }
}
