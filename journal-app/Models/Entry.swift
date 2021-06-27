//
//  Entry.swift
//  journal-app
//
//  Created by Christelle Nieves on 6/27/21.
//

import Foundation
import UIKit

struct Entry {
    
    var text: String
    
    func getEntryText() -> String {
        return self.text
    }
    
    mutating func setEntryText(_ text: String) {
        self.text = text
    }
}
