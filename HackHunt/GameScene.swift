//
//  GameScene.swift
//  HackHuntUIColor(red:0.21, green:0.75, blue:1, alpha:1)//
//  Created by Marcus Isaksson on 04/11/15.
//  Copyright (c) 2015 HackHunt. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        
        self.backgroundColor = UIColor(red:0.21, green:0.75, blue:1, alpha:1)
        
        let backdrop = SKSpriteNode(imageNamed: "Backdrop")
        backdrop.texture?.filteringMode = .Nearest
        backdrop.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMinY(self.frame)+(backdrop.frame.size.height * 2) - 40);
        backdrop.xScale = 2
        backdrop.yScale = 2
        self.addChild(backdrop)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
