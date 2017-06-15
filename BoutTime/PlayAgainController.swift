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
        finalScoreLabel.text = "\(factHandler.numberofCorrectAnswers)/\(factHandler.roundsPerGame)"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    override func viewDidAppear(_ animated: Bool)
    {
        self.viewDidAppear(animated)
        finalScoreLabel.text = "5/6"
    }
    */
    
    @IBAction func playAgain(_ sender: Any)
    {
        //factHandler = FactHandler(factSet: FactSet())
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
