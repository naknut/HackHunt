//
//  Duck.swift
//  HackHunt
//
//  Created by Marcus Isaksson on 04/11/15.
//  Copyright © 2015 HackHunt. All rights reserved.
//

import UIKit
import SpriteKit

class Duck: SKSpriteNode {
    
    let animateUpTextures = [SKTexture(imageNamed: "DuckUp1"), SKTexture(imageNamed: "DuckUp2"), SKTexture(imageNamed: "DuckUp3")]

    enum Movement {
        case Up
        case Left
        case Right
    }
    
    var movement: Movement = .Up
    
    func animate() {
        let action: SKAction
        switch self.movement {
        case .Up:
            action = SKAction.animateWithTextures(animateUpTextures, timePerFrame: 0.1)
        default:
            action = SKAction.animateWithTextures(animateUpTextures, timePerFrame: 0.1)
        }
        self.runAction(SKAction.repeatActionForever(action))
    }
}
