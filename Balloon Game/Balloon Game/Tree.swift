//
//  Tree.swift
//  Balloon Game
//
//  Created by Kathryn Hodge on 3/29/15.
//  Copyright (c) 2015 blondiebytes. All rights reserved.
//

import Foundation
import SpriteKit

class Tree:Obstacle {
    
    // INITALIZATION
    init() {
        let texture = SKTexture(imageNamed: "tree")
        // we have to call this initalizer
        super.init(texture: texture, color: nil, size: texture.size())
        self.speed = 1
        self.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = ColliderType.Obstacle.rawValue
        self.physicsBody?.contactTestBitMask = ColliderType.Balloon.rawValue
        self.physicsBody?.collisionBitMask = ColliderType.Balloon.rawValue
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func tick() {
        self.position.x = self.position.x - self.speed
    }
    
    func offScreen() {
        
    }

}