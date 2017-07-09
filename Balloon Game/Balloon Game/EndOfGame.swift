//
//  EndOfGame.swift
//  Balloon Game
//
//  Created by Kathryn Hodge on 5/3/15.
//  Copyright (c) 2015 blondiebytes. All rights reserved.
//

import Foundation
import SpriteKit



// what do we want to happen at the end of the game?
// present a scene that's like "you found me! blah blah blah"

// where should we present this said scene?
// after the player chooses the correct country? or after loading screen?
// or interrupting GameScene gameplay?

class EndOfGame: SKScene {

    var viewC:UIViewController?
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        // so we aren't super zoomed in
        self.scaleMode = .ResizeFill
        self.physicsWorld.gravity = CGVector(dx: 0.5, dy: 0.5)
        self.size = self.view!.bounds.size
        // setUpUI functions
        
        // what will we need?
        
        // 1. a background
       // setUpBackground()
        //self.backgroundColor = UIColor.blueColor()
        
        // 2. a picture of happy Pierre holding the balloon
        
        // 3. Button going back to the main menu
        setUpToMainMenuButton()
        
    }
    
    
    func setUpBackground() {
        let backgroundImage = SKSpriteNode(imageNamed: "background")
        backgroundImage.position.x = self.view!.bounds.width * 0.5
        backgroundImage.position.y = self.view!.bounds.height * 0.5
        addChild(backgroundImage)
        
    }
    
    func setUpToMainMenuButton() {
        let menuButton = SKLabelNode(text: "Menu")
        menuButton.fontSize = 15
        menuButton.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Center
        menuButton.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        menuButton.physicsBody = SKPhysicsBody(rectangleOfSize: menuButton.frame.size)
        menuButton.name = "menuButton"
        menuButton.physicsBody!.affectedByGravity = false
      menuButton.position.x = self.view!.bounds.width * 0.5
       menuButton.position.y = self.view!.bounds.height * 0.5
        addChild(menuButton)

    }
    
    func goToMainMenu() {
        // xxx also end game
        self.viewC!.performSegueWithIdentifier("backToMainMenu", sender:self)
        self.endScene()
    }
    
    func endScene() {
        // ending the scene
        let delay = 0.5 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.view!.presentScene(nil)
        }
    }

    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            let location:CGPoint = touch.locationInNode(self)
            let convertedLocation:CGPoint = CGPoint(x: location.x  /*+ pauseX*/, y: location.y /* pauseY */)
            var body:SKPhysicsBody? = self.physicsWorld.bodyAtPoint(convertedLocation)
            // not all places have a physics body
            if let possibleBody = body {
                // not all nodes have a name so we must unwrap the name as well
                if let nodeHere = possibleBody.node {
                    if let nodeName = nodeHere.name {
                        if (nodeName == "menuButton") {
                            NSLog("menu button hit")
                            goToMainMenu()
                        } else {
                            NSLog("not going to main menu")
                        }

                    } else {
                        NSLog("no name")
                    }
                } else {
                    NSLog("no node")
                }
            } else {
                NSLog("not in a physics Body")
            }

        }
    }
    
    
    
    
}