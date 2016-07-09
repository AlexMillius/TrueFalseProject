//
//  QuestionsDataSource.swift
//  TrueFalse
//
//  Created by Mohamed Lee on 09.07.16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation

//Trivia questions
let question1 = Question(text: "Only female koalas can whistle", answer: false)
let question2 = Question(text: "Blue whales are technically whales", answer: true)
let question3 = Question(text: "Camels are cannibalistic", answer: false)
let question4 = Question(text: "All ducks are birds", answer: true)


struct Questions{
    let trivia: [Question] = [question1, question2, question3, question4]
}