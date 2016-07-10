//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    
    var gameSound: SystemSoundID = 0
    
    let questions = Questions().questions
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var response1: UIButton!
    @IBOutlet weak var response2: UIButton!
    @IBOutlet weak var response3: UIButton!
    @IBOutlet weak var response4: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var resultLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadGameStartSound()
        makeTheResponseBtnRound(10)
        // Start game
        playGameStartSound()
        displayQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayQuestion() {
        //Show and Hide the required elements
        highlightButtons(false)
        hideResponses(false)
        resultLabel.hidden = true
        nextButton.hidden = true
        
        //Get a random index
        indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextIntWithUpperBound(questions.count)
        let questionDictionary = questions[indexOfSelectedQuestion]
        
        // affect the label and the button with the question and responses
        questionField.text = questionDictionary.text
        response1.setTitle(questionDictionary.answer1, forState: .Normal)
        response2.setTitle(questionDictionary.answer2, forState: .Normal)
        response3.setTitle(questionDictionary.answer3, forState: .Normal)
        response4.setTitle(questionDictionary.answer4, forState: .Normal)
    }
    
    @IBAction func checkAnswer(sender: UIButton) {
        // Increment the questions asked counter
        questionsAsked += 1
        
        //extrat the correct answer
        let selectedQuestionDict = questions[indexOfSelectedQuestion]
        let correctAnswer = selectedQuestionDict.correctAswr
        
        highlightButtons(true)
        sender.highlighted = false
        resultLabel.hidden = false
        
        //Check if the response is correct
        if (sender.tag == correctAnswer) {
            correctQuestions += 1
            resultLabel.textColor = UIColor.greenColor()
            resultLabel.text = "Correct!"
        } else {
            resultLabel.textColor = UIColor.orangeColor()
            resultLabel.text = "Sorry, wrong answer!"
        }
        
        //Show the next button
        nextButton.setTitle("Next Question", forState: .Normal)
        nextButton.hidden = false
        
        //loadNextRoundWithDelay(seconds: 2)
    }
    
    func displayScore() {
        //Show and Hide the required elements
        hideResponses(true)
        resultLabel.hidden = true
        
        // Display play again button by reusing the nextButton
        nextButton.setTitle("Play Again ?", forState: .Normal)
        nextButton.hidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        
    }
    
    // The next button is use for the next question AND for playing again
    @IBAction func next() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
            questionsAsked = 0
            correctQuestions = 0
        } else {
            // Continue game
            displayQuestion()
        }
    }
    

    
    // MARK: Helper Methods
    
    func loadNextRoundWithDelay(seconds seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = dispatch_time(DISPATCH_TIME_NOW, delay)
        
        // Executes the nextRound method at the dispatch time on the main queue
        dispatch_after(dispatchTime, dispatch_get_main_queue()) {
            //self.nextRound()
        }
    }
    
    func loadGameStartSound() {
        let pathToSoundFile = NSBundle.mainBundle().pathForResource("GameSound", ofType: "wav")
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
    func hideResponses(hide:Bool){
        response1.hidden = hide
        response2.hidden = hide
        response3.hidden = hide
        response4.hidden = hide
    }
    
    func makeTheResponseBtnRound(radius:CGFloat){
        response1.layer.cornerRadius = radius
        response2.layer.cornerRadius = radius
        response3.layer.cornerRadius = radius
        response4.layer.cornerRadius = radius
        nextButton.layer.cornerRadius = radius
    }
    
    func highlightButtons(highlight:Bool){
        response1.highlighted = highlight
        response2.highlighted = highlight
        response3.highlighted = highlight
        response4.highlighted = highlight
    }
}

