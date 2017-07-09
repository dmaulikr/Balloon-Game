//
//  LetterScreen.swift
//  Balloon Game
//
//  Created by Kathryn Hodge on 4/17/15.
//  Copyright (c) 2015 blondiebytes. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class MailboxViewController: UIViewController {
    
    
    //Checking to see if I can push a commit
    
    
    //@IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var savedData:SavedData?
    
    var singleLetterView:SingleLetterView = SingleLetterView(letterText: "" , screenWidth: UIScreen.mainScreen().bounds.width / 2 , screenHeight: UIScreen.mainScreen().bounds.height )
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add a background    
        var background:UIImage = UIImage(named:"mailBG")!
        var mailBG:UIImageView = UIImageView(image: background)
        mailBG.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        self.view.addSubview(mailBG)
        
        
        
        // stuff to do with scrollView
        scrollView.userInteractionEnabled = true
        scrollView.scrollEnabled = true
        
        let offsetRightMargin:CGFloat = 10
        
        scrollView.frame = CGRect(x: self.view.frame.width, y: self.view.frame.height, width: self.view.frame.width/4 - offsetRightMargin, height: self.view.frame.height/2 - 20)
        
        
        scrollView.contentSize = CGSize(width: scrollView.bounds.size.width/4 - offsetRightMargin, height: self.view.frame.height/2 - 20)
        
        let tapInView: UITapGestureRecognizer = UITapGestureRecognizer (target: self, action: Selector("handleTap:"))
        
        scrollView.addGestureRecognizer(tapInView)
        
        
        
        // setting up the letters in the scrollView
        let numColumns = 3
        let numRows = 3
        
        var theLetter:UILetterView = UILetterView()
        var aRow = Array(count:numColumns, repeatedValue: theLetter)
        var letters = Array(count:numRows, repeatedValue:aRow)
        
        for row in 0...(numRows - 1) {
            for column in 0...(numColumns - 1) {
                
                var currentLetter:UILetterView = UILetterView()
                
                
                
                // MAKE ONLY THE ONES THAT ARE SELF.SAVEDDATA!.NUMBERSOFLETTERSTOADD VISIBLE
                var whichLetter:Int = row * 3 + column
                if (whichLetter < self.savedData?.numberOfLettersToAdd) {
                    currentLetter.makeOpen()
                }
                
            
                var yPos:CGFloat = CGFloat(row) * (5/4) * currentLetter.bounds.size.height
                var letterWidth:CGFloat = currentLetter.bounds.size.width
                var letterHeight:CGFloat = currentLetter.bounds.size.height
                
                
                // deciding the x pos of the columns
                if (column == 0) {
                    //it's on the left bound of the screen
                    var xPos:CGFloat = 0
                    currentLetter.frame = CGRect(x:0 , y: yPos, width: letterWidth, height: letterHeight)
                    
                } else if (column == 1){
                    //it's in the center of the screen
                    
                    //Do not understand offsetting bu 8....
                    var xPos:CGFloat = self.scrollView.bounds.size.width - currentLetter.bounds.size.width/2 - 8
                    currentLetter.frame = CGRect(x:xPos, y: yPos, width: letterWidth, height: letterHeight)
                    
                    println("this is the middle col minx: ", currentLetter.frame.minX)
                    println(self.scrollView.bounds.size.width - currentLetter.bounds.size.width/2)
                    //println(self.scrollView.bounds.size.width)
                    
                } else {
                    //it's on the right bound of the screen
                    
                    //Do not understand offsetting by 16.....
                    var xPos: CGFloat = 2 * (self.scrollView.bounds.size.width) - letterWidth - 16
                    currentLetter.frame = CGRect(x: xPos , y:yPos, width: letterWidth, height:letterHeight)
                    
                    println("this is the third col min x" , currentLetter.frame.minX)
                    println(self.scrollView.bounds.size.width)
                }
                
                letters[row][column] = currentLetter
                
                scrollView.addSubview(letters[row][column])
                
            }
        }
    }
    
    
    
    
    
    
    func handleTap (sender:UITapGestureRecognizer) {
        let location = sender.locationInView(scrollView)
        // set up for each location -> what should open
        
        if (singleLetterView.shouldShow!) {
            let location = sender.locationInView(scrollView)
            
            //creating dummy variables
            var dummyLetter:UILetterView = UILetterView()
            var letterWidth:CGFloat = dummyLetter.bounds.size.width
            var letterHeight:CGFloat = dummyLetter.bounds.size.height
            
            
            let offsetRightMargin:CGFloat = 10

            // booleans if within the columns
            let firstCol:Bool = location.x > 0 && location.x < letterWidth
            let secondCol:Bool = location.x > (self.scrollView.bounds.size.width/2 - dummyLetter.bounds.size.width/2 - offsetRightMargin) && location.x < (self.scrollView.bounds.size.width/2 + dummyLetter.bounds.size.width/2 - offsetRightMargin)
            let thirdCol:Bool = location.x > (self.scrollView.bounds.size.width - dummyLetter.bounds.size.width - (2 * offsetRightMargin)) && location.x < (self.scrollView.bounds.size.width - (2 * offsetRightMargin))
            
            
            //booleans if within the rows
            let firstRow:Bool = location.y > 0 && location.y < letterHeight
            let secondRow:Bool = location.y > (5/4) * dummyLetter.bounds.size.height && location.y < (9/4) * dummyLetter.bounds.size.height
            let thirdRow:Bool = location.y > (10/4) * dummyLetter.bounds.size.height && location.y < (14/4) * dummyLetter.bounds.size.height
            
            

            
            // figuring out placement within the array
            let inf:Int = 999
            
            var theCol:Int = inf
            var theRow:Int = inf
            
            // looks at which columns it's in
            if (firstCol) {
                theCol = 0
            } else if (secondCol) {
                theCol = 1
            } else if (thirdCol) {
                theCol = 2
            }
            
            // looks at which row it's in
            if (firstRow) {
                theRow = 0
            } else if (secondRow) {
                theRow = 1
            } else if (thirdRow) {
                theRow = 2
            }
            
            
            // the index of the letter array to access for the message
            var letterIndex:Int = theRow * 3 + theCol
            
            
            //shows a letter only if you hit it at the right position and if the
            // letter at the position is a letter you've already gotten
            if (letterIndex < inf && letterIndex < self.savedData?.numberOfLettersToAdd) {
                self.singleLetterView = SingleLetterView(letterText: self.savedData!.theLetters[letterIndex] , screenWidth: UIScreen.mainScreen().bounds.width / 2 , screenHeight: UIScreen.mainScreen().bounds.height )
                self.view.addSubview(singleLetterView)
                singleLetterView.shouldShow = false
            }
            
            
            
            
            
        } else {
            self.singleLetterView.removeFromSuperview()
            singleLetterView.shouldShow = true
            
        }
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "chooseCountry") {
            var svc = segue.destinationViewController as! GameViewController;
            svc.savedData = self.savedData!
            svc.whichScreen = "country"
        }
    }
}

