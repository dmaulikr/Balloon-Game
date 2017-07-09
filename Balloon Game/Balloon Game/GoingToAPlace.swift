//
//  GoingSomewhere.swift
//  Balloon Game
//
//  Created by Kathryn Hodge on 5/2/15.
//  Copyright (c) 2015 blondiebytes. All rights reserved.
//

import Foundation
import SpriteKit

class GoingToAPlace: SKScene {
    
    // here we are going somewhere.
    // show label of country
    // maybe an animation of dot dot dot
    // need a pretty background
    
    var savedData:SavedData?
    var countryLabel:SKLabelNode?
    var backgroundImage:SKNode?
    var viewC:UIViewController?
    var areWeGoing:Bool = true
    
    // dot dot dot
    let dotOne = SKShapeNode(circleOfRadius: 10)
    let dotTwo = SKShapeNode(circleOfRadius: 10)
    let dotThree = SKShapeNode(circleOfRadius: 10)
    var dotIndex = 1
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        // so we aren't super zoomed in
        self.scaleMode = .ResizeFill
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.size = self.view!.bounds.size
        self.backgroundColor = UIColor.purpleColor()
        //setUpBackground()
        setUpCountryLabel()
        setUpDotDotDot()
        NSLog("initing going somewhere scene")
    }
    
    func setUpCountryLabel() {
        countryLabel = SKLabelNode(text: "We are going to \(savedData!.currentCountry)!")
        countryLabel!.fontSize = 40
        // we will want to change the font
        // countryLabel!.fontName = "blah"
        addChild(countryLabel!)
    }
    
    func setUpBackground() {
        backgroundImage = SKSpriteNode(imageNamed: "stationery")
        
        addChild(backgroundImage!)
        
    }
    
    func fillDot(shouldFill:Bool) {
        // which dot do we work with
        let dot:SKShapeNode?
        if (dotIndex == 1) {
            dot = dotOne
        } else if (dotIndex == 2) {
            dot = dotTwo
        } else if (dotIndex == 3){
            dot = dotThree
        } else {
            dotIndex++
            return
        }
        
        // what color do we make it
        let color:SKColor
        if (shouldFill) {
            color = SKColor.whiteColor()
        } else {
            color = SKColor.clearColor()
        }
        dot!.fillColor = color
        
        // update index
        if (dotIndex >= 3) {
            dotIndex = 1
        } else {
            dotIndex++
        }
        
    }
    
    func setUpDotDotDot() {
        // create a loop of actions
        // three seperate dots -> fill each at a different point using SKActions
        
        dotOne.position.x = -30
        dotOne.position.y = -50
        dotTwo.position.x = 30
        dotTwo.position.y = -50
        dotThree.position.x = 0
        dotThree.position.y = -50
        
        
        let delayTime:NSTimeInterval = 0.06
        
        // creating actions
        let dotFilledAction = SKAction.runBlock({() -> Void in self.fillDot(true)})
        
        let dotUNFillAction = SKAction.runBlock({() -> Void in self.fillDot(false)})
        
        let fillDelay = SKAction.waitForDuration(delayTime)
        
        let unfillDelay = SKAction.waitForDuration(delayTime * 6)
        
        let infiniteAction = SKAction.repeatActionForever(SKAction.sequence([dotFilledAction, fillDelay, dotUNFillAction, unfillDelay]))
        
        addChild(dotOne)
        addChild(dotTwo)
        addChild(dotThree)
        
        self.runAction(infiniteAction)
        
    }
    
    func goSomewhere() {
        let delay = 2.0 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()) {
            let scene:GameScene = GameScene()
            scene.savedData = self.savedData!
            scene.viewC = self.viewC
            let transition = SKTransition.crossFadeWithDuration(1)
            let reveal =  SKTransition.revealWithDirection(SKTransitionDirection.Left, duration: 3/2)
            scene.scaleMode = .ResizeFill
            NSLog("about to present scene")
            self.view!.presentScene(scene, transition: transition)
            NSLog("scene presented")
        }
    }
    
    
    override func update(currentTime: NSTimeInterval) {
        if (areWeGoing) {
            goSomewhere()
        }
        
        areWeGoing = false
        
    }
    
    
}


