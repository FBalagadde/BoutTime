//
//  FactDatabase.swift
//  BoutTime
//
//  Created by Frederick Balagadde on 6/12/17.
//  Copyright © 2017 Frederick Balagadde. All rights reserved.
//

import Foundation
import GameKit

class FactHandler
{
    var factSet: [String: (factDate: String, factURL: String)]
    var gameVars: VariablesConstants = VariablesConstants()
    var randomFactKey: String = ""
    
    init(factDictionary factSet: [String: (factDate: String, factURL: String)], gameVars: VariablesConstants){
        
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
    func getStarterFacts() -> [String]
    {
        var indexOfSelectFact: Int = 0
        var checkedKeys: [String] = []
        var selectedKeys: [String] = []
        
        // search through the database and fetch 4 facts. 
        // If a fact is faulty, skip it and get the next one [date does not exist]
        // Fulty: If the date does not exist or if the date is not properly formatted
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
            if let factDate = factSet[randomFactKey]?.factDate
            {
                //check if the date is in teh correct format
                if correctFormatFor(dateString: factDate)
                {
                    selectedKeys.append(randomFactKey)
                    //Export only keys with valid dates
                    //keys with invalid URLs may be exported because this is not mandatory for the game to be played
                }
            }
        } while (selectedKeys.count < gameVars.numberOfFactsPerRound && checkedKeys.count < factSet.count)
        
        // FIXME: 
        // IF you exit this loop and size of seletFactArray < 4, Throw error and exit
 
        return selectedKeys
    }
}
















