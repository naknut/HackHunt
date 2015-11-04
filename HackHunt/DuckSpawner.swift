//
//  DuckSpawner.swift
//  HackHunt
//
//  Created by Mathias Amnell on 2015-11-04.
//  Copyright © 2015 HackHunt. All rights reserved.
//

import Foundation

import SpriteKit

enum DuckSkill {
    case Baby
    case Easy
    case Medium
    case Hard
    case Hardcore
}

class DuckSpawner {

    var ducks = [Duck]()
    
    var level = 1
    var numberOfDucks : Int {
        get {
            return numberOfDucksForLevel(self.level)
        }
    }
    
    func numberOfDucksForLevel(level : Int) -> Int {
        switch level {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 2
        case 3:
            return 3
        case 4:
            return 4
        default:
            return 3
        }
    }
    
    func spawnInScene(scene : SKScene) {
        for index in 0...numberOfDucks {
            //let fakeDuck = SKShapeNode(circleOfRadius: 10)
            //fakeDuck.name = "FakeDuck"
            //fakeDuck.fillColor = UIColor.redColor()
            let fakeDuck = Duck(imageNamed: "DuckUp1")
            fakeDuck.xScale = 2
            fakeDuck.yScale = 2
            
            let nodeWidth = scene.frame.size.width
            //let nodeHeight = node.frame.size.height
            
            fakeDuck.position = CGPointMake(CGFloat(nodeWidth / CGFloat(numberOfDucks) * CGFloat(index)), CGRectGetMidY(scene.frame))
            ducks.append(fakeDuck)
            
            print(fakeDuck.position)
            
            scene.addChild(fakeDuck)
            fakeDuck.animate()
        }
    }
    
}