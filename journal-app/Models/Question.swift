//
//  Question.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/30/21.
//

import Foundation

struct Question {
    
    var question: String
    var answer: String?
    
    func getQuestion() -> String {
        return self.question
    }
    
    func getAnswer() -> String {
        return self.answer ?? ""
    }
    
    mutating func setAnswer(_ newAnswer: String) {
        self.answer = newAnswer
    }
    
    mutating func setQuestion(_ newQuestion: String) {
        self.question = newQuestion
    }
}
