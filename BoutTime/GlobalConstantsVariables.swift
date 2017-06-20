//
//  FactLib.swift
//  BoutTime
//
//  Created by Frederick Balagadde on 6/16/17.
//  Copyright © 2017 Frederick Balagadde. All rights reserved.
//

import Foundation



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

enum GameStates: String
{
    case idle
    case initialization
    case timerOn
    case timerOffNextRound
    case timerOffViewScore
    case viewScore
    case webView
    case welcomeScreen
    case startNewGame
}

enum Answer: String
{
    case correct
    case wrong
    case undetermined
}


let scoreVCID = "scoreVC"
let webVCID = "webVC"
let reloadVCID = "reloadVC"
var webURLGlobal: String = "https://www.google.com/"

//Structure for storing fact dictionaries
struct FactSet
{
    let worldChangingEvents: [String: (factDate: String?, factURL: String?)] =
        [
            "Apollo 11 Moon Landing - 1969":                    ("7-20-1969",   "https://en.wikipedia.org/wiki/Apollo_11"),
            "US Declaration of Independence - 1776":            ("07-04-1776",   "https://en.wikipedia.org/wiki/United_States_Declaration_of_Independence"),
            "Assassination of Archduke Franz Ferdinand - 1914":  ("6-28-1914",     "https://en.wikipedia.org/wiki/Assassination_of_Archduke_Franz_Ferdinand_of_Austria"),
            "Wall Street Crash - 1929":                      ("10-29-1929",     "https://en.wikipedia.org/wiki/Wall_Street_Crash_of_1929"),
            "Nazi Invasion of Poland - 1939":                 ("9-1-1939",      "https://en.wikipedia.org/wiki/Invasion_of_Poland"),
            "Pearl Harbor Attack - 1941":                    ("12-7-1941",      "https://en.wikipedia.org/wiki/Attack_on_Pearl_Harbor"),
            "D-Day Normandy landings - 1944":                ("6-6-1944",       "https://en.wikipedia.org/wiki/Normandy_landings"),
            "The Atomic Bombing of Hiroshima - 1945":          ("8-6-1945",      "https://en.wikipedia.org/wiki/Atomic_bombings_of_Hiroshima_and_Nagasaki"),
            "Foundation of the U.N. - 1945":                  ("10-24-1945",    "https://en.wikipedia.org/wiki/United_Nations"),
            "Cuban Missile Crisis - 1962":                    ("10-16-1962",    "https://en.wikipedia.org/wiki/Cuban_Missile_Crisis"),
            "John F Kennedy Assassination - 1963":             ("11-22-1963",    "https://en.wikipedia.org/wiki/Assassination_of_John_F._Kennedy"),
            "Chernobyl Disaster - 1986":                     ("4-26-1986",      "https://en.wikipedia.org/wiki/Chernobyl_disaster"),
            "The Berlin Wall Falls - 1989":                  ("6-1-1989",       "https://en.wikipedia.org/wiki/Berlin_Wall#Fall_of_the_Wall"),
            "World Trade Center Terrorist Attacks - 2001":      ("9-11-2001",      "https://en.wikipedia.org/wiki/September_11_attacks"),
            "The October Revolution - 1917":                  ("10-26-1917",     "https://en.wikipedia.org/wiki/October_Revolution"),
            "Discovery of Penicillin - 1928":                 ("9-28-1928",      "https://en.wikipedia.org/wiki/Penicillin#Discovery"),
            "First gulf war - 1990":                         ("8-2-1990",      "https://en.wikipedia.org/wiki/Gulf_War"),
            "French Revolution - 1789":                      ("05-05-1789",    "https://en.wikipedia.org/wiki/French_Revolution"),
            "The Berlin Conference to colonize Africa - 1884":    ("11-15-1884",   "https://en.wikipedia.org/wiki/Berlin_Conference"),
            "Constantinople Capture by Ottoman Turks - 1453":     ("05-29-1453",   "https://en.wikipedia.org/wiki/Fall_of_Constantinople"),
            "Dolly - world’s first cloned mammal - 1996":       ("7-5-1996",      "https://en.wikipedia.org/wiki/Dolly_(sheep)"),
            "The invention of the world wide web - 1989":       ("3-1-1989",      "https://en.wikipedia.org/wiki/History_of_the_World_Wide_Web#1980.E2.80.931991:_Invention_and_implementation_of_the_Web"),
            "Breakup of the Soviet Union - 1991":              ("12-26-1991",    "https://en.wikipedia.org/wiki/Dissolution_of_the_Soviet_Union"),
            "Nelson Mandela release from prison - 1989":        ("2-11-1989",   "https://en.wikipedia.org/wiki/Nelson_Mandela#Victor_Verster_Prison_and_release:_1988.E2.80.9390"),
            "Brexit - 2016":                                ("6-23-2016",   "https://en.wikipedia.org/wiki/United_Kingdom_European_Union_membership_referendum,_2016"),
            "Wright Brother's First Flight - 1903":            ("12-14-1903",   "https://en.wikipedia.org/wiki/Wright_brothers#First_powered_flight"),
            "Charles Lindbergh Solo across Atlantic - 1927":    ("5-20-1927",   "https://simple.wikipedia.org/wiki/Charles_Lindbergh#First_solo_flight_across_the_Atlantic_Ocean"),
            "Hitler Becomes German Chancellor - 1933":         ("3-24-1933",    "https://en.wikipedia.org/wiki/Adolf_Hitler%27s_rise_to_power"),
            "India and Pakistan Gain Independence - 1947":      ("8-15-1947",   "https://en.wikipedia.org/wiki/Independence_Day_(India)"),
            "Mao's Communists Take Over China - 1949":         ("10-1-1949",    "https://en.wikipedia.org/wiki/Chinese_Communist_Revolution"),
            "Roger Bannister Breaks the 4 Minute Mile - 1954":  ("5-6-1954",    "https://en.wikipedia.org/wiki/Roger_Bannister#Sub-4-minute_mile"),
            "Princess Diana Dies in Car Crash - 1997":         ("8-31-1997",    "https://en.wikipedia.org/wiki/Death_of_Diana,_Princess_of_Wales"),
            "The Capture of Saddam Hussein - 2003":           ("12-13-2003",    "https://en.wikipedia.org/wiki/Saddam_Hussein#Capture_and_incarceration"),
            "Hurricane Katrina - 2005":                     ("8-23-2005",   "https://en.wikipedia.org/wiki/Hurricane_Katrina"),
            "Indian Ocean Tsunami Disaster - 2004":           ("12-26-2004",    "https://en.wikipedia.org/wiki/2004_Indian_Ocean_earthquake_and_tsunami"),
            "Apple unveils iPhone - 2007":                   ("6-29-2007",  "https://en.wikipedia.org/wiki/IPhone_(1st_generation)"),
            "Election of first Black US President - 2008":     ("11-7-2008",    "https://en.wikipedia.org/wiki/Barack_Obama"),
            "Steve Jobs Birthday - 1955":                   ("02-24-1955",  "https://en.wikipedia.org/wiki/Steve_Jobs"),
            "Nelson Mandela Dies - 2013":                    ("12-5-2013",  "https://en.wikipedia.org/wiki/Death_of_Nelson_Mandela"),
            "Martin Luther King Jr. Assassination - 1968":      ("4-4-1968",    "https://en.wikipedia.org/wiki/Assassination_of_Martin_Luther_King_Jr."),
            "Bill Gates Birthday - 1955":                    ("10-28-1955", "https://en.wikipedia.org/wiki/Bill_Gates")
    ]
    
    
    let famousBirthdays: [String: (factDate: String?, factURL: String?)] =
        [
            "Diego Maradona - 1960":           ("10-30-1960", "https://en.wikipedia.org/wiki/Diego_Maradona"),
            "Pele - 1940":                     ("10-23-1940", "https://en.wikipedia.org/wiki/Pel%C3%A9"),
            "Michael Jordan - 1963":           ("02-17-1963", "https://en.wikipedia.org/wiki/Michael_Jordan"),
            "Bob Marley - 1945":               ("02-06-1945", "https://en.wikipedia.org/wiki/Bob_Marley"),
            "Michael Jackson - 1958":          ("08-29-1958", "https://en.wikipedia.org/wiki/Michael_Jackson"),
            "Thomas Edison - 1847":            ("02-11-1847", "https://en.wikipedia.org/wiki/Thomas_Edison"),
            "Nikola Tesla - 1856":             ("07-10-1856", "https://en.wikipedia.org/wiki/Nikola_Tesla"),
            "Steve Jobs - 1955":               ("02-24-1955", "https://en.wikipedia.org/wiki/Steve_Jobs"),
            "Bill Gates - 1955":               ("10-28-1955", "https://en.wikipedia.org/wiki/Bill_Gates"),
            "George Washington - 1732":        ("02-22-1732", "https://en.wikipedia.org/wiki/George_Washington"),
            "Henry Ford - 1863":               ("07-30-1863", "https://en.wikipedia.org/wiki/Henry_Ford"),
            "John D. Rockefeller - 1839":      ("07-08-1839", "https://en.wikipedia.org/wiki/John_D._Rockefeller"),
            "Abraham Lincoln - 1809":          ("02-12-1809", "https://en.wikipedia.org/wiki/Abraham_Lincoln"),
            "Albert Einstein - 1879":          ("03-14-1879", "https://en.wikipedia.org/wiki/Albert_Einstein"),
            "Isaac Newton - 1642":             ("12-25-1642", "https://en.wikipedia.org/wiki/Isaac_Newton"),
            "Wolfgang Amadeus Mozart - 1756":  ("01-27-1756", "https://en.wikipedia.org/wiki/Wolfgang_Amadeus_Mozart"),
            "Richard Feynman - 1918":          ("05-11-1918", "https://en.wikipedia.org/wiki/Richard_Feynman"),
            "Pablo Picasso - 1881":            ("10-25-1881", "https://en.wikipedia.org/wiki/Pablo_Picasso"),
            "Andrew Carnegie - 1835":          ("11-25-1835", "https://en.wikipedia.org/wiki/Andrew_Carnegie"),
            "Barack Obama - 1961":             ("08-04-1961", "https://en.wikipedia.org/wiki/Barack_Obama")
    ]
}
