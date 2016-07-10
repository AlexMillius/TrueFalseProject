//
//  QuestionsDataSource.swift
//  TrueFalse
//
//  Created by Mohamed Lee on 09.07.16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation

//Four answers questions
let question1 = Question(text: "This was the only US President to serve more than two consecutive terms.", answer1: "George Washington", answer2: "Franklin D. Roosevelt", answer3: "Woodrow Wilson", answer4: "Andrew Jackson", correctAswr: 2)
let question2 = Question(text: "Which of the following countries has the most residents?", answer1: "Nigeria", answer2: "Russia", answer3: "Iran", answer4: "Vietnam", correctAswr: 1)
let question3 = Question(text: "In what year was the United Nations founded?", answer1: "1918", answer2: "1919", answer3: "1945", answer4: "1954", correctAswr: 3)
let question4 = Question(text: "The Titanic departed from the United Kingdom, where was it supposed to arrive?", answer1: "Paris", answer2: "Washington D.C.", answer3: "New York City", answer4: "Boston", correctAswr: 3)
let question5 = Question(text: "Which nation produces the most oil?", answer1: "Iran", answer2: "Iraq", answer3: "Brazil", answer4: "Canada", correctAswr: 4)
let question6 = Question(text: "Which country has most recently won consecutive World Cups in Soccer?", answer1: "Italy", answer2: "Brazil", answer3: "Argetina", answer4: "Spain", correctAswr: 2)
let question7 = Question(text: "Which of the following rivers is longest?", answer1: "Yangtze", answer2: "Mississippi", answer3: "Cango", answer4: "Mekong", correctAswr: 2)
let question8 = Question(text: "Which city is the oldest?", answer1: "Mexico City", answer2: "Cape Town", answer3: "San Juan", answer4: "Sydney", correctAswr: 1)
let question9 = Question(text: "Which country was the first to allow women to vote in national elections?", answer1: "Poland", answer2: "United States", answer3: "Sweden", answer4: "Senegal", correctAswr: 1)
let question10 = Question(text: "Which of these countries won the most medals in the 2012 Summer Games?", answer1: "France", answer2: "Germany", answer3: "Japan", answer4: "Great Britain", correctAswr: 4)


struct Questions{
    let questions: [Question] = [question1, question2, question3, question4, question5, question6, question7, question8, question9, question10]
}

enum Sounds:String{
    case goSound
    case nextSound
    case rightSound
    case wrongSound
    case endSound
}