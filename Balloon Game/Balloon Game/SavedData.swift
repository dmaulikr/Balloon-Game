//
//  SavedData.swift
//  Balloon Game
//
//  Created by Kathryn Hodge on 4/7/15.
//  Copyright (c) 2015 blondiebytes. All rights reserved.
//

import Foundation

class SavedData {
    
    var lives:Int
    var score:Int
    var currentCountry:String = ""
    var finalCountry:String = ""
    var numberOfLettersToAdd:Int
    var hints_data:NSDictionary
    var boarders_data:NSDictionary
    var steps_data: NSDictionary
    var theLetters:[String] = Array()

    //Trying to push a comment 
    
    init() {
        self.lives = 5
        self.score = 0
        self.numberOfLettersToAdd = 0
        
        let hints_path = NSBundle.mainBundle().pathForResource("LetterHints", ofType:"plist") as String?
        self.hints_data = NSDictionary(contentsOfFile: hints_path!)!
        
        let boarders = NSBundle.mainBundle().pathForResource("AdjacencyList", ofType:"plist") as String?
        self.boarders_data = NSDictionary(contentsOfFile: boarders!)!
        
        let steps = NSBundle.mainBundle().pathForResource("StepsList", ofType:"plist") as String?
        self.steps_data = NSDictionary(contentsOfFile: steps!)!
        
        
        self.setStartAndEnd()
        self.setRandomArrayOfLetters()
        
        NSLog("initing")
        
        
    }
    
    init(lives:Int, score:Int, numberOfLettersToAdd:Int, finalCountry:String, hints_data:NSDictionary, boarders_data:NSDictionary, steps:NSDictionary) {
        self.lives = lives
        self.score = score
        self.numberOfLettersToAdd = numberOfLettersToAdd
        self.finalCountry = finalCountry
        self.hints_data = hints_data
        self.boarders_data = boarders_data
        self.steps_data = steps
    }
    
    func setStartAndEnd(){
        // beginningCountry = // pick random country from file
        let allCountries:NSArray = self.steps_data.allValues
        let countriesCount:UInt32 = UInt32 (allCountries.count)
        // pick a random number
        let startingCountryRandIndex:Int = Int (arc4random_uniform(countriesCount))
        // get what's at that number
        let stepsOfRandomCountry:NSDictionary = allCountries.objectAtIndex(startingCountryRandIndex) as! NSDictionary
        // pick what is zero steps away (aka this country)
        let stepZero: NSArray = stepsOfRandomCountry.valueForKey("0") as! NSArray
        let randomStartingCountry = stepZero.firstObject as! String
        
        self.currentCountry = randomStartingCountry
        NSLog("Starting Country: \(currentCountry)")
        
        // now we have our current country. Let's go get our final one.
        
        
        // Based on the first country, pick an final country using paths algorithm
        // could make this a range depending on how many choices we wanted.
        let howFarAway = 5 /*number of countries away*/
        let countriesAtCertainStepAway:NSArray = stepsOfRandomCountry.valueForKey("\(howFarAway)") as! NSArray
        // now pick a random far country
        let stepsAwayCountriesCount:UInt32 = UInt32 (countriesAtCertainStepAway.count)
        let finalCountryIndex:Int = Int (arc4random_uniform(stepsAwayCountriesCount))
        let randomFinalCountry = countriesAtCertainStepAway.objectAtIndex(finalCountryIndex) as! String
        self.finalCountry = randomFinalCountry
        NSLog("Ending Country: \(finalCountry)")
    }
    
    
    // method that picks out the letters that were found
    
