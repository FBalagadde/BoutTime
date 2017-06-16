//
//  ViewController.swift
//  BoutTime
//
//  Created by Frederick Balagadde on 6/12/17.
//  Copyright © 2017 Frederick Balagadde. All rights reserved.
//

import UIKit

//Specify the Fact Dictionary for this Game
let factDictionary = FactSet().famousBirthdays

var factHandler = FactHandler(factDictionary: factDictionary, gameVars: VariablesConstants())
var secPerQuestion: Int = 60
var counter: Double = 0


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
    
    @IBOutlet weak var clickToCompleteButton: UIButton!
   
    var timer = Timer()
    
    var timerInterval: Double = 1.0
    //let famousBirthdays: FactSet = FactSet()
   
   
    
    
    let scoreVCID = "scoreVC"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        canvas()
    }
    
   
    
    func initializeGame()
    {
        factHandler = FactHandler(factDictionary: factDictionary, gameVars: VariablesConstants())
    }
    
    func startRound()
    {
        resetAppObjects()
        factHandler.incrementRound()
        
        let factList = factHandler.getStarterFacts()
        
        print("This is Round: \(factHandler.gameVars.numberOfRoundsSoFar)")
        
        populateLabelsWithFacts(from: factList)
        
        //Start Timer when question is displayed
        timer = Timer.scheduledTimer(timeInterval: timerInterval, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
    }
    
    func shakeToComplete()
    {
        
        clickToCompleteButton.isHidden = true
        clickToCompleteButton.isUserInteractionEnabled = false
        
        timer.invalidate() //This pauses the timer
        timerLabel.text = getTimeStringFor(seconds: Int(counter))
        
        messageLabel.text = "Tap events to learn more"
        timerLabel.isHidden = true
        
        enableAllButtons(false)
        enableAllFactButtons(true)
        
        if (checkResult()) // If result is correct
        {
            factHandler.incrementScore()
            displayRoundResult(nextRound: nextRoundSuccess, viewScore: viewScoreSuccessButton)
            
        } else // If result is wrong
        {
            displayRoundResult(nextRound: nextRoundFail, viewScore: viewScoreFailButton)
        }
    }
    
    //Timer function to end the question session when the time alotted for each question runs out
    func updateTimer()
    {
        counter -= timerInterval
        timerLabel.text = getTimeStringFor(seconds: Int(counter))
        
        if counter <= 0.0
        {
            timer.invalidate() //This pauses the timer
            timerLabel.text = getTimeStringFor(seconds: 0)
            
            //Invalidate buttons 
            //wait about 2 seconds
            
            messageLabel.text = "Tap events to learn more"
            timerLabel.isHidden = true
            
            //check if correct or wrong
            
            enableAllButtons(false)
            enableAllFactButtons(true)
            
            if (checkResult()) // If result is correct
            {
                factHandler.incrementScore()
                displayRoundResult(nextRound: nextRoundSuccess, viewScore: viewScoreSuccessButton)
                
            } else // If result is wrong
            {
                displayRoundResult(nextRound: nextRoundFail, viewScore: viewScoreFailButton)
            }
        }
    }
    
    func displayRoundResult(nextRound: UIButton, viewScore: UIButton)
    {
        if factHandler.gameVars.numberOfRoundsSoFar < factHandler.gameVars.roundsPerGame
        {
            nextRound.isUserInteractionEnabled = true
            nextRound.isHidden = false
        } else
        {
            viewScore.isUserInteractionEnabled = true
            viewScore.isHidden = false
        }
    }
    
    
    func populateLabelsWithFacts(from factList: [String])
    {
        insertFactInto(label: factLabel1, fact: factList[0])
        insertFactInto(label: factLabel2, fact: factList[1])
        insertFactInto(label: factLabel3, fact: factList[2])
        insertFactInto(label: factLabel4, fact: factList[3])
    }
    
    func canvas()
    {
        
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
    
    func getTimeStringFor(seconds: Int) -> String
    {
        let (timerMins, timerSecs) = (seconds/60, seconds%60)
        
        var timerSecString = String(timerSecs)
        
        if timerSecString.utf8.count == 1
        {
            timerSecString = "0" + timerSecString
        }
        
        return "\(timerMins):" + timerSecString
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
            
            //Need to wire these towards the end with URL connectivity
        case fact1Button: print("test")
        case fact2Button: print("test")
        case fact3Button: print("test")
        case fact4Button: print("test")
            
        case nextRoundSuccess: startRound()
      
        case nextRoundFail: startRound()
            
        case clickToCompleteButton:
            shakeToComplete()
            
        case viewScoreSuccessButton: displayScore()
            
        case viewScoreFailButton: displayScore()
        
            
        default: print("The default statement in func moveFact() has been executed. This should not be happening. Fix error!")
        }
    }
    
    
    func displayScore()
    {
        let myScoreVC = self.storyboard?.instantiateViewController(withIdentifier: scoreVCID) as! PlayAgainController
        present(myScoreVC, animated: true, completion: self.resetAppObjects)
    }
    
    func isXLessThanY(x: [String], y: [String]) -> Bool
    {
        //check if date strings formatted correctly
        //return error is not
        if Int(y[0])! > Int(x[0])! //Here we do a force unwrap because we have checked tha tthe date format is authentic
        {
            return true
        }else if Int(y[0])! < Int(x[0])! {
            return false
        }else //x[index] == y[index]
        {
            if x.count == 1 {
                return true
            } else
            {
                //remove the first element from the array
                var xReduced = x; xReduced.remove(at: 0)
                var yReduced = y; yReduced.remove(at: 0)
                return isXLessThanY(x: xReduced, y: yReduced)
            }
        }
        
    }
    
    func isXBeforeY(dateX: String, dateY: String) -> Bool
    {
        // if not correctFormatFor(dateString: dateString1), return error
        // if not correctFormatFor(dateString: dateString2), return error
        
        //first make sure that date formats are valid or throw error
        let dateXTokens = getStringTokensOf(string: dateX, delimitChar: "-")
        let dateYTokens = getStringTokensOf(string: dateY, delimitChar: "-")
        
        return isXLessThanY(x: dateXTokens, y: dateYTokens)
    }
    
    // Utility Function for tokenizing delimited strings
    func getStringTokensOf(string inputString: String, delimitChar: String) -> [String]{
        
        var tokens: [String] = []
        var tempString = ""
        
        for letter in inputString.characters {
            
            switch String(letter) {
            case String(delimitChar):
                tokens.append(tempString)
                tempString = ""
            default:
                tempString += String(letter)
            }
        }
        tokens.append(tempString)
        return tokens
    } //end func getStringTokensOf
    
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
    
    func changeDateToYYYYMMDD(fromMMDDYYY: String) -> String
    {
        var dateTokens = getStringTokensOf(string: fromMMDDYYY, delimitChar: "-")
        let month = dateTokens[0]
        let day = dateTokens[1]
        let year = dateTokens[2]
        
        return year + "-" + month + "-" + day //YYYY-MM-DD
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
    
    func areDatesInAscendingOrder(dates: [String]) -> Bool
    {
        if dates.count == 2
        {
            return isXBeforeY(dateX: dates[0], dateY: dates[1])
        } else {
            if isXBeforeY(dateX: dates[0], dateY: dates[1])
            {
                var datesReduced = dates
                datesReduced.remove(at: 0)
                return areDatesInAscendingOrder(dates: datesReduced)
                
            }else
            {
                return false
            }
        }
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
    
    ////////////////////////////////////////////////////////////
    
    
    override func viewDidAppear(_ animated: Bool) {
        print("\nviewDidAppear Executed")
        
        factHandler = FactHandler(factDictionary: factDictionary, gameVars: VariablesConstants())
        startRound()
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
        
        clickToCompleteButton.isUserInteractionEnabled = true
        clickToCompleteButton.isHidden = false
        
        timerLabel.text = getTimeStringFor(seconds: secPerQuestion)
        timerLabel.isHidden = false
        messageLabel.text = "Shake to complete"
        
        counter = Double(secPerQuestion)
    }
}

