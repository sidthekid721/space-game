//
//  MenuScene.swift
//  test
//
//  Created by Siddharth Venigalla on 1/6/23.
//

import Foundation
import SpriteKit
import GameKit


class MenuScene: SKScene {
    
    override func didMove(to view: SKView) {
        
        let button = SKLabelNode(text: "Play Game")
        button.name = "btn"
        button.position = CGPoint(x: 0, y: 0)
        addChild(button)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        let position = touch?.location(in: self)
        let touchedNode = self.nodes(at: position!)
        
        if let name = touchedNode[0].name {
            
            if name == "btn" {
                
                let yourNextScene = SKScene(fileNamed: "GameScene")
                yourNextScene?.scaleMode = .aspectFill
                self.view?.presentScene(yourNextScene)
                
                
            }
            
            
        }
        
        
    }
    
    
    
    
    
    
    
}
