//
//  GameScene.swift
//  HackHuntUIColor(red:0.21, green:0.75, blue:1, alpha:1)//
//  Created by Marcus Isaksson on 04/11/15.
//  Copyright (c) 2015 HackHunt. All rights reserved.
//

import SpriteKit

import GameController

class GameScene: SKScene {
    
    let dot : SKSpriteNode = {
        let dotNode = SKSpriteNode(color: UIColor.redColor(), size: CGSizeMake(20, 20))
        return dotNode
    }()
    
    var controller : GCController? {
        didSet {
            print("attachedToDevice: \(controller?.attachedToDevice)")
            print("vendorName: \(controller?.vendorName)")
            controller?.microGamepad?.valueChangedHandler = { (gamepad : GCMicroGamepad, element : GCControllerElement) -> Void in
                if let directionPad = element as? GCControllerDirectionPad {
                    let x = CGFloat(directionPad.xAxis.value) * (self.frame.size.width * 0.5) + (self.frame.size.width * 0.5)
                    let y = CGFloat(directionPad.yAxis.value) * (self.frame.size.height * 0.5) + (self.frame.size.height * 0.5)
                    self.dot.position = CGPointMake(x, y)
                }
            }
            
            controller?.microGamepad?.buttonA.valueChangedHandler = { (button : GCControllerButtonInput, value : Float, pressed : Bool) -> Void in
                if pressed {
                    let sprite = SKSpriteNode(imageNamed:"Spaceship")
                    
                    sprite.xScale = 0.25
                    sprite.yScale = 0.25
                    sprite.position = self.dot.position
                    
                    let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
                    
                    sprite.runAction(SKAction.repeatActionForever(action))
                    
                    self.addChild(sprite)
                }
            }
        }
    }
    
    override func didMoveToView(view: SKView) {
        
        // Add the dot
        self.dot.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
        self.addChild(self.dot)
        
        // Start listening for the controller
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("gameControllerDidConnect:"), name: GCControllerDidConnectNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("gameControllerDidDisconnect:"), name: GCControllerDidDisconnectNotification, object: nil)
        
        
        self.backgroundColor = UIColor(red:0.21, green:0.75, blue:1, alpha:1)
        
        addBackdrop()
        
        // Start the duck spawner
        let duckSpawner = DuckSpawner()
        duckSpawner.level = 3
        duckSpawner.spawnInScene(self)
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
