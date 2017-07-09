//
//  ChooseCountryScreen.swift
//  Balloon Game
//
//  Created by Kathryn Hodge on 4/17/15.
//  Copyright (c) 2015 blondiebytes. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class ChooseCountryScene: SKScene {
    
    var savedData:SavedData?
    var backgroundName:String = "background"
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        // so we aren't super zoomed in
        self.scaleMode = .ResizeFill
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.speed = 0.0
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self.size = self.view!.bounds.size
        setUpBorders()
        setUpBackToLetterButton()
        setUpCountryLabel()
    }
    
    
    // 1. need func that says which countries can we go to next based on current country
    func setUpBorders() {
        // scale
        
        let scaleX = self.view!.bounds.size.width * 0.5
        let scaleY = self.view!.bounds.size.height * 0.5
        
        // background node
        let backgroundNode:SKSpriteNode = SKSpriteNode(imageNamed:backgroundName)
        // the physics body was a problem!!! YOU CAN'T LAYER PHYSICS BODIES.
        //  let texture:SKTexture = SKTexture(imageNamed: backgroundName)
        //   backgroundNode.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        // backgroundNode.setScale(scale)
        backgroundNode.name = backgroundName
        NSLog("\(backgroundNode.name)")
        //     backgroundNode.position.x = scaleX
        //   backgroundNode.position.y = scaleY
        
        // tint background
        backgroundNode.color = SKColor.grayColor()
        backgroundNode.colorBlendFactor = 0.5
        backgroundNode.alpha = 0.5
        addChild(backgroundNode)
        
        
        // current Country var
        let currentCountry = self.savedData!.currentCountry
        
        // boarders array
        let boarders:NSArray = self.savedData?.boarders_data.valueForKey(currentCountry as String) as! NSArray
        
        // add border nodes
        for i in 0...boarders.count-1 {
            // draw countries that board the current country
            // physics body
            let textureName:String = boarders[i] as! String
            let texture:SKTexture = SKTexture(imageNamed: textureName)
            var countryNode:SKSpriteNode = SKSpriteNode(imageNamed: textureName)
            countryNode.name = boarders[i] as? String
            NSLog("\(countryNode.name)")
            let newSize = CGSize(width: texture.size().width / 2, height: texture.size().height / 2)
            countryNode.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
            //countryNode.physicsBody!.usesPreciseCollisionDetection = true
            // scaling
            //countryNode.setScale(scale)
            //    countryNode.position.x = scaleX
            //  countryNode.position.y = scaleY
            countryNode.alpha = 1
            
            // can we add a custom boarder to physics bodies
            // people say to use a shader or another node -> but you have to trace the physics body
            // so nah
            //            let boarder = SKShapeNode(rectOfSize: texture.size())
            //            boarder.position = countryNode.position
            //            boarder.strokeColor = SKColor.redColor()
            
            //add to scene
            addChild(countryNode)
            //countryNode.addChild(boarder)
        }
        
        // draw current country
        //        let currentCountryTextureName:String = currentCountry
        //        let currentCountryTexture:SKTexture = SKTexture(imageNamed: currentCountryTextureName)
        //        var currentCountryNode:SKSpriteNode = SKSpriteNode(imageNamed: currentCountryTextureName)
        //        currentCountryNode.physicsBody = SKPhysicsBody(texture: currentCountryTexture, size: currentCountryTexture.size())
        //        currentCountryNode.name = currentCountryTextureName
        //        NSLog("\(currentCountryNode.name)")
        //        currentCountryNode.setScale(scale)
        //        currentCountryNode.position.x = scaleX
        //        currentCountryNode.position.y = scaleY
        
        //        // tint
        //        currentCountryNode.color = SKColor.redColor()
        //        currentCountryNode.colorBlendFactor = 0.35
        //        currentCountryNode.alpha = 1
        //        addChild(currentCountryNode)
        
        
        // scale appropriately
        
    }
    
    func setUpBackToLetterButton() {
        var button:SKLabelNode = SKLabelNode(text: "Back to Mailbox")
        button.fontSize = 18
        button.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        button.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Center
        //   button.position.x = self.view!.bounds.width * 0.13
        //  button.position.y = self.view!.bounds.height * 0.05
        button.position.x = 3 * self.view!.bounds.width/9 * -1
        button.position.y = 4 * self.view!.bounds.height/9 * -1
        button.name = "button"
        button.physicsBody = SKPhysicsBody(rectangleOfSize: button.frame.size)
        addChild(button)
    }
    
    func setUpCountryLabel() {
        var label:SKLabelNode = SKLabelNode(text: "Welcome to")
        var width:CGFloat = 0.16
        label.fontSize = 23
        label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Center
        //label.position.x = self.view!.bounds.width * width
        // label.position.y = self.view!.bounds.height * 0.78
        label.position.x = 3 * self.view!.bounds.width/9 * -1
        label.position.y = 3 * self.view!.bounds.height/9
        addChild(label)
        var label2:SKLabelNode = SKLabelNode(text: "\(savedData!.currentCountry)!")
        label2.fontSize = 23
        label2.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        label2.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Center
        //label2.position.x = self.view!.bounds.width * width
        // label2.position.y = self.view!.bounds.height * 0.69
        label2.position.x = label.position.x
        label2.position.y = label.position.y - 30
        addChild(label2)
    }
    
    
    // 2. need func that sets the current country to what the user chose --> where to go next
    func setUpNextCountry(newCountry:String) {
        NSLog("\(newCountry)")
        self.savedData?.currentCountry = newCountry // what the user inputted in the selector.
        /// whenever the user stops messing with the button -> save what it is on
    }
    
    var viewC:UIViewController?
    
    func goSomewhere() {
        var scene = GoingToAPlace()
        scene.savedData = savedData!
        scene.viewC = viewC
        let transition = SKTransition.crossFadeWithDuration(1)
        let reveal = SKTransition.revealWithDirection(SKTransitionDirection.Left, duration: 3/2)
        scene.scaleMode = .ResizeFill
        NSLog("about to present scene")
        self.view!.presentScene(scene, transition: transition)
        NSLog("scene presented")
    }
    
    func backToMail() {
        NSLog("going to the mail")
        // xxx also end game
        self.viewC!.performSegueWithIdentifier("backToMail", sender:self)
        self.endScene()
    }
    
    func endScene() {
        // ending the scene
        let delay = 1.0 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.view!.presentScene(nil)
        }
    }
    
    var scaled:Bool = false
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent)
    {
        
        for touch: AnyObject in touches {
            //in node, not in view!
            let location = touch.locationInNode(self)
            let convertedLocation = CGPoint(x: location.x + (self.view!.bounds.width * 0.5), y: location.y + (self.view!.bounds.height * 0.5))
            
            //make it really small
            let delta:CGFloat = self.size.height / 100000000000
            
            let rectangle = CGRect(x: convertedLocation.x, y: convertedLocation.y, width: delta, height: delta)
            
            var arrayOfBodies:Array = [SKPhysicsBody]()
            
            self.physicsWorld.enumerateBodiesInRect(rectangle) {(body:SKPhysicsBody!, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
                if body.node!.name! == "button" {
                    self.backToMail()
                } else {
                    arrayOfBodies.append(body)
                    NSLog("\(arrayOfBodies.count)")
                }
            }
            
            
            // lets us pick the minimum, but we really want the true thing --> closest to center
            var minimum:CGFloat = 100000
            for aBody in arrayOfBodies {
                NSLog("body")
                if (aBody.area <= minimum) {
                    minimum = aBody.area
                }
            }
            
            for bBody in arrayOfBodies {
                NSLog("area: \(bBody.area) min: \(minimum)")
                if (bBody.area == minimum) {
                    self.setUpNextCountry(bBody.node!.name!)
                    self.goSomewhere()
                }
            }
            
            
            
            // the old way of doing things
            //var body:SKPhysicsBody? = self.physicsWorld.bodyAtPoint(convertedLocation)
            
            // unwrapping the optional!
            // did we touch a physics body
//            if let possibleBody = body {
//                let nodeName:String = possibleBody.node!.name!
//                NSLog("location: \(location) and name: \(nodeName)")
//                // did we touch the button?
//                if (nodeName == "button") {
//                    NSLog("button touched")
//                    backToMail()
//                    break
//                } else {
//                    // or did we touch a country
//                    self.setUpNextCountry(possibleBody.node!.name!)
//                    self.goSomewhere()
//                    
//                }
//            } else {
//                // if not, we touched nothing
//                NSLog("Node not touched")
//                return
//            }
            
            
        }
    }


}







