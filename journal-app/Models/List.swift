//
//  Section.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/27/21.
//

import Foundation
import UIKit

struct List {
    
    var title: String
    var color: UIColor
    var entries: [Entry]
    
    func getListTitle() -> String {
        return title
    }
    
    func getListColor() -> UIColor {
        return color
    }
    
    func getListEntries() -> [Entry] {
        print("All entries in list \(title)")
        
        for entry in entries {
            print(entry.text)
        }
        
        return entries
    }
    
    mutating func removeAllEntries() {
        self.entries.removeAll()
    }
    
    mutating func setListTitle(_ title: String) {
        self.title = title
    }
    
    mutating func setListColor(_ color: UIColor) {
        self.color = color
    }
    
    mutating func addEntry(_ entry: Entry) {
        self.entries.append(entry)
    }
}
