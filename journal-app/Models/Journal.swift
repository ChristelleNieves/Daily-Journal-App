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
    var questions = [Question]()
    var mood: Mood?
    
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
