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
    let animateRightTextures = [SKTexture(imageNamed: "DuckRight1"), SKTexture(imageNamed: "DuckRight2"), SKTexture(imageNamed: "DuckRight3")]
    let anumateFallingTextures = [SKTexture(imageNamed: "DuckFalling")]

    enum Movement {
        case Up
        case Left
        case Right
        case Falling
    }
    
    private var _movement: Movement = .Left
    
    var movement: Movement {
        get {
            return self._movement
        }
        set(newValue) {
            self._movement = newValue
            self.animate()
        }
    }
    
    func animate() {
        let action: SKAction
        switch self.movement {
        case .Up:
            action = SKAction.animateWithTextures(animateUpTextures, timePerFrame: 0.1)
        case .Right:
            action = SKAction.animateWithTextures(animateRightTextures, timePerFrame: 0.1)
        case .Left:
            action = SKAction.animateWithTextures(animateRightTextures, timePerFrame: 0.1)
            self.xScale *= -1
        case .Falling:
            action = SKAction.animateWithTextures(anumateFallingTextures, timePerFrame: 0.1)
        default:
            action = SKAction.animateWithTextures(animateUpTextures, timePerFrame: 0.1)
        }
        self.runAction(SKAction.repeatActionForever(action))
    }
}
