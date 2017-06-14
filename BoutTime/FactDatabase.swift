//
//  FactDatabase.swift
//  BoutTime
//
//  Created by Frederick Balagadde on 6/12/17.
//  Copyright © 2017 Frederick Balagadde. All rights reserved.
//

import Foundation
import GameKit

var numberOfFacterPerRound: Int = 4


struct FactSet
{
    let facts: [String: (factDate: String, factURL: String)] =
    [
        "Diego Maradona":           ("10-30-1960", "https://en.wikipedia.org/wiki/Diego_Maradona"),
        "Pele":                     ("10-23-1940", "https://en.wikipedia.org/wiki/Pel%C3%A9"),
        "Michael Jordan":           ("02-17-1963", "https://en.wikipedia.org/wiki/Michael_Jordan"),
        "Bob Marley":               ("02-06-1945", "https://en.wikipedia.org/wiki/Bob_Marley"),
        "Michael Jackson":          ("08-29-1958", "https://en.wikipedia.org/wiki/Michael_Jackson"),
        "Thomas Edison":            ("02-11-1847", "https://en.wikipedia.org/wiki/Thomas_Edison"),
        "Nikola Tesla":             ("07-10-1856", "https://en.wikipedia.org/wiki/Nikola_Tesla"),
        "Steve Jobs":               ("02-24-1955", "https://en.wikipedia.org/wiki/Steve_Jobs"),
        "Bill Gates":               ("10-28-1955", "https://en.wikipedia.org/wiki/Bill_Gates"),
        "George Washington":        ("02-22-1732", "https://en.wikipedia.org/wiki/George_Washington"),
        "Henry Ford":               ("07-30-1863", "https://en.wikipedia.org/wiki/Henry_Ford"),
        "John D. Rockefeller":      ("07-08-1839", "https://en.wikipedia.org/wiki/John_D._Rockefeller"),
        "Abraham Lincoln":          ("02-12-1809", "https://en.wikipedia.org/wiki/Abraham_Lincoln"),
        "Albert Einstein":          ("03-14-1879", "https://en.wikipedia.org/wiki/Albert_Einstein"),
        "Isaac Newton":             ("12-25-1642", "https://en.wikipedia.org/wiki/Isaac_Newton"),
        "Wolfgang Amadeus Mozart":  ("01-27-1756", "https://en.wikipedia.org/wiki/Wolfgang_Amadeus_Mozart"),
        "Richard Feynman":          ("05-11-1918", "https://en.wikipedia.org/wiki/Richard_Feynman"),
        "Pablo Picasso":            ("10-25-1881", "https://en.wikipedia.org/wiki/Pablo_Picasso"),
        "Andrew Carnegie":          ("11-25-1835", "https://en.wikipedia.org/wiki/Andrew_Carnegie"),
        "Barack Obama":             ("08-04-1961", "https://en.wikipedia.org/wiki/Barack_Obama")
    ]
}

class FactHandler
{
    var factSet: FactSet
    var randomFactKey: String = ""
    
    init(factSet: FactSet)
    {
        self.factSet = factSet
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
                indexOfSelectFact = GKRandomSource.sharedRandom().nextInt(upperBound: factSet.facts.count)
                
                randomFactKey = Array(factSet.facts.keys)[indexOfSelectFact] //questionSet.triviaQuestions[indexOfSelectFact]
                
            } while checkedKeys.contains(randomFactKey)
            checkedKeys.append(randomFactKey) //include the fact key in the gameQuestions array
            
            // If the date string exists, insert it into the return array
            if let factDate = factSet.facts[randomFactKey]?.factDate
            {
                //check if the date is in teh correct format
                if correctFormatFor(dateString: factDate)
                {
                    selectedKeys.append(randomFactKey)
                    //Export only keys with valid dates
                    //keys with invalid URLs may be exported because this is not mandatory for the game to be played
                }
            }
        } while (selectedKeys.count < numberOfFacterPerRound && checkedKeys.count < factSet.facts.count)
        
        // FIXME: 
        // IF you exit this loop and size of seletFactArray < 4, Throw error and exit
 
        return selectedKeys
    }
    
    /// Utility Function for checking is the date string is in an acceptable formatted strings
    /// input date string format: MM-DD-YYYY
    func correctFormatFor(dateString: String) -> Bool
    {
        let dateTokens = getStringTokensOf(string: dateString, delimitChar: "-")
        
        //var correctDateFormat: Bool = true
        
        if dateTokens.count != 3
        {
            return false
        }
        
        let year = dateTokens[2]
        
        if let yearInt = Int(year)
        {
            if yearInt < 0
            {
                return false
            }
        } else {
            return false
        }
        
        
        if year.utf8.count != 4
        {
            return false
        }
        
        if let month = Int(dateTokens[0]), let day = Int(dateTokens[1])
        {
            if !(month >= 1 && month <= 12 && day >= 1 && day <= 31)
            {
                return false
            }
        } else
        {
            return false
        }
        
        return true
    }
    
    
    
    /// Utility Function for tokenizing delimited strings
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


}
















