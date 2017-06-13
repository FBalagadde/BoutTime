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
    
    @IBOutlet weak var nextRoundSuccess: UIButton!
    @IBOutlet weak var nextRoundFail: UIButton!
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        initializeAppObjects()
    }

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
        
        button1DownSelected.isHidden = true
        button2UpSelected.isHidden = true
        button2DownSelected.isHidden = true
        button3UpSelected.isHidden = true
        button3DownSelected.isHidden = true
        button4UpSelected.isHidden = true
        
        factFrame1.layer.cornerRadius = cornerRadius
        factFrame2.layer.cornerRadius = cornerRadius
        factFrame3.layer.cornerRadius = cornerRadius
        factFrame4.layer.cornerRadius = cornerRadius
        
        button1DownSelected.isEnabled = false
        button2UpSelected.isEnabled = false
        button2DownSelected.isEnabled = false
        button3UpSelected.isEnabled = false
        button3DownSelected.isEnabled = false
        button4UpSelected.isEnabled = false
        
        nextRoundSuccess.isHidden = true
        nextRoundFail.isHidden = true
        
        nextRoundSuccess.isEnabled = false
        nextRoundFail.isEnabled = false
        
        timerLabel.text = "0:00"
        messageLabel.text = "Shake to complete"
    }


}

