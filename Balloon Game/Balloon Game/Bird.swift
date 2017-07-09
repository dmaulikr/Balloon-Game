//
//  Bird.swift
//  Balloon Game
//
//  Created by Kathryn Hodge on 3/29/15.
//  Copyright (c) 2015 blondiebytes. All rights reserved.
//

import Foundation
import SpriteKit

class Bird:Obstacle {

    // INITALIZATION
    init() {
        let texture = SKTexture(imageNamed: "b1")
        // we have to call this initalizer
        super.init(texture: texture, color: nil, size: texture.size())
        self.speed = 3
        self.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = ColliderType.Obstacle.rawValue
        self.physicsBody?.contactTestBitMask = ColliderType.Balloon.rawValue
        self.physicsBody?.collisionBitMask = ColliderType.Balloon.rawValue
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // TICKING
    override func tick() {
        
        self.position.x = self.position.x - self.speed
        
        
        var whichPic:Int = (abs ((Int)(self.position.x) / 3 )) % 16
       
        
         
        if (whichPic < 4) {
            whichPic = 1
        } else if (whichPic < 8) {
            whichPic = 2
        } else if ( whichPic < 12) {
            whichPic = 3
        } else {
            whichPic = 4
        }
    
        let imageName:String = "b\(whichPic)"
        self.texture = SKTexture(imageNamed: imageName)
        
    }

}