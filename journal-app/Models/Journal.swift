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
    var lists = [List]()
    var dailyQuestions = [Question(question: "What are 3 things you are thankful for today?"),
                              Question(question: "How do you plan on working towards your goals today?"),
                              Question(question: "What will you do today to care for your mental health?"),
                              Question(question: "Describe the reason for your current mood in one sentence")]
    var mood: Mood?
    
    func isEmpty() -> Bool{
        return lists.count == 0
    }
    
    func getNumberOfLists() -> Int {
        return lists.count
    }
    
    mutating func addList(_ list: List) {
        self.lists.append(list)
    }
    
    mutating func removeList(_ index: Int) {
        self.lists.remove(at: index)
    }
}
