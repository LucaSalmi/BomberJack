//
//  GameViewController.swift
//  BomberMan
//
//  Created by Luca Salmi, Daniel Falkedal, Calle Höglund, Hampus Brandtman on 2022-02-15.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    //For physical keyboard input with simulator
    static var currentInputKey: UInt8 = 0
    static var currentGameScene: GameScene? = nil
    
    let numberOfLevels: Int = 3
    var currentLevel: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        GameScene.viewController = self
        
        guard let camera = SKScene(fileNamed: "UIScene")!.camera else {
            print("Error: Could not find UIScene and/or camera!")
            return
        }
        
        Player.camera = camera
        
        //old start menu (before SwiftUI)
        //presentOldStartMenu()
        
        let sceneName = "GameScene\(currentLevel)"
        presentScene(sceneName)
    }
    
    private func presentOldStartMenu() {
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "StartMenuScene") {
        
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! StartMenuScene? {
                
                
                sceneNode.viewController = self
                
                // Copy gameplay related content over to the scene
                //sceneNode.entities = scene.entities
                //sceneNode.graphs = scene.graphs
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .fill
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    //view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func presentScene(_ sceneName: String) {
        
        if let view = self.view as! SKView? {
            
            if let scene = SKScene(fileNamed: sceneName) {
                
                GameViewController.currentGameScene = scene as? GameScene
                
                let transition = SKTransition.fade(with: UIColor.black, duration: 1.5)
                
                scene.scaleMode = .aspectFill
                
                view.presentScene(scene, transition: transition)
                
                //view.ignoresSiblingOrder = true
                
                view.showsFPS = true
                view.showsNodeCount = true
                
            }
            
        }
        
    }
    
    override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        // Run backward or forward when the user presses a left or right arrow key.
        
        var didHandleEvent = false
        for press in presses {
            guard let key = press.key else { continue }
            
            let keyAscii = key.characters.first?.asciiValue
            
            if key.characters.first != nil {
                GameViewController.currentInputKey = keyAscii!
                print(GameViewController.currentInputKey)
                didHandleEvent = true
            }
            
        }
        
        if didHandleEvent == false {
            // Didn't handle this key press, so pass the event to the next responder.
            super.pressesBegan(presses, with: event)
        }
    }
    
    override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
        // Stop running when the user releases the left or right arrow key.

        GameViewController.currentInputKey = 0
        print(String(GameViewController.currentInputKey))
        
        /*
        var didHandleEvent = true
        
        if didHandleEvent == false {
            // Didn't handle this key press, so pass the event to the next responder.
            super.pressesBegan(presses, with: event)
        }
         */
    }
    
}
