//
//  ViewController.swift
//  BoutTime
//
//  Created by Frederick Balagadde on 6/12/17.
//  Copyright © 2017 Frederick Balagadde. All rights reserved.
//

import UIKit

var factHandler: FactHandler = FactHandler(factSet: FactSet())
var secPerQuestion: Int = 5
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
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
   
    var timer = Timer()
    
    var timerInterval: Double = 1.0
    //let famousBirthdays: FactSet = FactSet()
   
   
    
    
    let scoreVCID = "scoreVC"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        canvas()
        //initializeGame()
        //factHandler = FactHandler(factSet: FactSet())
        //startRound()
    }
    
   
    
    func initializeGame()
    {
        factHandler = FactHandler(factSet: FactSet())
    }
    
    func startRound()
    {
        resetAppObjects()
        factHandler.incrementRound()
        
        let factList = factHandler.getStarterFacts()
        //for fact in factList
        //{
        //    print(fact)
        //}
        
        print("This is Round: \(factHandler.numberOfRoundsSoFar)")
        
        populateLabelsWithFacts(from: factList)
        
        //Start Timer when question is displayed
        timer = Timer.scheduledTimer(timeInterval: timerInterval, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
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
            
            if factHandler.numberOfRoundsSoFar < factHandler.roundsPerGame
            {
                nextRoundSuccess.isUserInteractionEnabled = true
                nextRoundSuccess.isHidden = false
                
            } else
            {
                viewScoreSuccessButton.isUserInteractionEnabled = true
                viewScoreSuccessButton.isHidden = false
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
        case nextRoundSuccess:
            factHandler.incrementScore()
            if factHandler.numberOfRoundsSoFar < factHandler.roundsPerGame
            {
                startRound()
            }else
            {
                
                displayScore()
            }
        case viewScoreSuccessButton: displayScore()
        case nextRoundFail: print("test")
            
        default: print("The default statement in func moveFact() has been executed. This should not be happening. Fix error!")
        }
    }
    
    func displayScore()
    {
        let myScoreVC = self.storyboard?.instantiateViewController(withIdentifier: scoreVCID) as! PlayAgainController
        //myScoreVC.finalScoreLabel.text = "6/6"
        
        //print(myScoreVC.finalScoreLabel.text!)
        present(myScoreVC, animated: true, completion: self.resetAppObjects)
        //present(<#T##viewControllerToPresent: UIViewController##UIViewController#>, animated: <#T##Bool#>, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
        
        //startRound()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        print("\nviewDidAppear Executed")
        factHandler = FactHandler(factSet: FactSet())
        startRound()
    }
    
    func enableAllButtons(_ state: Bool)
    {
        button1Down.isUserInteractionEnabled   = state
        button2Up.isUserInteractionEnabled     = state
        button2Down.isUserInteractionEnabled   = state
        button3Up.isUserInteractionEnabled     = state
        button3Down.isUserInteractionEnabled   = state
        button4Up.isUserInteractionEnabled     = state
    }
    
    func enableAllSelectedButtons(_ state: Bool)
    {
        button1DownSelected.isUserInteractionEnabled   = state
        button2UpSelected.isUserInteractionEnabled     = state
        button2DownSelected.isUserInteractionEnabled   = state
        button3UpSelected.isUserInteractionEnabled     = state
        button3DownSelected.isUserInteractionEnabled   = state
        button4UpSelected.isUserInteractionEnabled     = state
    }
    
    func enableAllFactButtons(_ state: Bool)
    {
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
        
        nextRoundSuccess.isUserInteractionEnabled = false
        nextRoundFail.isUserInteractionEnabled = false
        viewScoreSuccessButton.isUserInteractionEnabled = false
        
        timerLabel.text = getTimeStringFor(seconds: secPerQuestion)
        timerLabel.isHidden = false
        messageLabel.text = "Shake to complete"
        
        counter = Double(secPerQuestion)
    }


}