    func setRandomArrayOfLetters() {
        
        // creating a letter for
        let nsArrayLetters = self.hints_data.valueForKey(self.finalCountry) as! NSArray
        
        var arrayLetters: [String] = Array()
        
        
        for x in 0...(nsArrayLetters.count)-1 {
            arrayLetters.append(nsArrayLetters.objectAtIndex(x) as! String)
        }
        
        
        var randLetters: [String] = Array()
        
        
        while (arrayLetters.count > 0) {
            
            //creating a random number from the count in the array
            var randomIndex:Int = Int(arc4random_uniform( UInt32(arrayLetters.count) ))
            
            //appending that random letter from the original array to the first one
            randLetters.append(arrayLetters[randomIndex])
            
            //removing that letter from the original array so it can't be chosen again
            arrayLetters.removeAtIndex(randomIndex)
        }
        
        //making the letters array the array of random letters
        self.theLetters = randLetters
        
    }

    
    
    

//    var lives:Int
//    var score:Int
//    var currentCountry:String = ""
//    var finalCountry:String = ""
//    
//    
//    var numberOfLettersToAdd:Int
//    var theLetters:[String]
//    
//    var lettersWeHavePickedUp:[LetterContents]
//    // LetterContents would be what we use in the mailbox view
//    var lettersWeHaveLeft:[LetterContents]
//    var hints_data:NSDictionary
//    var boarders_data:NSDictionary
//
//    init() {
//        self.lives = 5
//        self.score = 0
//        self.numberOfLettersToAdd = 0
//        
//        self.lettersWeHavePickedUp = []
//        self.lettersWeHaveLeft = []
//        
//        let hints_path = NSBundle.mainBundle().pathForResource("LetterHints", ofType:"plist") as String?
//        self.hints_data = NSDictionary(contentsOfFile: hints_path!)!
//        
//        let boarders = NSBundle.mainBundle().pathForResource("AdjacencyList", ofType:"plist") as String?
//        self.boarders_data = NSDictionary(contentsOfFile: boarders!)!
//        
////       // for index in 0...8 {
////        // do things like adding a beginning to the hint and end etc.
////           let hint = (self.hints_data.valueForKey("France")as! NSArray)[index] as! String
////            let letter:LetterContents = LetterContents(contents: hint)
////            self.lettersWeHaveLeft.insert(letter, atIndex: index)
////            }
//        
//        
//        self.setStartAndEnd()
//        
//        
//        self.setRandomArrayOfLetters()
//        
//    }
//    
//    init(lives:Int, score:Int, numberOfLettersToAdd:Int, lettersWeHavePickedUp:[LetterContents], lettersWeHaveLeft:[LetterContents], finalCountry:String, hints_data:NSDictionary, boarders_data:NSDictionary, theLetters: [String]) {
//        self.lives = lives
//        self.score = score
//        self.lettersWeHavePickedUp = lettersWeHavePickedUp
//        self.numberOfLettersToAdd = numberOfLettersToAdd
//        self.lettersWeHaveLeft = lettersWeHaveLeft
//        self.finalCountry = finalCountry
//        self.hints_data = hints_data
//        self.boarders_data = boarders_data
//        self.theLetters = theLetters
//    }
//    
//    func setStartAndEnd(){
//        // beginningCountry = // pick random country from file
//        self.currentCountry = "Norway"
//        // Based on the first country, pick an final country using paths algorithm
//        self.finalCountry = "Russia"
//    }
//    
//    func setRandomArrayOfLetters() {
//        
//        // creating a letter for
//        let nsArrayLetters = self.hints_data.valueForKey(self.finalCountry) as! NSArray
//        
//        var arrayLetters: [String] = Array()
//       
//        
//        for x in 0...(nsArrayLetters.count) {
//            arrayLetters.append(nsArrayLetters.objectAtIndex(x) as! String)
//        }
//        
//        
//        var randLetters: [String] = Array()
//
//        
//        while (arrayLetters.count > 0) {
//            
//            //creating a random number from the count in the array
//            var randomIndex:Int = Int(arc4random_uniform( UInt32(arrayLetters.count) ))
//            
//            //appending that random letter from the original array to the first one
//            randLetters.append(arrayLetters[randomIndex])
//            
//            //removing that letter from the original array so it can't be chosen again
//            arrayLetters.removeAtIndex(randomIndex)
//        }
//        
//        //making the letters array the array of random letters
//        self.theLetters = randLetters
//        
//    }
//    
////    // method that picks out the letters that were found
////    func pickNewLetters() {
////        while (numberOfLettersToAdd > 0) {
////            if(!lettersWeHaveLeft.isEmpty) {
////            // if we still have letters to pick, then go pick them 
////                // may need to add absolute value
////                
////                // This is annoying.
////            var randomIndex:Int = Int(arc4random_uniform(9))
////            while (lettersWeHaveLeft.count < randomIndex) {
////                    randomIndex = Int(arc4random_uniform(9))
////                }
////                
////            var letterPicked = lettersWeHaveLeft[randomIndex]
////            lettersWeHavePickedUp.append(letterPicked)
////            lettersWeHaveLeft.removeAtIndex(randomIndex)
////            } else {
////                // this shouldn't happen
////                break;
////            }
////        }
////    }
//    
//    
//    // 2 letters every level -> takes at least 5 levels to get all the letters
//    // How far away should the country be? 5?/6? countries in between
//    
    
    
}
