//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//
//  Edited by Alex Millius

import UIKit
import AudioToolbox

class ViewController: UIViewController {
    
    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    var randomIndexUsed = [Int]()
    var timer = 0
    var clock = NSTimer()
    var lightningMode = false
    
    var startSound: SystemSoundID = 0
    var nextSound: SystemSoundID = 0
    var timesUpSound: SystemSoundID = 0
    var rightSound: SystemSoundID = 0
    var wrongSound: SystemSoundID = 0
    var endSound: SystemSoundID = 0
    
    let questions = Questions().questions
    var currentQuestion = Question()
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var centerInfoLabel: UILabel!
    
    @IBOutlet weak var lightningSwitch: UISwitch!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var response1: UIButton!
    @IBOutlet weak var response2: UIButton!
    @IBOutlet weak var response3: UIButton!
    @IBOutlet weak var response4: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        laodAllSounds()
        playSound(startSound)
        makeTheResponseBtnRound(10)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func lightningSwitchToggled(sender: UISwitch) {
        if sender.on {
            lightningMode = true
        }else {
            lightningMode = false
        }
    }
    
    //MARK: display question
    func displayQuestion() {
        playSound(nextSound)
        enableResponse(true)
        initAnswerColor()

        // Increment the questions asked counter
        questionsAsked += 1
        
        //Get a random question
        let questionWithInfo = getRandomQuestion(randomIndexUsed, questions: questions)
        randomIndexUsed.append(questionWithInfo.randomIndex)
        currentQuestion = questionWithInfo.question
        
        // affect the label and the button with the question and responses
        questionField.text = currentQuestion.text
        response1.setTitle(currentQuestion.answer1, forState: .Normal)
        response2.setTitle(currentQuestion.answer2, forState: .Normal)
        response3.setTitle(currentQuestion.answer3, forState: .Normal)
        response4.setTitle(currentQuestion.answer4, forState: .Normal)
        
        //Prepare the nextButton title
        if questionsAsked == questionsPerRound {
            nextButton.setTitle(NextTitle.result.txt(), forState: .Normal)
        } else {
            nextButton.setTitle(NextTitle.nextQuestion.txt(), forState: .Normal)
        }
        
        //Show and Hide the required elements
        hideResponses(false)
        resultLabel.hidden = true
        nextButton.hidden = true
        
        if lightningMode {
            lightningCountdown(seconds: 15)
        }
    }
    
    //MARK: check answer
    @IBAction func checkAnswer(sender: UIButton) {
        //The player as repsonded in time
        clock.invalidate()
        
        //extrat the correct answer
        let correctAnswer = currentQuestion.correctAswr
        
        //enable the responses
        enableResponse(false)
        sender.enabled = true
        
        resultLabel.hidden = false
        
        //Check if the response is correct
        if (sender.tag == correctAnswer) {
            playSound(rightSound)
            correctQuestions += 1
            resultLabel.textColor = UIColor.greenColor()
            resultLabel.text = "Correct!"
        } else {
            playSound(wrongSound)
            resultLabel.textColor = UIColor.orangeColor()
            resultLabel.text = "Sorry, wrong answer!"
            //change the color of the text in green for the right answer and red for the selected answer
            colorAnswerButton(correctAnswer, color: UIColor.greenColor())
            colorAnswerButton(sender.tag, color: UIColor.redColor())
        }
        
        //Show the next button
        nextButton.hidden = false
    }
    
    func displayScore() {
        //Show and Hide the required elements
        hideResponses(true)
        clearResponseTitle()
        resultLabel.hidden = true
        centerInfoLabel.text = CenterTxt.lightningInfo.txt()
        hideLightningSelect(false)
        
        // Display play again button by reusing the nextButton
        nextButton.setTitle(NextTitle.playAgain.txt(), forState: .Normal)
        nextButton.hidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
    }
    
    // The next button is use for the next question AND for playing again
    @IBAction func next() {
        if questionsAsked == questionsPerRound {
            // Game is over
            playSound(endSound)
            displayScore()
            questionsAsked = 0
            correctQuestions = 0
            randomIndexUsed = []
        } else {
            // Start Game or Continue game
            displayQuestion()
            hideLightningSelect(true)
        }
    }
    

    
    // MARK: Time Helper Methods
    
