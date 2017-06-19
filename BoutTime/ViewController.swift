//
//  ViewController.swift
//  BoutTime
//
//  Created by Frederick Balagadde on 6/12/17.
//  Copyright © 2017 Frederick Balagadde. All rights reserved.
//

import UIKit
import AudioToolbox
import GameKit

//Specify the Fact Dictionary for this Game
let factDictionary = FactSet().famousBirthdays

var factHandler = FactHandler(factDictionary: factDictionary, gameVars: VariablesConstants())
var secPerQuestion: Int = 60
var counter: Double = 0

let scoreVCID = "scoreVC"
let webVCID = "webVC"
let welcomeVCID = "welcomeVC"
let reloadVCID = "reloadVC"


enum GameStates: String
{
    case idle
    case initialization
    case timerOn
    case timerOffNextRound
    case timerOffViewScore
    case viewScore
    case webView
    case resuming
    case welcomeScreen
    case startNewGame
    case homeButtonWasPressed
    case applicationReturn
}

enum Answer: String
{
    case correct
    case wrong
    case undetermined
}

var gameState: GameStates = .initialization

class ViewController: UIViewController {

    @IBOutlet weak var factFrame1: UIView!
    @IBOutlet weak var factFrame2: UIView!
    @IBOutlet weak var factFrame3: UIView!
    @IBOutlet weak var factFrame4: UIView!
    
    @IBOutlet weak var factLabel1: UILabel!
    @IBOutlet weak var factLabel2: UILabel!
    @IBOutlet weak var factLabel3: UILabel!
    @IBOutlet weak var factLabel4: UILabel!
  
    @IBOutlet weak var button1DownSelected: UIButton!
    @IBOutlet weak var button2UpSelected: UIButton!
    @IBOutlet weak var button2DownSelected: UIButton!
    @IBOutlet weak var button3UpSelected: UIButton!
    @IBOutlet weak var button3DownSelected: UIButton!
    @IBOutlet weak var button4UpSelected: UIButton!
    
    
    @IBOutlet weak var button1Down: UIButton!
    @IBOutlet weak var button2Up: UIButton!
    @IBOutlet weak var button2Down: UIButton!
    @IBOutlet weak var button3Up: UIButton!
    @IBOutlet weak var button3Down: UIButton!
    @IBOutlet weak var button4Up: UIButton!
    
    
    @IBOutlet weak var fact1Button: UIButton!
    @IBOutlet weak var fact2Button: UIButton!
    @IBOutlet weak var fact3Button: UIButton!
    @IBOutlet weak var fact4Button: UIButton!
    
    @IBOutlet weak var nextRoundSuccess: UIButton!
    @IBOutlet weak var nextRoundFail: UIButton!
    @IBOutlet weak var viewScoreSuccessButton: UIButton!
    @IBOutlet weak var viewScoreFailButton: UIButton!
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var rulesButton: UIButton!
    @IBOutlet weak var splashImageView: UIImageView!
    
    @IBOutlet weak var scoreLabel: UILabel!
  
   
    var timer = Timer()
    
    var timerInterval: Double = 1.0
    
 
    var correctDing: SystemSoundID = 0
    var incorrectBuzz: SystemSoundID = 0
    var tempCounter: Double = 0.0
    
    var correctMark: String = "✔︎"
    var wrongMark: String = "✘"
    var emptyMark: String = "◻️"
    
    var answer: Answer = .undetermined
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadGameSounds()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("\nviewDidAppear Executed")
        

        switch gameState
        {
        case .initialization: //Beginning of game, load welcome screen
            uploadWelcomeScreen()
        case .startNewGame:
          startNewGame()
        case .viewScore:
            startNewGame()
        default:
            print("")
        }
        
