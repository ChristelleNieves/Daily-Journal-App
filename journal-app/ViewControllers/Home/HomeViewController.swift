//
//  ViewController.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/16/21.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    enum TableViewMode {
        case Today
        case Todo
    }
    
    private var tableViewMode = TableViewMode.Today
    private var journal = Journal()
    private let tableView = UITableView(frame: CGRect.zero, style: .grouped)
    private let refreshControl = UIRefreshControl()
    private let headerView = HeaderViewController()
    private let noSectionsView = NoSectionsView(frame: CGRect.zero)
    private let moodVC = MoodViewController()
    private var control = UISegmentedControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAllSubviews()
        configureKeyboardNotifications()
    }
}

// MARK: View Setup

extension HomeViewController {
    
    private func setupAllSubviews() {
        setupRefreshControl()
        setupMainView()
        setupHeaderView()
        setupControl()
        setupMoodVC()
        setupTableView()
        setupNoSectionsView()
    }
    
    private func setupMainView() {
        view.backgroundColor = ThemeColor.background
    }
    
    private func setupHeaderView() {
        self.addChild(headerView)
        view.addSubview(headerView.view)
        
        // Constraints
        headerView.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerView.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            headerView.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/10.5)
        ])
    }
    
    private func setupRefreshControl() {
        refreshControl.addAction(UIAction { action in
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }, for: .valueChanged)
    }
    
    private func setupControl() {
        control = UISegmentedControl(items: ["Today", "To-do Lists", "This week"])
        control.selectedSegmentTintColor = ThemeColor.today1.withAlphaComponent(0.87)
        control.selectedSegmentIndex = 0
        view.addSubview(control)
        
        // Add action
        control.addAction(UIAction { action in
            switch (self.control.selectedSegmentIndex) {
            case 0:
                self.tableViewMode = .Today
                self.tableView.reloadData()
                break
            case 1:
                self.tableViewMode = .Todo
                self.tableView.reloadData()
                break
            case 2:
                self.tableView.isHidden = true
            default:
                break
            }
        }, for: .valueChanged)
        
        // Constraints
        control.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            control.topAnchor.constraint(equalTo: headerView.view.bottomAnchor, constant: 5),
            control.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            control.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupMoodVC() {
        addChild(moodVC)
        view.addSubview(moodVC.view)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.refreshControl = refreshControl
        tableView.separatorStyle = .none
        tableView.backgroundColor = ThemeColor.background
        tableView.showsVerticalScrollIndicator = false
        tableView.register(SectionCell.self, forCellReuseIdentifier: "SectionCell")
        tableView.register(TodayCell.self, forCellReuseIdentifier: "TodayCell")
        view.addSubview(tableView)
        
        // Constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: control.bottomAnchor, constant: 20),
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
            noSectionsView.topAnchor.constraint(equalTo: control.bottomAnchor, constant: 50),
            noSectionsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            noSectionsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            noSectionsView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3)
        ])
    }
}

// MARK: TableView Functions

