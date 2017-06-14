//
//  ViewController.swift
//  BoutTime
//
//  Created by Frederick Balagadde on 6/12/17.
//  Copyright © 2017 Frederick Balagadde. All rights reserved.
//

import UIKit

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
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    let famousBirthdays: FactSet = FactSet()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initializeAppObjects()
        canvas()
        startGame()
    }
    
    func startGame()
    {
        let factHandler = FactHandler(factSet: famousBirthdays)
        
        let factList = factHandler.getStarterFacts()
        for fact in factList
        {
            print(fact)
        }
        
        populateLabelsWithFacts(from: factList)
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
    
    
    
    
    @IBAction func moveFact(_ sender: UIButton)
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
            
        default: print("The default statement in func moveFact() has been executed. This should not be happening. Fix error!")
        }
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
    
    //@IBAction func moveFact(_ sender: UIButton)
    //{
    //    switch sender
    //    {
    //    case
    //    default:
    //        print("nothing")
    //    }
    //}
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initializeAppObjects()
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
        
        //button1DownSelected.isHidden = true
        //button2UpSelected.isHidden = true
        //button2DownSelected.isHidden = true
        //button3UpSelected.isHidden = true
        //button3DownSelected.isHidden = true
        //button4UpSelected.isHidden = true
        
        button1Down.isHidden = false
        button2Up.isHidden = false
        button2Down.isHidden = false
        button3Up.isHidden = false
        button3Down.isHidden = false
        button4Up.isHidden = false
        
        button1Down.isEnabled = true
        button2Up.isEnabled = true
        button2Down.isEnabled = true
        button3Up.isEnabled = true
        button3Down.isEnabled = true
        button4Up.isEnabled = true
        
        factFrame1.layer.cornerRadius = cornerRadius
        factFrame2.layer.cornerRadius = cornerRadius
        factFrame3.layer.cornerRadius = cornerRadius
        factFrame4.layer.cornerRadius = cornerRadius
        
        button1DownSelected.isUserInteractionEnabled = false
        button2UpSelected.isUserInteractionEnabled = false
        button2DownSelected.isUserInteractionEnabled = false
        button3UpSelected.isUserInteractionEnabled = false
        button3DownSelected.isUserInteractionEnabled = false
        button4UpSelected.isUserInteractionEnabled = false
        
        nextRoundSuccess.isHidden = true
        nextRoundFail.isHidden = true
        
        nextRoundSuccess.isEnabled = false
        nextRoundFail.isEnabled = false
        
        timerLabel.text = "0:00"
        messageLabel.text = "Shake to complete"
    }


}

