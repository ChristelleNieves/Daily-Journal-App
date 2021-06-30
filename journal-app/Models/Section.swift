//
//  Section.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/27/21.
//

import Foundation
import UIKit

struct Section {
    
    var title: String
    var color: UIColor
    var entries: [Entry]
    
    func getSectionTitle() -> String {
        return title
    }
    
    func getSectionColor() -> UIColor {
        return color
    }
    
    func getSectionEntries() -> [Entry] {
        return entries
    }
    
    mutating func removeAllEntries() {
        self.entries.removeAll()
    }
    
    mutating func setSectionTitle(_ title: String) {
        self.title = title
    }
    
    mutating func setSectionColor(_ color: UIColor) {
        self.color = color
    }
    
    mutating func addEntry(_ entry: Entry) {
        self.entries.append(entry)
    }
}
