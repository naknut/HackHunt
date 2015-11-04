////
////  GameScene.swift
////  tvOStestGame
////
////  Created by Niko Ahonen on 04/11/15.
////  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
////
//import SpriteKit
//class GameScene: SKScene {
//    
//    var gameNode: SKSpriteNode = SKSpriteNode()
//    var randomY : CGFloat = CGFloat()
//    var randomX : CGFloat = CGFloat()
//    var waitRandomXandY : SKAction = SKAction()
//    
//    override func didMoveToView(view: SKView) {
//        /* Setup your scene here */
//        self.enumerateChildNodesWithName("SKS*", usingBlock: {
//            (node: SKNode!, stop: UnsafeMutablePointer <ObjCBool>) -> Void in
//            // do something with node or stop
//            self.gameNode = node as! SKSpriteNode
//        })
//        
//        let wait :SKAction = SKAction.waitForDuration(1.0, withRange: 0.5)
//        let randomYAction : SKAction = SKAction.runBlock { () -> Void in
//            
//            let lowerValue = -50
//            let upperValue = 70
//            let result = Int(arc4random_uniform(UInt32(upperValue - lowerValue + 1))) +   lowerValue
//            
//            self.randomY = CGFloat(result)
//            print("result", result)
//        }
//        let randomXAction : SKAction = SKAction.runBlock { () -> Void in
//            
//            let lowerValue = -50
//            let upperValue = 70
//            let result = Int(arc4random_uniform(UInt32(upperValue - lowerValue + 1))) +   lowerValue
//            
//            self.randomX = CGFloat(result)
//            print("result", result)
//        }
//        
//        waitRandomXandY = SKAction.sequence([wait, randomYAction, randomXAction])
//        self.runAction(SKAction.repeatActionForever(waitRandomXandY))
//        
//        
//    }
//    
//    
//    override func update(currentTime: CFTimeInterval) {
//        /* Called before each frame is rendered */
//        self.moveUpDown()
//    }
//    
//    func moveUpDown() {
//        
//        let movementAction : SKAction = SKAction.moveByX(randomX, y: randomY, duration: 10)
//        
//        gameNode.runAction(SKAction.repeatActionForever(movementAction), completion: { () -> Void in
//            print("randomY", self.randomY)
//        })
//    }
//    
//    
//}
