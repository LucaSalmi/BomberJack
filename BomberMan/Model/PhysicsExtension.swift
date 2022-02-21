//
//  PhysicsExtension.swift
//  BomberMan
//
//  Created by Luca Salmi on 2022-02-18.
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
                
                let enemy = getEnemy(node: nodeB!)
                enemy.collision(with: contact.bodyA.node)
                player.collision(with: nodeB)
                
                // BodyB is a Breakable Object
            case PhysicsCategory.Breakable:
                
                let breakable = getBreakable(node: nodeB!)
                breakable.collision(breakable: nodeB)
                
                //BodyB is a Bomb
            case PhysicsCategory.Bomb:
                print("Player-Bomb")
                
            case PhysicsCategory.Obstacle:
                print("Player_Obstacle")
                
            default:
                print("mystery")
            }
            
        // BodyA is an Enemy
        case PhysicsCategory.Enemy:
            
                        
            switch contact.bodyB.categoryBitMask{
            // BodyB is Player
            case PhysicsCategory.Player:
                
                let player = getPlayer(node: nodeB!)
                print(player)
                
                // BodyB is an Enemy
            case PhysicsCategory.Enemy:
                
                let enemy = getEnemy(node: nodeB!)
                print(enemy)
                
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
            
            let breakable = nodeA as! BreakableObject
            
            switch contact.bodyB.categoryBitMask{
                
                // BodyB is Player
            case PhysicsCategory.Player:
                
                breakable.collision(breakable: nodeA)
                
                // BodyB is an Enemy
            case PhysicsCategory.Enemy:
                
                let enemy = getEnemy(node: nodeB!)
                print(enemy)
                
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
            
            let obstacle = contact.bodyA.node as! ObstacleObject
            print(obstacle)
            
            switch contact.bodyB.categoryBitMask{
            
                // BodyB is Player
            case PhysicsCategory.Player:
                
                let player = getPlayer(node: nodeB!)
                print(player)
                
                // BodyB is an Enemy
            case PhysicsCategory.Enemy:
                
                let enemy = getEnemy(node: nodeB!)
                print(enemy)
                
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
                
                let player = getPlayer(node: nodeB!)
                print(player)
                
                // BodyB is an Enemy
            case PhysicsCategory.Enemy:
                
                let enemy = getEnemy(node: nodeB!)
                print(enemy)
                
                // BodyB is a Breakable Object
            case PhysicsCategory.Breakable:
                
                let breakable = getBreakable(node: nodeB!)
                breakable.collision(breakable: nodeB)
                
                //BodyB is a Bomb
            case PhysicsCategory.Bomb:
                print("Bomb-Bomb")
                
            case PhysicsCategory.Obstacle:
                print("Bomb-Obstacle")
                
            default:
                print("mystery")
            }
            
            
            // BodyA is an explosion
            case PhysicsCategory.Explosion:
                
                let explosion = contact.bodyA.node as! Explosion
            
                print("look here 2")
                switch contact.bodyB.categoryBitMask{
                    
                case PhysicsCategory.Player:
                    print("Explosion-Player")
                    
                case PhysicsCategory.Enemy:
                    print("Explosion-Enemy")
                    
                case PhysicsCategory.Breakable:
                    print("look here")
                    let breakable = getBreakable(node: nodeB!)
                    breakable.collision(breakable: nodeB)
                    
                case PhysicsCategory.Bomb:
                    print("Explosion-Bomb")
                    
                case PhysicsCategory.Obstacle:
                    print("Explosion-Obstacle")
                    
                default:
                    print("mystery")
                }
        
        //default case for main switch
        default:
            print("mystery")
        }

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
    
    
    
}
