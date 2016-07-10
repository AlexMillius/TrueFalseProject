//
//  QuestionModel.swift
//  TrueFalse
//
//  Created by Mohamed Lee on 09.07.16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation
import GameKit

struct Question {
    let text: String
    let answer1: String
    let answer2: String
    let answer3: String
    let answer4: String
    let correctAswr: Int
//    var answers: [String] {
//        return [answer1,answer2,answer3,answer4]
//    }
}

func getRandomQuestion(lastIndex:Int, questions:[Question]) -> (question:Question,randomIndex:Int){
    
    var currentIndex = Int()
    
    //create a random index while it's the same as the last random index
    repeat {
        currentIndex = GKRandomSource.sharedRandom().nextIntWithUpperBound(questions.count)
    } while currentIndex == lastIndex
    
    return (questions[currentIndex],currentIndex)
}


