//
//  LightningCloud.swift
//  Balloon Game
//
//  Created by Amanda  Ma on 4/2/15.
//  Copyright (c) 2015 blondiebytes. All rights reserved.
//

import Foundation
import SpriteKit

class LightningCloud: Obstacle {
    
    var lightning:Lightning = Lightning()
    
    //initialization
     init() {
        let texture = SKTexture(imageNamed: "cloud")
        
        super.init(texture: texture, color: nil, size: texture.size())
        
        self.speed = 2
//        self.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
//        self.physicsBody?.affectedByGravity = false
//        self.physicsBody?.categoryBitMask = ColliderType.Obstacle.rawValue
//        self.physicsBody?.contactTestBitMask = ColliderType.Balloon.rawValue
//        self.physicsBody?.collisionBitMask = ColliderType.Balloon.rawValue
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpPhysicsBody() {
        let texture = SKTexture(imageNamed: "cloud")
        self.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = ColliderType.Obstacle.rawValue
        self.physicsBody?.contactTestBitMask = ColliderType.Balloon.rawValue
        self.physicsBody?.collisionBitMask = ColliderType.Balloon.rawValue
    }
    
    override func tick() {
        self.position.x = self.position.x - self.speed
        lightning.tick()
    }
        
    
}
