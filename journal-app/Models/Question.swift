//
//  Question.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/30/21.
//

import Foundation

let dailyQuestions = [Question(question: "What are 3 things you are thankful for today?"),
                              Question(question: "How do you plan on working towards your goals today?"),
                              Question(question: "What will you do today to care for your mental health?"),
                              Question(question: "Describe the reason for your current mood in one sentence")]

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
