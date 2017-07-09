//
//  GameScene.swift
//  Balloon Game
//
//  Created by Kathryn Hodge on 2/14/15.
//  Copyright (c) 2015 blondiebytes. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    /// Fields
    var balloon:Balloon!
    
    // don't think we need this cause we dont need to keep track
    // of how many obstacles there are - the bags guarantee how
    // many there are
    var obs:Int = 0
    
    var numOfObstacles:UInt32 = 3
    
    //should be [Obstacle] will fix later
    var bagOfRandomObstacles: [Obstacle] = Array()
    var numberOfBags:Int = 3
    
    //must pass these two across worlds
    //    var lives:Int = 5
    var livesBar:SKSpriteNode = SKSpriteNode()
    
    // score only changes when we change levels (so we will have to pass it over)
    //    var score:Int = 0
    var scoreLabel:SKLabelNode = SKLabelNode()
    
    var gameOver = false
    
    // Pausing
    var areWePausing = false
    var pauseLabel = SKLabelNode(text: "PAUSED")
    var pauseButton = SKLabelNode(text: "Pause")
    var pauseX:CGFloat?
    var pauseY:CGFloat?
    
    //exiting no more exit button
    var exitButton = SKLabelNode(text:"Exit")
    var exitX:CGFloat?
    var exitY:CGFloat?
    
    // THINGS THAT SHOULD BE SAVED BETWEEN GAMES:
    // INCLUDES -> lives; score
    var savedData:SavedData?
    
    
    // Important Variables/Constants to keep track of things
    var endOfScreenRight = CGFloat()
    var endOfScreenLeft = CGFloat()
    
    
    
    
    override func didMoveToView(view: SKView) {
        NSLog("didMoveToView running")
        /* Setup your scene here */
        // Called immediately after a scene is presented by a view.
        // used to set up the sceen
        
        // this needed here because of where we put the anchor point
        // we also won't know what the screen size is until we know the view
        /* Set the scale mode to scale to fit the window */
        self.scaleMode = .ResizeFill
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.backgroundColor = SKColor.blueColor()
        
        // Scene should be as big as the screen
        self.size = self.view!.bounds.size
        
        endOfScreenLeft = (self.size.width/2) * CGFloat(-1) * 1.25
        endOfScreenRight = (self.size.width / 2) * 1.25
        
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx:0.0, dy:-0.25)
        
        pauseX = 4 * self.size.width / 9
        pauseY = 4 * self.size.height / 9
       
        exitX = 4 * self.size.width/9 * -1
        exitY = 4 * self.size.height/9 * -1
        
        
        // order matters
        addBG()
        addObstaclesAlgorithm()
        addBalloonNode()
        addLivesLabel()
        addScoreLabel()
        addPauseButton()
        addPauseLabel()
        addExitButton()
    }
    
    func addObstaclesAlgorithm() {
        let create_action = SKAction.runBlock({() -> Void in self.addObstacles()})
        let delay_action = SKAction.waitForDuration(4)
        let seq_action = SKAction.sequence([delay_action, create_action])
        let rep_action = SKAction.repeatActionForever(seq_action)
        self.runAction(rep_action)
    }
    
    func addBG() {
        let bgL = SKSpriteNode(imageNamed:"bg")
        bgL.name = "background1"
        let bgWidth = bgL.texture!.size().width
        let rightSpot = endOfScreenRight * 2
        let moveTime : NSTimeInterval = 5
        
        let firstMoveAction = SKAction.moveByX(bgWidth * -1, y: 0, duration: moveTime)
        let secondMoveAction = SKAction.sequence([firstMoveAction, firstMoveAction])
        let infiniteAction = SKAction.repeatActionForever(SKAction.sequence([secondMoveAction, SKAction.moveToX(rightSpot, duration: 0)]))
        NSLog("Speed: \(bgL.speed)")
        bgL.runAction(SKAction.sequence([firstMoveAction, SKAction.moveToX(rightSpot, duration: 0), infiniteAction]))
        addChild(bgL)
        
        let bgR = SKSpriteNode(imageNamed:"bg")
        bgR.name = "background2"
        bgR.position.x = rightSpot
        bgR.runAction(infiniteAction)
        
        addChild(bgR)
    }
    
    func addLivesLabel() {
        let imageName = "\(self.savedData!.lives)_life"
        livesBar = SKSpriteNode(imageNamed:imageName)
        livesBar.position.x = self.size.width * (1 / 3) * CGFloat(-1)
        livesBar.position.y = self.size.height * (2 / 5)
        
        addChild (livesBar)
    }
    
    func addScoreLabel() {
        scoreLabel = SKLabelNode(text: "\(self.savedData!.score)")
        // (Closer to middle/up) 1/3 -> 2/5 -> 3/7 -> 4/9 -> 1/2 (Closer to offscreen/down)
        scoreLabel.position.x = 4 * self.size.width / 9
        scoreLabel.position.y = 4 * self.size.height / 9 * CGFloat(-1)
        addChild(scoreLabel)
    }
    
    // this will be a view
    func addPauseLabel() {
        pauseLabel.fontSize = 40
        pauseLabel.hidden = true
        addChild(pauseLabel)
    }
    
    // this will be an image
    func addPauseButton() {
        pauseButton.fontSize = 15
        pauseButton.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        pauseButton.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Center
        pauseButton.name = "pauseButton"
        pauseButton.hidden = false
        pauseButton.position.x = pauseX!
        pauseButton.position.y = pauseY!
        NSLog("things")
         pauseButton.physicsBody = SKPhysicsBody(rectangleOfSize: pauseButton.frame.size)
         pauseButton.physicsBody!.affectedByGravity = false
        pauseButton.physicsBody!.friction = 0
        //this is really gross, but it works for now.
        pauseButton.physicsBody!.categoryBitMask = ColliderType.Obstacle.rawValue
        pauseButton.physicsBody!.contactTestBitMask = ColliderType.Balloon.rawValue
        pauseButton.physicsBody!.collisionBitMask = ColliderType.Balloon.rawValue
        addChild(pauseButton)
    }
    
    func addExitButton() {
        exitButton.fontSize = 15
        exitButton.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        exitButton.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Center
        exitButton.name = "exitButton"
        exitButton.hidden = false
        exitButton.position.x = exitX!
        exitButton.position.y = exitY!
        exitButton.physicsBody = SKPhysicsBody(rectangleOfSize: exitButton.frame.size)
        exitButton.physicsBody!.affectedByGravity = false
        exitButton.physicsBody!.friction = 0
        //this is really gross, but it works for now.
        exitButton.physicsBody!.categoryBitMask = ColliderType.Obstacle.rawValue
        exitButton.physicsBody!.contactTestBitMask = ColliderType.Balloon.rawValue
        exitButton.physicsBody!.collisionBitMask = ColliderType.Balloon.rawValue
        addChild(exitButton)
        
    }
    
    
    func addBalloonNode() {
        self.balloon = Balloon()
        
        // Setting up x and y positions for the Balloon
        // -------------------------------------------------------------
        // The y position of the node will from user input, BUT
        // the x position will always stay the same --> on the left side of the screen
        self.balloon.position.x = CGFloat(self.size.width / 3) * CGFloat(-1)
        self.balloon.offsetPos = self.size.height / 3
        
        // Creating instance and adding to the SK node system
        
        addChild(self.balloon)
    }
    
    let tooManyObstaclesEndRound = 5
    func addObstacles() {
        
        // If the obstacle bag is empty
        if (obs >= tooManyObstaclesEndRound) {
            self.savedData!.score++
            changeScene()
        }
        
        if (bagOfRandomObstacles.isEmpty){
            makeRandomObstacleBag()
        }
        
        let obstacle: Obstacle = bagOfRandomObstacles[0]
        
        // if adding a lightning cloud, then just add another lightning
        if (obstacle is LightningCloud) {
            NSLog("added lightning cloud")
            var lightning: Lightning = Lightning ()
            setObstacle(lightning, yPos: obstacle.position.y - lightning.size.height/2)
            lightning.alpha = 0;
            addChild (lightning)
        }
        
        obs++
        addChild(obstacle)
        
        
        bagOfRandomObstacles.removeAtIndex(0)
        
        // Don't think is necessary?
        obs++
        
    }
    
    
    
    func makeRandomObstacleBag() {
        // creating a random bag and just turning one into a letter
        // creating a mixed bag of obstacle
        var i:UInt32 = 0
        let randomBagSizeUInt32:UInt32 = 15
        
        while (i < randomBagSizeUInt32) {
            bagOfRandomObstacles.append(makeObstacle())
            i++
        }
        
        i = 0
        
        //makes a new letter everytime
        while (i < randomBagSizeUInt32) {
            let topScreen = self.size.height/2
            let positionMod = obs % 4 + 1
            let yPos = topScreen - (CGFloat (positionMod) * self.size.height / 4)
            let newLetter:LetterObstacle = LetterObstacle()
            setObstacle(newLetter, yPos: yPos)
            let j:Int = Int(i)
            bagOfRandomObstacles.insert(newLetter, atIndex: j)
            i++
        }
        
        //replacing an obstacle with a letter in a random spot
//        let letterNumber:Int = Int(arc4random_uniform(randomBagSizeUInt32))
//        bagOfRandomObstacles.removeAtIndex(letterNumber)
//        bagOfRandomObstacles.insert(newLetter, atIndex: letterNumber)
        
    }
    
    func makeObstacle() -> Obstacle {
        
        // Creates a number between 0 and 999 to be modded
        let numToBeMod:UInt32 = arc4random_uniform(1000)
        
        // Give a number in the ranges of 0 to the number of obstacles - 1
        // not including the letter to create an instance of a random obstacle
        let obstacleMod:Int = Int(numToBeMod % numOfObstacles)
        
        
        
        // makes a variable to subtract from so we don't have to worry about
        // negatives and positives?
        let topScreen = self.size.height/2
        
        var obstacle:Obstacle
        var yPos:CGFloat
        
        
        // Setting up x and y positions for the Obstacle
        // -------------------------------------------------------------
        // The y position will always stay the same once set, BUT
        // the x position will always be changing (as the bird goes across
        // the screen)
        
        var screenSectionsCGFloat:CGFloat = 8
        var screenSectionsUInt:UInt32 = 8
        // for some reason it errors when obstacleMod == 1
        if ( obstacleMod == 1 ) /* add bird */  {
            obstacle = Bird()
            let positionMod:Int = Int(numToBeMod % screenSectionsUInt)
            
            // makes it go from sections 1 to x in a screen divided by x + 1
            // basically so that it never gets on the edges, may have to change
            // to have room for lightning and tree
            
            yPos = topScreen - CGFloat( CGFloat(positionMod + 1) *
                CGFloat(self.size.height / screenSectionsCGFloat))
            
        } else if (obstacleMod == 2) /* add lightning cloud */ {
            obstacle = LightningCloud()
            yPos = self.size.height/2 - obstacle.size.height/2
        } else /* add tree */ {
            obstacle = Tree()
            yPos = self.size.height / -2 + obstacle.size.height/2
        }
        
        // setting where the obstacle is on the screen
        setObstacle(obstacle, yPos: yPos)
        
        return obstacle
        
    }
    
    
    
    
    // In case we want to set, reset obstacles at the beginning of a round
    func setObstacle(obstacleNode:Obstacle, yPos:CGFloat) {
        obstacleNode.position.x = endOfScreenRight
        obstacleNode.position.y = yPos
        
    }
    
    var canHit = true
    func didBeginContact(contact: SKPhysicsContact) {
        if (!canHit) {
            return
        }
        canHit = false;
        // stuff for collision
        
        // if the thing collides, remove the physics body of the obstacle (expect the letter,
        // kill the letter) - so this solves the problems of collisions and moving them
        
        // Figure out which one isn't the balloon
        
        // because there's an a and b, there's a problem in more than two things collide
        var notBalloon = contact.bodyA
        var theBalloon = contact.bodyB
        
        if (notBalloon.node is Balloon ) {
            notBalloon = contact.bodyB
            theBalloon = contact.bodyA
        }
        
        // Do we want it to blink when it is a letter?
        // It's blinking when hitting other objects, but also don't think
        // it should really blink
        if (!(notBalloon.node is LetterObstacle) && !(notBalloon.node is SKLabelNode)) {
            blink(theBalloon)
        }
        
        // Deciding if the thing should stay there or disappear
        if ( notBalloon.node is LetterObstacle ) {
            // we add 1 to our letter count
            self.savedData!.numberOfLettersToAdd++
            // remove the letter from the screen
            notBalloon.node?.removeFromParent()
            if (self.savedData!.lives < 5) {
                //raise happiness
                self.savedData!.lives++
                // update label
                self.livesBar.texture = SKTexture(imageNamed: "\(self.savedData!.lives)_life")
            }
            // increase letter count
        } else if (notBalloon.node is Obstacle) {
            // delete physics body of obstacle (so we can't hit it again)
            notBalloon.node?.physicsBody = nil
            // happiness meter drops
            if (self.savedData!.lives > 1) {
                println(self.savedData!.lives)
                self.savedData!.lives--
                println(self.savedData!.lives)
                self.livesBar.texture = SKTexture(imageNamed: "\(self.savedData!.lives)_life")
            }
            else {
                // game over so we should end the game and go to a new menu screen
                NSLog("game overing")
                let transition = SKTransition.revealWithDirection(SKTransitionDirection.Down, duration:
                    1.0)
                // exiting the game...
                self.viewC!.performSegueWithIdentifier("backToMenu", sender:self)
                self.endScene()
                
            }
            
        } else {
            // notBalloon.node is SKLabelNode
            
        }
        
        theBalloon.velocity = CGVector(dx: 0, dy: theBalloon.velocity.dy)
        
        
    }
    
    var viewC:UIViewController?
    
    func changeScene() {
        NSLog("going to the country")
        // xxx also end game
        if (self.savedData!.currentCountry == self.savedData!.finalCountry) {
            let transition = SKTransition.revealWithDirection(SKTransitionDirection.Up, duration:
        1.0)
            let scene = EndOfGame()
            scene.viewC = self.viewC
            self.view!.presentScene(scene)
        } else {
            self.viewC!.performSegueWithIdentifier("goToMail", sender:self)
            self.endScene()
        }
    }
    
    func endScene() {
        // ending the scene
        let delay = 0.5 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.view!.presentScene(nil)
        }
    }
    
    // We have to do this here
    func blink(theBalloon:SKPhysicsBody) {
        // Opaque Actions
        let opaqueVal:CGFloat = 0.25
        let opaqueIt : (() -> Void) = {() -> Void in self.opaquey(theBalloon, opaqqueVal:opaqueVal)}
        let opaque_action = SKAction.runBlock(opaqueIt)
        let opaque_delay = SKAction.waitForDuration(1/6)
        
        // Re-Fill Actions
        let fullOpaque:CGFloat = 1
        let fullIt : (() -> Void) = {() -> Void in self.opaquey(theBalloon, opaqqueVal:fullOpaque)}
        let full_action = SKAction.runBlock(fullIt)
        let full_delay = SKAction.waitForDuration(1/6)
        
        let seq_action = SKAction.sequence([opaque_action,opaque_delay, full_action, full_delay])
        let repeat_action = SKAction.repeatAction(seq_action, count: 3)
        
        self.runAction(repeat_action)
    }
    
    func opaquey(theBalloon:SKSpriteNode, opaqueVal:CGFloat) {
        if (theBalloon.physicsBody != nil) {
            theBalloon.alpha = opaqueVal
        }
    }
    
    func opaquey(theBalloon:SKPhysicsBody, opaqqueVal:CGFloat) {
        theBalloon.node!.alpha = opaqqueVal
    }
    
    func touchTouchesNode(touch:AnyObject, node:SKNode) -> Bool {
        let location:CGPoint = touch.locationInNode(self)
        let convertedLoc:CGPoint = CGPoint(x: location.x + (self.view!.bounds.width * 0.5), y: location.y + (self.view!.bounds.height * 0.5))
        var maybeBody:SKPhysicsBody? = self.physicsWorld.bodyAtPoint(convertedLoc)
        if let theBody = maybeBody {
            NSLog("has body: \(theBody)")
            if let theNode = theBody.node {
                NSLog("has node: \(theNode)")
                if let name = theNode.name {
                    NSLog("has name: \(name)")
                    if (name == node.name) {
                        NSLog("name is equal \(name)")
                        return true
                    } else {
                        return false
                    }
                } else {
                    return false
                }
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    let testingON:Bool = false
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        if (testingON) {
            self.changeScene()
        }
        balloon.touchBalloon(true)
        balloon.isOffScreen()
        
        /* Called when a touch begins */
        for touch: AnyObject in touches {
            if ( self.touchTouchesNode(touch, node:pauseButton ) ) {
                self.areWePausing = !areWePausing
                NSLog("we are pausing")
            }
            if ( self.touchTouchesNode(touch, node:exitButton ) ) {
                NSLog("hit exit body")
                self.viewC!.performSegueWithIdentifier("backToMenu", sender: self)
                self.endScene()
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if !gameOver {
            if (areWePausing) {
                // open the subview
                self.speed = 0
                self.alpha = 0.4
                self.pauseLabel.hidden = false
            } else {
                areWePausing = false
                self.speed = 1
                self.alpha = 1
                self.pauseLabel.hidden = true
                updateObstaclesPosition()
                balloon.touchBalloon(false)
            }
        }
        
        // wait for duration
        canHit = true
    }
    
    var lightningPhysicsBodySet = false
    var cloudPhysicsBodySet = false
    func updateObstaclesPosition() {
        
        for somenode in self.children {
            if somenode is Obstacle {
                
                //creates the obstacle and moves it
                let obst = somenode as! Obstacle
                // ticking obstacle
                obst.tick()
                // checking if offscreen
                if (obst.position.x < endOfScreenLeft) {
                    obst.removeFromParent()
                }
                
                
                if (somenode is Lightning) {
                    let lightning:Lightning = somenode as! Lightning
                    // need to find correct interval for endOfScreen / x --> to where we don't interact with the pause button and to where it doesn't take forever to show on screen
                    if (lightning.position.x < endOfScreenRight / 4 && !lightningPhysicsBodySet) {
                        NSLog("put in physics body")
                        lightning.setUpPhysicsBody()
                        changeOpacityLightning(lightning)
                        lightningPhysicsBodySet = true
                    }
                    
                    
                    
                    var lightningPos = lightning.position.x
                    let screenInc:CGFloat = self.size.width/8
                    let screen:CGFloat = self.size.width
                    
                    // this doesn't work correctly....
//                    if (lightningPos > screen - screenInc) {
//                        changeOpacityLightning(lightning)
//                    } else if (lightningPos > (2/3) * screen - screenInc && lightningPos < (2/3) * screen + screenInc) {
//                        changeOpacityLightning(lightning)
//                    } else if (lightningPos > (1/3) * screen - screenInc && lightningPos < (1/3) * screen + screenInc) {
//                        changeOpacityLightning(lightning)
//                    } else if (lightningPos > -screenInc && lightningPos < screenInc) {
//                        changeOpacityLightning(lightning)
//                    } else if (lightningPos > (-1/3) * screen - screenInc && lightningPos < (-1/3) * screen + screenInc) {
//                        changeOpacityLightning(lightning)
//                    } else if (lightningPos > (-2/3) * screen - screenInc && lightningPos < (-1/3) * screen + screenInc) {
//                        changeOpacityLightning(lightning)
//                    } 
                    
                    // is the position of the balloon divided by the length of the 
                    // interval and made into an int
                    
                    
                    
                    let intPos:Int = abs( (Int (lightning.position.x)))
                    let boolInterval:Bool = (intPos % 125 == 1)
                    let atBalloon:CGFloat = lightning.position.x - 75 /* need to add range here */
                    let boolAtBalloon: Bool = (atBalloon < self.balloon.position.x)
                    if (boolInterval || boolAtBalloon ) {
                    //    NSLog("about to change")
                        changeOpacityLightning(lightning)
                    }
                }
                
                if (somenode is LightningCloud) {
                    let cloud = somenode as! LightningCloud
                    // so we don't interact with the pause button
                    if (cloud.position.x < endOfScreenRight / 3 && !cloudPhysicsBodySet) {
                        cloud.setUpPhysicsBody()
                        cloudPhysicsBodySet = true
                    }
                }
            } else if somenode is Balloon {
                let balloonb = somenode as! Balloon
                // Keeping it at a certain part of the screen
                balloonb.isOffScreen()
            }
        }
        
    }
    
    func changeOpacityLightning(lightning:Lightning) {
        
        
        // Opaque Actions
        let opaqueVal:CGFloat = 0
        let opaqueIt : (() -> Void) = {() -> Void in self.opaquey(lightning, opaqueVal:opaqueVal)}
        let opaque_action = SKAction.runBlock(opaqueIt)
        let opaque_delay = SKAction.waitForDuration(1/3)
        
        // Re-Fill Actions
        let fullOpaque:CGFloat = 1
        let fullIt : (() -> Void) = {() -> Void in self.opaquey(lightning, opaqueVal:fullOpaque)}
        let full_action = SKAction.runBlock(fullIt)
        let full_delay = SKAction.waitForDuration(1)
        
        let seq_action = SKAction.sequence([full_action, full_delay, opaque_action])
        //     let repeat_action = SKAction.repeatAction(seq_action, count: 3)
        
        self.runAction(seq_action)
        
    }
    
    //    NSLog("Speed: \(self.speed)")
    //    self.speed = 0
    
    
}
