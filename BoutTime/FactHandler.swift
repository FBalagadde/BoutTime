//
//  FactDatabase.swift
//  BoutTime
//
//  Created by Frederick Balagadde on 6/12/17.
//  Copyright © 2017 Frederick Balagadde. All rights reserved.
//

import Foundation
import GameKit
import UIKit

/// FactHandler contains a class which implements functionality for manipulating the facts from the database.
class FactHandler
{
    var factSet: [String: (factDate: String?, factURL: String?)]
    var gameVars: VariablesConstants = VariablesConstants()
    var randomFactKey: String = ""
    
    init(factDictionary factSet: [String: (factDate: String?, factURL: String?)], gameVars: VariablesConstants){
        
        self.factSet = factSet
        self.gameVars = gameVars
    }
    
    func numberOfRoundsSoFar() -> Int{
        return gameVars.numberOfRoundsSoFar
    }
    
    func roundsPerGame() -> Int {
        return gameVars.roundsPerGame
    }
    
    //Game Update Methods
    func incrementRound() {
        gameVars.numberOfRoundsSoFar += 1
    }
    
    func resetGame() {
        gameVars.numberOfRoundsSoFar = 0
    }
    
    func beginningOfGame() -> Bool
    {
        return gameVars.numberOfRoundsSoFar == 0
    }
    
    func incrementScore(){
        gameVars.numberofCorrectAnswers += 1
    }
    
    func setGameState(isGameOver: Bool)
    {
        gameVars.gameOver = isGameOver
    }
    
    func isGameOver() -> Bool
    {
        return gameVars.gameOver
    }
    
    //Throw error 1 here
    // Invalid factSet // tere is no fact with a propperly formatted date
    // The URL error is not a show stopper so it will be handled in the app itself
    /// input date string format: MM-DD-YYYY
    func getStarterFacts() throws -> [String]
    {
        var indexOfSelectFact: Int = 0
        var checkedKeys: [String] = []
        var selectedKeys: [String] = []
        
        // search through the database and fetch 4 random facts.
        // If a fact is faulty (e.g. date does not exist), skip it and get the next one
        // Faulty means: If the date does not exist or if the date is not properly formatted
        // Dont worry about the URL string at this point
        
        //Possible errors
        //1. No valid keys found
        //2. InvalidFactset
        //3. Invalid URL
        
        repeat
        {
            //Obtain a random fact dictionary from a dictionary that has not yet been selected during this round
            repeat
            {
                indexOfSelectFact = GKRandomSource.sharedRandom().nextInt(upperBound: factSet.count)
                
                randomFactKey = Array(factSet.keys)[indexOfSelectFact] //questionSet.triviaQuestions[indexOfSelectFact]
                
            } while checkedKeys.contains(randomFactKey)
            checkedKeys.append(randomFactKey) //include the fact key in the gameQuestions array
            
            // If the date string exists, insert it into the return array
            guard let factKey = factSet[randomFactKey] else
            {
                throw FactSetError.invalidFact(description: "Invalid fact for key: \(randomFactKey) in function getStarterFacts")
            }
            
            guard let factDate = factKey.factDate else
            {
                throw FactSetError.invalidDate(description: "Invalid date value for key: \(randomFactKey)")
            }
            
            //Export only keys with valid dates to avoid game interruption
            //keys with invalid URLs may be exported because this is not mandatory for the game to be played
            if correctFormatFor(dateString: factDate)
            {
                selectedKeys.append(randomFactKey)
            } else {
                print("Invalid date format for key: \(randomFactKey)")
            }
            
           
            
            
        } while (selectedKeys.count < gameVars.numberOfFactsPerRound && checkedKeys.count < factSet.count)
        
        // IF you exit this loop and size of seletFactArray < 4, Throw error and exit
        if selectedKeys.count < (gameVars.numberOfFactsPerRound)
        {
            throw FactSetError.invalidFact(description: "There arent enough facts with valid dates to complete a game round")
        }
 
        return selectedKeys
    }
}
















