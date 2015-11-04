//
//  GunSpriteNode.swift
//  HackHunt
//
//  Created by Mathias Amnell on 2015-11-04.
//  Copyright © 2015 HackHunt. All rights reserved.
//

import UIKit

import SpriteKit

class GunSpriteNode: SKSpriteNode {
    
    let reloadAnimationTextures = [SKTexture(imageNamed: "GunReload1"), SKTexture(imageNamed: "GunReload2"), SKTexture(imageNamed: "GunReload3")]
    let fireAnimationTextures = [SKTexture(imageNamed: "GunShoot1"), SKTexture(imageNamed: "GunShoot2")]
    
    func shoot() {
        let fireAction = SKAction.animateWithTextures(fireAnimationTextures, timePerFrame: 0.1)
        let reloadAction = SKAction.animateWithTextures(reloadAnimationTextures, timePerFrame: 0.2)
        
        let fireThenReloadAction = SKAction.sequence([fireAction, reloadAction])
        self.runAction(fireThenReloadAction) { () -> Void in
            let gunTexture = SKTexture(imageNamed: "Gun1")
            gunTexture.filteringMode = .Nearest
            self.texture = gunTexture
        }
    }
}
