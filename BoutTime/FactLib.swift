//
//  FactLib.swift
//  BoutTime
//
//  Created by Frederick Balagadde on 6/16/17.
//  Copyright © 2017 Frederick Balagadde. All rights reserved.
//

import Foundation

var webURLGlobal: String = "https://www.google.com/"

struct VariablesConstants
{
    let roundsPerGame: Int = 6
    let numberOfFactsPerRound: Int = 4
    var numberOfRoundsSoFar: Int = 0
    var numberofCorrectAnswers: Int = 0
    var gameOver = false
}

enum FactSetError: Error
{
    case invalidFact(description: String)
    case invalidDate(description: String)
    case invalidURL(description: String)
    case invalidDateFormat(description: String)
    case invalidFactFromLabel(description: String)
}

struct FactSet
{
    let famousBirthdays: [String: (factDate: String?, factURL: String?)] =
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
