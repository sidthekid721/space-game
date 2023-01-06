//
//  GameScene.swift
//  test
//
//  Created by Siddharth Venigalla on 1/4/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var ship: SKSpriteNode?
    var fuel: SKSpriteNode?
    var portal: SKSpriteNode?
    var label : SKLabelNode?
    
    
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        
        
        self.ship = self.childNode(withName: "ship") as? SKSpriteNode
        self.fuel = self.childNode(withName: "fuel") as? SKSpriteNode
        self.portal = self.childNode(withName: "portal") as? SKSpriteNode
        self.label = self.childNode(withName: "label") as? SKLabelNode
        
        
      
        

    
        physicsWorld.contactDelegate = self
        
    
        

        
        
       
    }
    
    
    func spawnPortal() {
        
        let portal = SKSpriteNode(imageNamed: "portal")
        portal.name = "portal"
        portal.size = CGSize(width: 100, height: 100)
        portal.position = CGPoint(x: -300, y: 0)
        portal.zPosition = 1
        portal.alpha = 0
        portal.physicsBody = SKPhysicsBody(rectangleOf: portal.size)
        portal.physicsBody?.isDynamic = true
        addChild(portal)
        portal.run(SKAction.fadeIn(withDuration: 5.0))
        
        
    }
    
    func winSequence() {
        
        
        let astronaut = SKSpriteNode(imageNamed: "astronaut")
        astronaut.size = CGSize(width: 200, height: 200)
        astronaut.position = CGPoint(x: -200, y: 300)
        astronaut.zPosition = 1
        astronaut.physicsBody = SKPhysicsBody(rectangleOf: astronaut.size)
        astronaut.physicsBody?.isDynamic = true
        astronaut.physicsBody?.mass = 0.1
        astronaut.physicsBody?.linearDamping = 30
        addChild(astronaut)
        astronaut.run(SKAction.fadeIn(withDuration: 10.0))
        
        let thanksLabel = SKLabelNode(text: "Thanks for Playing!")
        thanksLabel.fontSize = 40
        thanksLabel.fontName = "HelveticaNeue-Bold"
        thanksLabel.fontColor = UIColor.orange
        thanksLabel.position = CGPoint(x: 0, y: 0)
        addChild(thanksLabel)
        thanksLabel.run(SKAction.fadeOut(withDuration: 15.0))
        
        let ground = self.childNode(withName: "ground") as! SKSpriteNode
        ground.removeFromParent()
        
        let mars = self.childNode(withName: "mars") as! SKSpriteNode
        mars.run(SKAction.fadeOut(withDuration: 5.0))
        
        self.label?.run(SKAction.fadeOut(withDuration: 5.0))
        
        
        
        
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if contact.bodyA.node?.name == "ship" {
            
            if contact.bodyB.node?.name == "fuel" {
                
                print("collision between ship and fuel")
                contact.bodyB.node?.removeFromParent()
                spawnPortal()
                
            } else if contact.bodyB.node?.name == "asteroid" {
                
                contact.bodyA.node?.removeFromParent()
                contact.bodyB.node?.removeFromParent()
                self.label?.text = "Game Over"
                
            } else if contact.bodyB.node?.name == "portal" {
                
                contact.bodyA.node?.removeFromParent()
                contact.bodyB.node?.removeFromParent()
                self.label?.text = "You Escaped"
                winSequence()
                
                
            }
            
            
        } else if contact.bodyB.node?.name == "ship" {
            
            if contact.bodyA.node?.name == "fuel" {
                
                print("collision between ship and fuel")
                contact.bodyA.node?.removeFromParent()
                spawnPortal()
                
            } else if contact.bodyA.node?.name == "asteroid" {
                
                contact.bodyB.node?.removeFromParent()
                contact.bodyA.node?.removeFromParent()
                self.label?.text = "Game Over"
                
            } else if contact.bodyA.node?.name == "portal" {
                
                contact.bodyB.node?.removeFromParent()
                contact.bodyA.node?.removeFromParent()
                self.label?.text = "You Escaped"
                winSequence()
                
                
            }
            
        }
        
        if contact.bodyA.node?.name == "asteroid" {
            
            contact.bodyA.node?.removeFromParent()
            
            
            
        } else if contact.bodyB.node?.name == "asteroid" {
            
            
            contact.bodyB.node?.removeFromParent()
            
            
        }
        
    
        
        

    
    }
    
    func spawnAsteroid() {
        
        let asteroid = SKSpriteNode(imageNamed: "asteroid")
        asteroid.name = "asteroid"
        asteroid.size = CGSize(width: 50, height: 50)
        asteroid.position = CGPoint(x: self.ship!.frame.midX, y: self.ship!.frame.midY + 250)
        asteroid.zPosition = 1
        asteroid.physicsBody = SKPhysicsBody(circleOfRadius: asteroid.size.width / 2)
        asteroid.physicsBody?.isDynamic = true
        asteroid.physicsBody?.mass = 0.1
        asteroid.physicsBody?.linearDamping = 10
        asteroid.physicsBody?.contactTestBitMask = 1
        
        
        addChild(asteroid)
        
        
    }

    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        for touch in touches {
            
            if Int.random(in: 1...100) < 31 {
                
                spawnAsteroid()
                
            }
            
            let position = touch.location(in: self)
            
            if position.x > 0 {
                
                if self.ship!.xScale < 0 {
                    
                    self.ship?.xScale = self.ship!.xScale * -1
                    
                    
                }
                
                self.ship?.run(SKAction.group([
                
                    SKAction.moveBy(x: 50, y: 0, duration: 0.5),
                    
                    SKAction.animate(with: [
                    
                    SKTexture(imageNamed: "ship-1"),
                    SKTexture(imageNamed: "ship-2"),
                    SKTexture(imageNamed: "ship-1")
                    
                    
                    
                    ], timePerFrame: 0.5/3)
                
                
                
                
                
                ]))
                
                
            } else {
                
                if self.ship!.xScale > 0 {
                    
                    self.ship?.xScale = self.ship!.xScale * -1
                    
                    
                }
                
                self.ship?.run(SKAction.group([
                
                    SKAction.moveBy(x: -50, y: 0, duration: 0.5),
                    
                    SKAction.animate(with: [
                    
                    SKTexture(imageNamed: "ship-1"),
                    SKTexture(imageNamed: "ship-2"),
                    SKTexture(imageNamed: "ship-1")
                    
                    
                    ], timePerFrame: 0.5/3)
                
                
                
                
                ]))
                
                
                
            }
            
            
            
            
            
            
                           }


    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
    
        
    }
}
