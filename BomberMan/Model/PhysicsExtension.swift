//
//  PhysicsExtension.swift
//  BomberMan
//
//  Created by Luca Salmi, Daniel Falkedal, Calle Höglund, Hampus Brandtman on 2022-02-18.
//

import Foundation
import SpriteKit

extension GameScene: SKPhysicsContactDelegate{
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node
        
        //Enemy collision will call their own collision methods
        if nodeA is Enemy {
            let enemyA = nodeA as! Enemy
            enemyA.collision(with: nodeB)
        }
        if nodeB is Enemy {
            let enemyB = nodeB as! Enemy
            enemyB.collision(with: nodeA)
        }
        if nodeA is Enemy && nodeB is Enemy {
            //return if both nodes are enemies
            return
        }
        
        //main switch for body A
        switch contact.bodyA.categoryBitMask{
            
        // BodyA is the Player
        case PhysicsCategory.Player:
            
            let player = getPlayer(node: nodeA!)
            
            switch contact.bodyB.categoryBitMask{
                
                // BodyB is an Enemy
            case PhysicsCategory.Enemy:
                
                if !player.isShielded {
                    player.death(player: nodeA!)
                    isGameOver = true
                }
                
                // BodyB is a Breakable Object
                
                //BodyB is a Bomb
            case PhysicsCategory.Bomb:
                print("Player-Bomb")
                
            case PhysicsCategory.Obstacle:
                print("Player_Obstacle")
                
            case PhysicsCategory.Explosion:
                
                player.death(player: nodeA!)
                isGameOver = true
                
            case PhysicsCategory.TrapBomb:
                
                let trap = getTrap(node: nodeB!)
                trap.isTrapActive = true
                trap.physicsBody = nil
                player.position = trap.position
                player.isTrapped = true
                player.bloodParticle()
                
            default:
                print("mistery")
            }
                        
            switch contact.bodyB.categoryBitMask{
            // BodyB is Player
            case PhysicsCategory.Player:
                
                let player = getPlayer(node: nodeB!)
                if !player.isShielded {
                    player.death(player: nodeB!)
                    isGameOver = true
                }
                
                // BodyB is a Breakable Object
            case PhysicsCategory.Breakable:
                
                let breakable = getBreakable(node: nodeB!)
                breakable.collision(breakable: nodeB)
                
                //BodyB is a Bomb
            case PhysicsCategory.Bomb:
                print("Enemy-Bomb")
                
            case PhysicsCategory.Obstacle:
                print("Enemy-Obstacle")
                
            default:
                print("mystery")
            }
            
        // BodyA is a Breakable
        case PhysicsCategory.Breakable:
            
            guard let breakable = nodeA as? BreakableObject else {return}
                        
            switch contact.bodyB.categoryBitMask{
                
                // BodyB is Player
            case PhysicsCategory.Player:
                
                breakable.collision(breakable: nodeA)
                
                // BodyB is an Enemy
            case PhysicsCategory.Enemy:
                
                let _ = getEnemy(node: nodeB!)
                
                //BodyB is a Bomb
            case PhysicsCategory.Bomb:
                print("Breakable-Bomb")
                
            case PhysicsCategory.Explosion:
                print("look here")
                breakable.collision(breakable: nodeA)
                                
            default:
                print("mystery")
            }
            
            // BodyA is an Obstacle
        case PhysicsCategory.Obstacle:
            
            let _ = contact.bodyA.node as! ObstacleObject
            
            switch contact.bodyB.categoryBitMask{
            
                // BodyB is Player
            case PhysicsCategory.Player:
                
                let _ = getPlayer(node: nodeB!)
                
                // BodyB is an Enemy
            case PhysicsCategory.Enemy:
                
                let _ = getEnemy(node: nodeB!)
                
                //BodyB is a Bomb
            case PhysicsCategory.Bomb:
                print("Obstacle-Bomb")
                
            default:
                print("mystery")
            }
            
        // BodyA is a Bomb
        case PhysicsCategory.Bomb:
            
            //let bomb = contact.bodyA.node as! Bomb
            
            switch contact.bodyB.categoryBitMask{
                
                // BodyB is Player
            case PhysicsCategory.Player:
                
                let _ = getPlayer(node: nodeB!)
                
                // BodyB is an Enemy
            case PhysicsCategory.Enemy:
                
                let _ = getEnemy(node: nodeB!)

                // BodyB is a Breakable Object
            case PhysicsCategory.Breakable:
                print("Bomb-Breakable")
                
                //BodyB is a Bomb
            case PhysicsCategory.Bomb:
                print("Bomb-Bomb")
                
            case PhysicsCategory.Obstacle:
                print("Bomb-Obstacle")
                
            case PhysicsCategory.Explosion:
                let bomb = nodeA as! Bomb
                bomb.tickingTime = BombSettings.explosionTime
                
            default:
                print("mystery")
            }
            
            
            // BodyA is an explosion
            case PhysicsCategory.Explosion:
                
                let _ = contact.bodyA.node as! Explosion
            
                switch contact.bodyB.categoryBitMask{
                    
                case PhysicsCategory.Player:
                    let player = getPlayer(node: nodeB!)
                    player.death(player: nodeB!)
                    
                case PhysicsCategory.Enemy:
                    print("Explosion-Enemy")
                    
                case PhysicsCategory.Breakable:
                    print("look here")
                    if nodeB != nil {
                        let breakable = getBreakable(node: nodeB!)
                        breakable.collision(breakable: nodeB)
                    }
                    
                case PhysicsCategory.Bomb:
                    print("Explosion-Bomb")
                    
                case PhysicsCategory.Obstacle:
                    print("Explosion-Obstacle")
                    
                default:
                    print("mystery")
                }
            
        case PhysicsCategory.TrapBomb:
            
            switch contact.bodyB.categoryBitMask{
                
            case PhysicsCategory.Player:
                
                let trap = getTrap(node: nodeA!)
                trap.isTrapActive = true
                trap.physicsBody = nil
                player?.position = trap.position
                player?.isTrapped = true
                player?.bloodParticle()
                
            default:
                print("mystery")
            }
        case PhysicsCategory.Loot:
            
            switch contact.bodyB.categoryBitMask{
                
            case PhysicsCategory.Player:
                
                let loot = getLoot(node: nodeA!)
                
                loot.collision(loot: nodeA)
                
                print("loot achived")
                
            default:
            print("mistarry") // hampus was here
                
            }
        //default case for main switch
        default:
            print("mystery")
        }

    
    func getEnemy(node: SKNode) -> Enemy{
        return node as! Enemy
    }
    
    func getPlayer(node: SKNode) -> Player{
        return node as! Player
    }
    
    func getBreakable(node: SKNode) -> BreakableObject{
        return node as! BreakableObject
    }
    
    func getObstacle(node: SKNode) -> ObstacleObject{
        return node as! ObstacleObject
    }
    
    func getBomb(node: SKNode) -> Bomb{
        return node as! Bomb
    }
    
    func getExplosion(node: SKNode) -> Explosion{
        return node as! Explosion
    }
    
    func getLoot(node: SKNode) -> LootObject{
        return node as! LootObject
    }
    
    func getTrap(node: SKNode) -> TrapBomb{
        return node as! TrapBomb
    }
    
    
    }
}