        /*
        if (roundOver() || factHandler.beginningOfGame()) //!factHandler.isGameOver()
        {
            factHandler = FactHandler(factDictionary: factDictionary, gameVars: VariablesConstants())
            factHandler.setGameState(isGameOver: false)
            startRound()
            
            print("Game not over")
        }else
        {
            print("Game is over")
        }
        */
    }
    
    func startNewGame()
    {
        gameState = .startNewGame
        factHandler = FactHandler(factDictionary: factDictionary, gameVars: VariablesConstants())
        factHandler.setGameState(isGameOver: false)
        
        var scoreLabelText = ""
        for _ in 1...6
        {
            scoreLabelText += emptyMark + ""
        }
        scoreLabel.text = scoreLabelText
        scoreLabel.isHidden = false
        
        startRound()
    }
    
    func loadWelcomeScreen()
    {
        let myWelcomeVC = self.storyboard?.instantiateViewController(withIdentifier: welcomeVCID) as! WelcomeViewController
        present(myWelcomeVC, animated: false, completion: nil)
    }
    
    func roundOver() -> Bool
    {
        return nextRoundFail.isHidden && nextRoundSuccess.isHidden && viewScoreFailButton.isHidden && viewScoreSuccessButton.isHidden
    }
    
   
    
    func initializeGame()
    {
        factHandler = FactHandler(factDictionary: factDictionary, gameVars: VariablesConstants())
    }
    
    func startRound()
    {
        gameState = .timerOn
            
        resetAppObjects()
        factHandler.incrementRound()
        
        let factList = factHandler.getStarterFacts()

        
        populateLabelsWithFacts(from: factList)
        
        //Start Timer when question is displayed
        timer = Timer.scheduledTimer(timeInterval: timerInterval, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
        gameState = .timerOn
    }
    
    // Shake to Complete
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?)
    {
        if gameState == .timerOn
        {
            if event?.subtype == UIEventSubtype.motionShake
            {
                if factHandler.numberOfRoundsSoFar() == factHandler.roundsPerGame()
                {
                    gameState = .timerOffViewScore
                } else {
                    gameState = .timerOffNextRound
                }
                
                timer.invalidate() //This pauses the timer
                timerLabel.text = getTimeStringFor(seconds: Int(counter))
                
                messageLabel.text = "Tap events to learn more"
                timerLabel.isHidden = true
                
                enableAllButtons(false)
                enableAllFactButtons(true)
                
                displayRoundResult()
            }
        }
    }
    
    func updateScoreLabel(with mark: Answer)
    {
        var checkMark: String = ""
        switch mark
        {
        case .correct: checkMark = correctMark
        case .wrong: checkMark = wrongMark
        case .undetermined: checkMark = emptyMark
        }
        if let tempScoreLabelText = scoreLabel.text
        {
            scoreLabel.text = replaceStringChar(forString: tempScoreLabelText, atIndex: (factHandler.numberOfRoundsSoFar() - 1), with: checkMark)
        }else
        {
            //throw an error
        }
        
    }
    
    
    //Timer function to end the question session when the time alotted for each question runs out
    func updateTimer()
    {
        
        counter -= timerInterval
        timerLabel.text = getTimeStringFor(seconds: Int(counter))
        
        if counter <= 0.0
        {
            if factHandler.numberOfRoundsSoFar() == factHandler.roundsPerGame()
            {
                gameState = .timerOffViewScore
            } else {
                gameState = .timerOffNextRound
            }
            
            timer.invalidate() //This pauses the timer
            timerLabel.text = getTimeStringFor(seconds: 0)
            
            messageLabel.text = "Tap events to learn more"
            timerLabel.isHidden = true
            
            enableAllButtons(false)
            enableAllFactButtons(true)
            
            displayRoundResult()
        }
    }
    
    func displayRoundResult()
    {
        if(checkResult()) //result is correct
        {
            playCorrectAnswerSound()
            factHandler.incrementScore()
            updateScoreLabel(with: .correct)
            
            if factHandler.numberOfRoundsSoFar() < factHandler.roundsPerGame()
            {
                nextRoundSuccess.isUserInteractionEnabled = true
                nextRoundSuccess.isHidden = false
            } else
            {
                viewScoreSuccessButton.isUserInteractionEnabled = true
                viewScoreSuccessButton.isHidden = false
            }
        }else
        {
            playWrongAnswerSound()
            updateScoreLabel(with: .wrong)
            if factHandler.numberOfRoundsSoFar() < factHandler.roundsPerGame()
            {
                nextRoundFail.isUserInteractionEnabled = true
                nextRoundFail.isHidden = false
            } else
            {
                viewScoreFailButton.isUserInteractionEnabled = true
                viewScoreFailButton.isHidden = false
            }
        }
    }
    
    
    func populateLabelsWithFacts(from factList: [String])
    {
        insertFactInto(label: factLabel1, fact: factList[0])
        insertFactInto(label: factLabel2, fact: factList[1])
        insertFactInto(label: factLabel3, fact: factList[2])
        insertFactInto(label: factLabel4, fact: factList[3])
    }

    
    func exchangeLabelFactsFor(label1: UILabel, label2: UILabel)
    {
        let fact1 = label1.text
        label1.text = label2.text
        label2.text = fact1
    }
    
    func insertFactInto(label: UILabel, fact: String)
    {
        label.text = fact
    }
    
    @IBAction func buttonClickEvent(_ sender: UIButton)
    {
        switch sender
        {
        case button1Down, button2Up:
            enableAllButtons(false)
            exchangeLabelFactsFor(label1: factLabel1, label2: factLabel2)
            enableAllButtons(true)
            
        case button2Down, button3Up:
            enableAllButtons(false)
            exchangeLabelFactsFor(label1: factLabel2, label2: factLabel3)
            enableAllButtons(true)
            
        case button3Down, button4Up:
            enableAllButtons(false)
            exchangeLabelFactsFor(label1: factLabel3, label2: factLabel4)
            enableAllButtons(true)
            
        case fact1Button:
            displayWebForm(url: fetchUrlForFact(inLabel: factLabel1))
        case fact2Button:
            displayWebForm(url: fetchUrlForFact(inLabel: factLabel2))
        case fact3Button:
            displayWebForm(url: fetchUrlForFact(inLabel: factLabel3))
        case fact4Button:
            displayWebForm(url: fetchUrlForFact(inLabel: factLabel4))
            
        case nextRoundSuccess, nextRoundFail: startRound()

        case viewScoreSuccessButton, viewScoreFailButton: displayScore()
        case newGameButton:
            dismissWelcomeScreen()
            startNewGame()

        default: print("The default statement in func moveFact() has been executed. This should not be happening. Fix error!")
        }
    }
    
    func dismissWelcomeScreen()
    {
        splashImageView.isHidden = true
        newGameButton.isHidden = true
        rulesButton.isHidden = true
        
        newGameButton.isUserInteractionEnabled = false
        rulesButton.isUserInteractionEnabled = false
    }
    
    func uploadWelcomeScreen()
    {
        gameState = .welcomeScreen
        
        scoreLabel.isHidden = true
        splashImageView.isHidden = false
        newGameButton.isHidden = false
        rulesButton.isHidden = false
        
        newGameButton.isUserInteractionEnabled = true
        rulesButton.isUserInteractionEnabled = true
    }
    
    func fetchUrlForFact(inLabel label: UILabel) -> String
    {
        let fact: String = getFactFromLabel(label: label)
        return getURLString(forKey: fact)
    }
   
    
    func displayWebForm(url: String)
    {
        gameState = .webView
        webURLGlobal = url
        
        let myWebVC = self.storyboard?.instantiateViewController(withIdentifier: webVCID) as! WebViewController
        present(myWebVC, animated: true, completion: nil)
    }
    
    
    func displayScore()
    {
        gameState = .viewScore
        factHandler.setGameState(isGameOver: true)
        let myScoreVC = self.storyboard?.instantiateViewController(withIdentifier: scoreVCID) as! PlayAgainController
        present(myScoreVC, animated: true, completion: self.resetAppObjects)
    }
    
 
    func getURLString(forKey key: String) -> String
    {
        if let url = factHandler.factSet[key]?.factURL //factHandler.factSet.facts[key]?.factDate
        {
            //make sure URL is not an empty string or else throw error
            return url
            
        }else{
            // FIXME: send an error
            return "empty string"
        }
    }
    
    func getDateString(forKey key: String) -> String
    {
        if let date = factHandler.factSet[key]?.factDate //factHandler.factSet.facts[key]?.factDate
        {
            //print(date)
            return date
            
        }else{
            // FIXME: send an error
            return "empty string"
        }
    }
    
    
    func getDates(forKeyArray keyArray: [String]) -> [String]
    {
        var dateMMDDYYYY: String = ""
        var date: String = ""
        var dateArray: [String] = []
        
        for key in keyArray
        {
            date = getDateString(forKey: key)
            dateMMDDYYYY = changeDateToYYYYMMDD(fromMMDDYYY: date)
            dateArray.append(dateMMDDYYYY)
        }
        
        return dateArray
    }
  
    func getFactFromLabel(label: UILabel) -> String
    {
        if let fact = label.text
        {
            return fact
        }else {
            //throw error
            return ""
        }
    }
    
    /////////////////////////////////
    //get keys from labels -> [keys] : String
    
    func gameFacts() -> [String]
    {
        var gameFactKeys: [String] = []
        var fact: String = ""
        var label: UILabel
        
        for index in 1...4
        {
            switch index
            {
            case 1: label = factLabel1
            case 2: label = factLabel2
            case 3: label = factLabel3
            default: label = factLabel4
            }
            
            //put this in a try catch statement
            fact = getFactFromLabel(label: label)
            gameFactKeys.append(fact)
        }
        
        return gameFactKeys
    }
    
    func checkResult() -> Bool
    {
        let factKeys = gameFacts()
        
        let dateArray = getDates(forKeyArray: factKeys)
        return areDatesInAscendingOrder(dates: dateArray)
    }
    
    
    func enableAllButtons(_ state: Bool) {
        button1Down.isUserInteractionEnabled   = state
        button2Up.isUserInteractionEnabled     = state
        button2Down.isUserInteractionEnabled   = state
        button3Up.isUserInteractionEnabled     = state
        button3Down.isUserInteractionEnabled   = state
        button4Up.isUserInteractionEnabled     = state
    }
    
    func enableAllSelectedButtons(_ state: Bool) {
        button1DownSelected.isUserInteractionEnabled   = state
        button2UpSelected.isUserInteractionEnabled     = state
        button2DownSelected.isUserInteractionEnabled   = state
        button3UpSelected.isUserInteractionEnabled     = state
        button3DownSelected.isUserInteractionEnabled   = state
        button4UpSelected.isUserInteractionEnabled     = state
    }
    
    func enableAllFactButtons(_ state: Bool) {
        fact1Button.isUserInteractionEnabled   = state
        fact2Button.isUserInteractionEnabled   = state
        fact3Button.isUserInteractionEnabled   = state
        fact4Button.isUserInteractionEnabled   = state
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resetAppObjects()
    {
        let cornerRadius: CGFloat = 5
        factFrame1.layer.cornerRadius = cornerRadius
        factFrame2.layer.cornerRadius = cornerRadius
        factFrame3.layer.cornerRadius = cornerRadius
        factFrame4.layer.cornerRadius = cornerRadius
        
        factLabel1.text = ""
        factLabel2.text = ""
        factLabel3.text = ""
        factLabel4.text = ""
        
        enableAllFactButtons(false)
        enableAllButtons(true)
        enableAllSelectedButtons(false)
        
        button1Down.isHidden = false
        button2Up.isHidden = false
        button2Down.isHidden = false
        button3Up.isHidden = false
        button3Down.isHidden = false
        button4Up.isHidden = false
        
        nextRoundSuccess.isHidden = true
        nextRoundFail.isHidden = true
        viewScoreSuccessButton.isHidden = true
        viewScoreFailButton.isHidden = true
        
        nextRoundSuccess.isUserInteractionEnabled = false
        nextRoundFail.isUserInteractionEnabled = false
        viewScoreSuccessButton.isUserInteractionEnabled = false
        viewScoreFailButton.isUserInteractionEnabled = false
        
        timerLabel.text = getTimeStringFor(seconds: secPerQuestion)
        timerLabel.isHidden = false
        messageLabel.text = "Shake to complete"
        
        counter = Double(secPerQuestion)
    }
    
    func loadGameSounds()
    {
        loadCorrectAnswerSound()
        loadWrongAnswerSound()
    }
    
    func  loadCorrectAnswerSound()    {
        //GameStartSound
        let pathToSoundFile = Bundle.main.path(forResource: "CorrectDing", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &correctDing)
        
    } // End  func loadGameStartSound()
    
    func  loadWrongAnswerSound()   {
        //GameStartSound
        let pathToSoundFile = Bundle.main.path(forResource: "IncorrectBuzz", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &incorrectBuzz)
        
    } // End  func loadGameStartSound()
    
    func playCorrectAnswerSound() {
        AudioServicesPlaySystemSound(correctDing)
        
    } // End func playGameStartSound()
    
    func playWrongAnswerSound() {
        AudioServicesPlaySystemSound(incorrectBuzz)
        
    } // End func playGameStartSound()
}

