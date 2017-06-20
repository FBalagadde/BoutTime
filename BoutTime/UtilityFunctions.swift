//
//  UtilityFunctions.swift
//  BoutTime
//
//  Created by Frederick Balagadde on 6/16/17.
//  Copyright © 2017 Frederick Balagadde. All rights reserved.
//

import Foundation

/// UtilityFunctions: Utility methods for support functions such as date comparisons have been moved into this file.

//Convert time in seconds to m:ss format
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

//Is date X before date Y: Make sure X and Y are in correct format before calling this function
func isXLessThanY(x: [String], y: [String]) -> Bool
{
    if Int(y[0])! > Int(x[0])! //Here we do a force unwrap because this function is called after we have checked that the date format is authentic
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

//Replace character in string
func replaceStringChar(forString myString: String, atIndex index: Int, with newChar: String) -> String
{
    var newString = ""
    var count: Int = 0
    
    for character in myString.characters
    {
        if count == index
        {
            newString += newChar
        }else {
            newString += String(character)
        }
        count += 1
    }
    return newString
} // End func replaceStringChar


//Function to check whether an array of string dates is in correct order
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


//Support function for checking whether date X is before date Y
func isXBeforeY(dateX: String, dateY: String) -> Bool
{
    // if not correctFormatFor(dateString: dateString1), return error
    // if not correctFormatFor(dateString: dateString2), return error
    
    //first make sure that date formats are valid or throw error
    let dateXTokens = getStringTokensOf(string: dateX, delimitChar: "-")
    let dateYTokens = getStringTokensOf(string: dateY, delimitChar: "-")
    
    return isXLessThanY(x: dateXTokens, y: dateYTokens)
}

func changeDateToYYYYMMDD(fromMMDDYYY: String) -> String
{
    var dateTokens = getStringTokensOf(string: fromMMDDYYY, delimitChar: "-")
    let month = dateTokens[0]
    let day = dateTokens[1]
    let year = dateTokens[2]
    
    return year + "-" + month + "-" + day //YYYY-MM-DD
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
