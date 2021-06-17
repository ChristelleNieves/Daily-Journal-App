//
//  JournalCell.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/16/21.
//

import UIKit

class JournalCell: UITableViewCell {
    
    let journal = JournalView(frame: CGRect(x: 0, y: 0, width: 200, height: 150))

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupContentView()
        setupJournal()

    }

}

extension JournalCell {
    func setupContentView() {
        contentView.backgroundColor = .white
    }
    
    func setupJournal() {
        contentView.addSubview(journal)
        
        journal.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            journal.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            journal.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            journal.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            journal.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
