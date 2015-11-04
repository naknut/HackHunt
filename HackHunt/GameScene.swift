//
//  GameScene.swift
//  HackHuntUIColor(red:0.21, green:0.75, blue:1, alpha:1)//
//  Created by Marcus Isaksson on 04/11/15.
//  Copyright (c) 2015 HackHunt. All rights reserved.
//

import SpriteKit

import GameController

class GameScene: SKScene {
    
    var randomY : CGFloat = CGFloat()
    var randomX : CGFloat = CGFloat()
    var waitRandomXandY : SKAction = SKAction()
    
    let dot : SKShapeNode = {
        let dotNode = SKShapeNode(circleOfRadius: 5)
        dotNode.fillColor = UIColor.redColor()
        dotNode.strokeColor = UIColor.redColor()
        dotNode.zPosition = 1001
        return dotNode
    }()
    
    var duckSpawner = DuckSpawner()
    var ducksKilled = 0
    
    var controller : GCController? {
        didSet {
            print("attachedToDevice: \(controller?.attachedToDevice)")
            print("vendorName: \(controller?.vendorName)")
            controller?.microGamepad?.valueChangedHandler = { (gamepad : GCMicroGamepad, element : GCControllerElement) -> Void in
                if let directionPad = element as? GCControllerDirectionPad {
                    let x = CGFloat(directionPad.xAxis.value) * (self.frame.size.width * 0.5) + (self.frame.size.width * 0.5)
                    let y = CGFloat(directionPad.yAxis.value) * (self.frame.size.height * 0.5) + (self.frame.size.height * 0.5)
                    
                    self.dot.position = CGPointMake(x, y)
                    self.gun.position = CGPointMake(x, self.gun.position.y)
                }
            }
            
            controller?.microGamepad?.buttonA.valueChangedHandler = { (button : GCControllerButtonInput, value : Float, pressed : Bool) -> Void in
                if pressed {
                    for duck in self.duckSpawner.ducks {
                        if(self.dot.intersectsNode(duck)) {
                            self.removeChildrenInArray([duck])
                            self.ducksKilled++
                            self.scoreLabel.text = "\(self.ducksKilled) killed ducks"
                            self.duckSpawner.spawnInScene(self)
                        }
                    }
                    
                    self.gun.shoot()
                }
            }
        }
    }
    
    let scoreLabel : SKLabelNode = {
        let theLabelNode = SKLabelNode(text: "0 ducks")
        theLabelNode.zPosition = 1001
//        theLabelNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Right
        return theLabelNode
    }()
    
    let gun : GunSpriteNode = {
        let gunNode = GunSpriteNode(imageNamed: "Gun1")
        gunNode.texture?.filteringMode = .Nearest
        gunNode.zPosition = 1000
        gunNode.xScale = 2
        gunNode.yScale = 2
        return gunNode
    }()
    
    override func didMoveToView(view: SKView) {
        
        // Add the dot
        self.dot.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
        self.addChild(self.dot)
        
        // Start listening for the controller
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("gameControllerDidConnect:"), name: GCControllerDidConnectNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("gameControllerDidDisconnect:"), name: GCControllerDidDisconnectNotification, object: nil)
        
        
        self.backgroundColor = UIColor(red:0.21, green:0.75, blue:1, alpha:1)
        
        addBackdrop()
        
        addScoreLabel()
        
        // Add the gun
        self.gun.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetHeight(self.gun.frame) - 30)
        print(self.gun.position)
        self.addChild(self.gun)
        
        // Start the duck spawner
        //self.duckSpawner = DuckSpawner()
        self.duckSpawner.level = 1
        self.duckSpawner.spawnInScene(self)
        
        let wait :SKAction = SKAction.waitForDuration(1.0, withRange: 0.5)
        let randomYAction : SKAction = SKAction.runBlock { () -> Void in
            
            let lowerValue = 5
            let upperValue = 10
            let result = Int(arc4random_uniform(UInt32(upperValue - lowerValue + 1))) +   lowerValue
            
            self.randomY = CGFloat(result)
        }
        let randomXAction : SKAction = SKAction.runBlock { () -> Void in
            
            let lowerValue = -40
            let upperValue = 40
            let result = Int(arc4random_uniform(UInt32(upperValue - lowerValue + 1))) +   lowerValue
            
            self.randomX = CGFloat(result)
        }
        
        waitRandomXandY = SKAction.sequence([wait, randomYAction, randomXAction])
        self.runAction(SKAction.repeatActionForever(waitRandomXandY))
        
        
    }
    
    func addScoreLabel() {
        scoreLabel.position = CGPointMake(CGRectGetMinX(self.frame) + scoreLabel.frame.size.width/2 + 80, 110)
        self.addChild(scoreLabel)
    }
    
    func addBackdrop() {
        // Add backdrop
        let backdrop = SKSpriteNode(imageNamed: "Backdrop")
        backdrop.texture?.filteringMode = .Nearest
        backdrop.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMinY(self.frame)+(backdrop.frame.size.height * 2) - 40);
        backdrop.xScale = 2
        backdrop.yScale = 2
        backdrop.zPosition = 500
        self.addChild(backdrop)
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        self.moveUpDown()
        
        
    }
    
    func moveUpDown() {
        
        let movementAction : SKAction = SKAction.moveByX(randomX, y: randomY, duration: 10)
        
        self.enumerateChildNodesWithName("Bird") { (node : SKNode!, stop: UnsafeMutablePointer <ObjCBool>) -> Void in
            node.runAction(SKAction.repeatActionForever(movementAction), completion: { () -> Void in
            })
            
            if node.position.y > self.frame.size.height || node.position.x < 0 || node.position.x > self.frame.size.width {
                node.removeFromParent()
                self.duckSpawner.spawnInScene(self)
            }
        }
    }
    
    // MARK : GameController
    
    func gameControllerDidConnect(notification: NSNotification) {
        print("gameControllerDidConnect: and found \(GCController.controllers().count) wireless controllers")
        
        for controller in GCController.controllers() {
            // We force the controller with the "Remote" vendorName to get it to work in Simulator
            if controller.vendorName == "Remote" {
                self.controller = controller
            }
        }
        
        //        print("notification object: \(notification.object)")
        //        if let theController = notification.object as? GCController {
        //            self.controller = theController
        //            //GCController.stopWirelessControllerDiscovery()
        //        }
    }
    
    func gameControllerDidDisconnect(notification: NSNotification) {
        print("Disconnected")
    }
}
