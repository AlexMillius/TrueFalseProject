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

    init (text:String = "", answer1:String = "", answer2:String = "", answer3:String = "", answer4:String = "", correctAswr:Int = 0){
        self.text = text
        self.answer1 = answer1
        self.answer2 = answer2
        self.answer3 = answer3
        self.answer4 = answer4
        self.correctAswr = correctAswr
    }
}

func getRandomQuestion(lastIndexes:[Int], questions:[Question]) -> (question:Question,randomIndex:Int){
    
    var currentIndex = Int()
    
    //While the currentIndex as already been used, generate a new random index
    repeat {
        currentIndex = GKRandomSource.sharedRandom().nextIntWithUpperBound(questions.count)
    }while lastIndexes.contains(currentIndex)
    
    return (questions[currentIndex],currentIndex)
}