extension HomeViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableViewMode == .Todo {
            // If the table view is empty, show a view that informs the user to add a section. Otheriwse, display the sections of the journal
            if journal.isEmpty() {
                // Display message
                tableView.isHidden = true
                noSectionsView.isHidden = false
                return 0
            }
            else {
                tableView.isHidden = false
                noSectionsView.isHidden = true
                return journal.getNumberOfSections()
            }
        }
        else {
            tableView.isHidden = false
            noSectionsView.isHidden = true
            return dailyQuestions.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableViewMode == .Todo {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SectionCell", for: indexPath) as! SectionCell
            
            // Reset the cell stackview if it has any entries that don't belong
            if cell.stackView.hasEntries() && journal.sections[indexPath.row].entries.isEmpty {
                cell.emptyStackview()
                cell.addStarterStackViewSubViews()
            }
            
            // Set cell title and background color
            cell.title.text = journal.sections[indexPath.row].getSectionTitle()
            cell.contentView.backgroundColor = journal.sections[indexPath.row].getSectionColor()
            
            // Handle cell actions here
            cell.setActionHandler { action in
                switch action {
                case .editEntry(let entries):
                    // Save the updated entries array to the journal
                    self.journal.sections[indexPath.row].entries = entries
                    let _ = self.journal.sections[indexPath.row].getSectionEntries()
                    break
                case .addEntry:
                    guard self.journal.sections.count > indexPath.row else { return }
                    
                    // Add an empty entry to the current journal section
                    self.journal.sections[indexPath.row].addEntry(Entry(text: ""))
                    
                    // Reload the table view
                    self.tableView.reloadData()
                    break
                }
            }
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TodayCell", for: indexPath) as! TodayCell
            
            cell.textView.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
            // Set cell title and background color
            cell.title.text = dailyQuestions[indexPath.row].getQuestion()
            cell.contentView.backgroundColor = ThemeColor.todayColors[indexPath.row]
            
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableViewMode == .Today {
            return 230
        }
        else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if tableViewMode == .Todo {
            let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
                
                let alert = UIAlertController(title: "Delete Section", message: "Are you sure you want to delete this section?", preferredStyle: .alert)
                
                let deleteAlertAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
                    self.handleSectionDeletion(indexPath: indexPath)
                })
                
                alert.addAction(deleteAlertAction)
                
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                alert.addAction(cancelAction)
                
                self.present(alert, animated: true, completion: nil)
                completionHandler(true)
            }
            
            deleteAction.image = UIImage(systemName: "trash")?.withTintColor(ThemeColor.heading, renderingMode: .alwaysOriginal)
            deleteAction.backgroundColor = ThemeColor.background
            
            let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
            return configuration
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if tableViewMode == .Todo {
            let archive = UIContextualAction(style: .normal, title: nil) { [weak self] (action, view, completionHandler) in
                
                let editView = PopUpViewController()
                editView.mode = .editSection
                
                editView.setActionHandler { action in
                    switch action {
                    case .dismiss:
                        if editView.changedColor {
                            self?.handleSectionColorChange(color: editView.colorChoice!, indexPath: indexPath)
                        }
                        
                        if editView.changedTitle {
                            self?.handleSectionTitleChange(title: editView.sectionName, indexPath: indexPath)
                        }
                    }
                }
                
                editView.modalPresentationStyle = .overCurrentContext
                self?.present(editView, animated: true, completion: nil)
                completionHandler(true)
            }
            
            archive.image = UIImage(systemName: "slider.horizontal.3")?.withTintColor(ThemeColor.heading, renderingMode: .alwaysOriginal)
            archive.backgroundColor = ThemeColor.background
            
            let configuration = UISwipeActionsConfiguration(actions: [archive])
            return configuration
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableViewMode == .Today {
            return moodVC.view
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableViewMode == .Today {
            return 100
        }
        
        return 0.1
    }
}

// MARK: Helper Functions

extension HomeViewController {
    
    @objc func tapDone(sender: Any) {
            self.view.endEditing(true)
        }
    
    // Display the pop up vc to add a section
    private func goToPopupVC(){
        let vc = PopUpViewController()
        vc.mode = .addSection
        
        vc.setActionHandler { action in
            
            if action == .dismiss {
                // Make sure the section name is not all whitespace characters
                guard !vc.sectionName.trimmingCharacters(in: .whitespaces).isEmpty else {
                    self.noSectionsView.isHidden = false
                    return
                }
                
                // Create a new section with the title and color from the popupVC, and a new entry array
                let newSection = Section(title: vc.sectionName, color: vc.colorChoice!, entries: [Entry]())
                
                // Add the newly created section to the journal
                self.journal.addSection(newSection)
                
                // Reload the table view
                self.tableView.reloadData()
                return
            }
        }
        
        // Present the pop-up vc
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }
    
    func showPopUp() {
        self.noSectionsView.isHidden = true
        goToPopupVC()
    }
    
    func handleSectionDeletion(indexPath: IndexPath) {
        // Delete entries from the journal section
        self.journal.sections[indexPath.row].removeAllEntries()
        
        // Delete the section from the journal
        self.journal.removeSection(indexPath.row)
        
        // Delete the row from the table view
        tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        tableView.reloadData()
    }
    
    func handleSectionTitleChange(title: String, indexPath: IndexPath) {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        
        self.journal.sections[indexPath.row].setSectionTitle(title)
        self.tableView.reloadData()
    }
    
    func handleSectionColorChange(color: UIColor, indexPath: IndexPath) {
        self.journal.sections[indexPath.row].setSectionColor(color)
        self.tableView.reloadData()
    }
}

// MARK: Keyboard Actions

extension HomeViewController {
    
    func configureKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // Scroll the tableView up when the keyboard is visible
    @objc func keyboardWillShow(_ notification:Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height + 40, right: 0)
        }
    }
    
    // Return the tableView to its original position when the keyboard is hidden
    @objc func keyboardWillHide(_ notification:Notification) {
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
