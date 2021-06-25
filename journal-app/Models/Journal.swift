//
//  Journal.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/20/21.
//

import Foundation
import UIKit

struct Journal {
    
    var date = Date()
    var sections = [Section]()
    
    func isEmpty() -> Bool{
        return sections.count == 0
    }
    
    func getNumberOfSections() -> Int {
        return sections.count
    }
    
    mutating func addSection(_ section: Section) {
        self.sections.append(section)
    }
    
    mutating func removeSection(_ index: Int) {
        self.sections.remove(at: index)
    }
}


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


struct Entry {
    
    var text: String
    
    func getEntryText() -> String {
        return self.text
    }
    
    mutating func setEntryText(_ text: String) {
        self.text = text
    }
}