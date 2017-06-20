//
//  PlayAgainController.swift
//  BoutTime
//
//  Created by Frederick Balagadde on 6/14/17.
//  Copyright © 2017 Frederick Balagadde. All rights reserved.
//

import UIKit

class PlayAgainController: UIViewController {

    @IBOutlet weak var finalScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        finalScoreLabel.text = "\(factHandler.gameVars.numberofCorrectAnswers)/\(factHandler.gameVars.roundsPerGame)"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func playAgain(_ sender: Any)
    {
                dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
