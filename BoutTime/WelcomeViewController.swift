//
//  WelcomeViewController.swift
//  BoutTime
//
//  Created by Frederick Balagadde on 6/18/17.
//  Copyright © 2017 Frederick Balagadde. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var resumeButton: UIButton!
    @IBOutlet weak var rulesButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func newGameClickEvent(_ sender: Any) {
        gameState = .startNewGame
         dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resumeClickEvent(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    
    @IBAction func rulesButtonClick(_ sender: Any) {
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
