//
//  Balloon.swift
//  Balloon Game
//
//  Created by Kathryn Hodge on 3/29/15.
//  Copyright (c) 2015 blondiebytes. All rights reserved.
//

import Foundation
import SpriteKit

class Balloon:SKSpriteNode {
    var canTouch:Bool = true;
    var offsetPos:CGFloat = 0;
    
    // INITIALIZATION
    init() {
        let texture = SKTexture(imageNamed: "balloon")
        // We have to call this Initalizer
        super.init(texture: texture, color: nil, size: texture.size())
        
        // Creating an ellipse physics body for the balloon
        // the x and y original is really off though -> maybe because we reset the x later, but like
        // the y is off too.
        
        // NOT NEEDED:
//        self.anchorPoint = CGPoint(x: 0.0, y: 0.0)
//        let rect:CGRect = CGRect(x: self.position.x, y: self.position.y, width: self.size.width, height: self.size.height)
//        let path:CGPathRef = CGPathCreateWithEllipseInRect(rect, nil)
       // self.physicsBody = SKPhysicsBody(polygonFromPath: path)
        
         // Set Physics
        self.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        self.physicsBody?.affectedByGravity = true
        self.physicsBody?.categoryBitMask = ColliderType.Balloon.rawValue
        self.physicsBody?.contactTestBitMask = ColliderType.Obstacle.rawValue
        self.physicsBody?.collisionBitMask = ColliderType.Obstacle.rawValue
        self.physicsBody?.allowsRotation = false
        
        
        // Other Factors
        self.color = UIColor.redColor()
    }
    
    
    // ---------------------------------------
    // It errors when I take this line away...
    // Why do we need this?
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // ---------------------------------------
    
    
    
    // TICKING
    func tickBalloon() {
        // the balloon shouldn't ever move its xPos
        
    }
    
    // TOUCHING
    // if the screen recieves a touch
    // Need a more elegant function...
    func touchBalloon(isTouched:Bool) {
        // should be called every tick
        if (isTouched && canTouch && !willBeOffScreenWithTouch()) {
        // when touched, --> bool is true
        // the balloon should inflate up,
            // look at followPath and CGPath for smoother curve
            let action = SKAction.moveToY((self.position.y + 50), duration: 0.5)
            self.canTouch = false;
            self.physicsBody?.affectedByGravity = false
            self.runAction(action,
                completion:{
                () -> Void
                in
                self.canTouch = true;
                self.physicsBody?.affectedByGravity = true}            )
        } else {
            // otherwise, deflate downward via gravity
        }
        
    }
    
    
    // OFFSCREEN?
    func isOffScreen() -> Bool {
        // check if balloon is off screen
        let offsetNeg = offsetPos * CGFloat(-1)
        let offsetUP:Bool = self.position.y >= offsetPos
        let offsetDOWN:Bool =  self.position.y <= offsetNeg
        if (offsetUP) {
            self.position.y = offsetPos
        } else if (offsetDOWN) {
            self.position.y = offsetNeg
        }
        return offsetUP || offsetDOWN
    }
    
    func willBeOffScreenWithTouch() -> Bool {
        let newBalloon:Balloon = Balloon()
        newBalloon.offsetPos = self.offsetPos
        newBalloon.position.y = self.position.y + 50
        return newBalloon.isOffScreen()
    }
    
    func blink(theBalloon:SKPhysicsBody) {
        // Opaque Actions
        let opaqueVal:CGFloat = 0.25
        let opaqueIt : (() -> Void) = {() -> Void in self.opaquey(theBalloon, opaqueVal:opaqueVal)}
        let opaque_action = SKAction.runBlock(opaqueIt)
        let opaque_delay = SKAction.waitForDuration(1/6)
        
        // Re-Fill Actions
        let fullOpaque:CGFloat = 1
        let fullIt : (() -> Void) = {() -> Void in self.opaquey(theBalloon, opaqueVal:fullOpaque)}
        let full_action = SKAction.runBlock(fullIt)
        let full_delay = SKAction.waitForDuration(1/6)
        
        let seq_action = SKAction.sequence([opaque_action,opaque_delay, full_action, full_delay])
        let repeat_action = SKAction.repeatAction(seq_action, count: 3)
        
        self.runAction(repeat_action)
    }
    
    func opaquey(theBalloon:SKPhysicsBody, opaqueVal:CGFloat) {
        theBalloon.node?.alpha = opaqueVal
    }
    
    
    /// TESTS --> These should go somewhere else,
    // but I'll put them here for now
    
    func checkDoesInflateWhenPressed() {
        
    }
    
    func checkDoesDeflateWhenNotPressed() {
        
    }
    
    func checkIsEverOffScreen() {
        
    }
    
    func checkGameOver() {
        
    }
    
    
    
    
}