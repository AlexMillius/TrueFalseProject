//
//  QuestionModel.swift
//  TrueFalse
//
//  Created by Mohamed Lee on 09.07.16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation

enum trueFalse:String {
    case True
    case False
}

class Question {
    let text: String
    let answer: Bool
    init(text:String, answer:Bool){
        self.text = text
        self.answer = answer
    }
}