// List (MAY 15)
// Who wants to do transitions????
// 1. Setting up UI for showing letter and icon stuff -> touch letter, go into another subview (need graphics* & cleaning up UI) (AMANDA) *3 days (also choose random country for start and appropriate at least n-step away country for finish

// 2. ALMOST DONE --> Setting up UI for choose countries -> map animation (YAY) or table and sending us back the game scene (KATHRYN) *4 days
// --> recoloring & scaling

// 4. Setting up Main Menu -> Making it look cute and adorable and such (Kathryn's sketch & set up / Amanda draw) *3 days

// 5. What happens when we get to the right country. Setting up UI and all of that for winning the game. (KATHRYN) *3 days (Kathryn's sketch)

// 8. Movements -> Balloon (KATHRYN), Letter (AMANDA), Lightning (AMANDA)

// 9. 2 Backgrounds each *4 days 10c. Finishing up graphics & cleaning any other UI stuff; // 5. Making each country or at least the countries around it (like 4-color theorem) have different game play experience (slightly different colored scenes or something) + how do we make each level harder algorithm (AMANDA) *5 days

// 10. programming SOUNDS --> Last *1 day

// 11. finding SOUNDS --> Last *4 days
// https://www.freesound.org/browse/tags/hit/
//http://www.bfxr.net/
// http://creativecommonsmusic.org/
// http://ocremix.org/remixes/


// THINGS THAT ARE DONE:
// --------------------
// 7. letter hint file -> for each country, we have series of hint letters. Each country should have m hint letters. (KATHRYN) *1 week
// 6. Pause menu & associated linkage (exit, restart) & UI for all that. (Kathryn's sketch & set up / Amanda draw) *3 days
// 3. paths file -> for the game to pick a country that is s steps away from the end country && we need to know the borders (AMANDA) *2 days
//      a) Make files -- DONE

// TO DO:
// --------------------
// - we need to set up 2 files
// 1. letter hint file -> for each country, we have series of hint letters. Each country should have m hint letters. (KATHRYN) *1 week

// 2. paths file -> for the game to pick a country that is s steps away from the end country && we need to know the boarders (AMANDA) *2 days

// 3. Setting up UI for showing letter and icon stuff -> touch letter, go into another subview (need graphics* & cleaning up UI) (AMANDA) *3 days

// 4. Setting up UI for choose countries -> map animation (YAY) or table and sending us back the game scene (KATHRYN) *4 days

// 6. What happens when we get to the right country. Setting up UI and all of that for winning the game. (KATHRYN) *3 days (Kathryn's sketch)

// 7. Pause menu & associated linkage (exit, restart) & UI for all that. (Kathryn's sketch & set up / Amanda draw) *3 days

// 8. Setting up Main Menu -> Making it look cute and adorable and such (Kathryn's sketch & set up / Amanda draw) *3 days

// 9a. programming SOUNDS --> Last *1 day

// 9b. finding SOUNDS --> Last *4 days
// https://www.freesound.org/browse/tags/hit/
//http://www.bfxr.net/
// http://creativecommonsmusic.org/
// http://ocremix.org/remixes/

// 10. Movements -> Balloon (KATHRYN), Letter (AMANDA), Lightning (AMANDA)

// 10a. Timing (KATHRYN) *1 day

// 10b. 2 Backgrounds each *4 days

// 10c. Finishing up graphics & cleaning any other UI stuff; // 5. Making each country or at least the countries around it (like 4-color theorem) have different game play experience (slightly different colored scenes or something) + how do we make each level harder algorithm (AMANDA) *5 days

// EXTRAS:
// - adding coins and a store to change the look of your balloon (or buy more countries you can go to) (or power ups)
// - bonus level -> THE OCEAN