    func lightningCountdown(seconds seconds: Int) {
        timer = seconds
        clock = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
        print("init timer")
        
    }
    
    func updateTimer(){
        print("timer decrease \(timer)")
        timer -= 1
        if timer == 0{
            clock.invalidate()
            self.clearResponseTitle()
            self.nextButton.hidden = false
            self.hideResponses(true)
            self.playSound(self.timesUpSound)
            self.centerInfoLabel.text = CenterTxt.oops.txt()
            self.centerInfoLabel.hidden = false
        }
    }

    
    // MARK: Sound Helper Methods
    
    enum Sounds:String{
        case startSound
        case nextSound
        case timesUpSound
        case rightSound
        case wrongSound
        case endSound
    }
    
    func laodAllSounds(){
        let wav = "wav"
        startSound = loadSound(startSound, pathName: Sounds.startSound.rawValue, type: wav)
        rightSound = loadSound(rightSound, pathName: Sounds.rightSound.rawValue, type: wav)
        wrongSound = loadSound(wrongSound, pathName: Sounds.wrongSound.rawValue, type: wav)
        nextSound = loadSound(nextSound, pathName: Sounds.nextSound.rawValue, type: wav)
        timesUpSound = loadSound(timesUpSound, pathName: Sounds.timesUpSound.rawValue, type: wav)
        endSound = loadSound(endSound, pathName: Sounds.endSound.rawValue, type: wav)
    }
    
    func loadSound(systSoundId:SystemSoundID, pathName:String, type:String) -> SystemSoundID{
        var sound = SystemSoundID()
        let pathToSoundFile = NSBundle.mainBundle().pathForResource(pathName, ofType: type)
        let soundURL = NSURL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL, &sound)
        return sound
    }
    
    func playSound(soundId:SystemSoundID) {
        AudioServicesPlaySystemSound(soundId)
    }
    
    // MARK: UI Helper Methods
    
    func hideResponses(hide:Bool){
        response1.hidden = hide
        response2.hidden = hide
        response3.hidden = hide
        response4.hidden = hide
    }
    
    func enableResponse(enable:Bool){
        response1.enabled = enable
        response2.enabled = enable
        response3.enabled = enable
        response4.enabled = enable
    }
    
    func hideLightningSelect(hide:Bool){
        centerInfoLabel.hidden = hide
        lightningSwitch.hidden = hide
    }
    
    func makeTheResponseBtnRound(radius:CGFloat){
        response1.layer.cornerRadius = radius
        response2.layer.cornerRadius = radius
        response3.layer.cornerRadius = radius
        response4.layer.cornerRadius = radius
        nextButton.layer.cornerRadius = radius
    }
    
    //Prevent the last reponse to appear when the player play again
    func clearResponseTitle(){
        response1.setTitle("", forState: .Normal)
        response2.setTitle("", forState: .Normal)
        response3.setTitle("", forState: .Normal)
        response4.setTitle("", forState: .Normal)
    }
    
    func colorAnswerButton(tag:Int, color: UIColor){
        switch tag {
        case 1: response1.setTitleColor(color, forState: .Normal)
        case 2: response2.setTitleColor(color, forState: .Normal)
        case 3: response3.setTitleColor(color, forState: .Normal)
        case 4: response4.setTitleColor(color, forState: .Normal)
        default: break
        }
    }
    
    func initAnswerColor(){
        response1.setTitleColor(.None, forState: .Normal)
        response2.setTitleColor(.None, forState: .Normal)
        response3.setTitleColor(.None, forState: .Normal)
        response4.setTitleColor(.None, forState: .Normal)
    }
    
    enum CenterTxt:String {
        case oops
        case lightningInfo
        
        func txt()->String{
            switch self {
            case oops: return "Oops ! Too late."
            case .lightningInfo: return "Lightning mode (15sec/question)"
            }
        }
    }
    
    enum NextTitle:String {
        case letsGo
        case nextQuestion
        case result
        case playAgain
        
        func txt()->String{
            switch self {
            case .letsGo: return "Let's Go !"
            case .nextQuestion: return "Next Question"
            case .result: return "Result"
            case .playAgain: return "Play Again ?"
            }
        }
    }
}

