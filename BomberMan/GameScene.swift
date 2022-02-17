//
//  GameScene.swift
//  BomberMan
//
//  Created by Luca Salmi, Daniel Falkedal, Calle Höglund, Hampus Brandtman on 2022-02-15.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    static var viewController: GameViewController? = nil
    
    var backgroundMap: SKTileMapNode?
    
    var enemyNode: SKNode? = SKNode()
    var breakablesNode: SKNode? = SKNode()
    var obstaclesNode: SKNode? = SKNode()
    var player: Player? = Player()
    
    var movementManager: MovementManager? = nil
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        backgroundMap = (childNode(withName: "background") as! SKTileMapNode)
        
        movementManager = MovementManager(self)
        
        
    }
    
    override func didMove(to view: SKView) {
        
        addChild(player!)
        setupCamera()
        setupWorldPhysics()
        setupObstaclesPhysics()
        setupBreakablesPhysics()
        setupEnemiesPhysics()
    }
    
    
    
    override func sceneDidLoad() {
        
        
    
    }
    
    func setupCamera(){
      guard let camera = camera else {return}
      
      let zeroDistance = SKRange(constantValue: 0)
      let playerConstraint = SKConstraint.distance(zeroDistance, to: player!)
      
      let xInset = min((view?.bounds.width)!/2*camera.xScale, backgroundMap!.frame.width/2)
      let yInset = min((view?.bounds.height)!/2*camera.yScale, backgroundMap!.frame.height/2)
      
      let constrainRect = backgroundMap!.frame.insetBy(dx: xInset, dy: yInset)
      
      let xRange = SKRange(lowerLimit: constrainRect.minX, upperLimit: constrainRect.maxX)
      let yRange = SKRange(lowerLimit: constrainRect.minY, upperLimit: constrainRect.maxY)
      
      let edgeConstraint = SKConstraint.positionX(xRange, y: yRange)
      edgeConstraint.referenceNode = backgroundMap
      
      camera.constraints = [playerConstraint, edgeConstraint]
      
      
    }
    
    func setupWorldPhysics(){
      backgroundMap!.physicsBody = SKPhysicsBody(edgeLoopFrom: backgroundMap!.frame)
      backgroundMap!.physicsBody?.categoryBitMask = PhysicsCategory.Edge
      physicsWorld.contactDelegate = self
    }
    
    func setupBreakablesPhysics(){
        
        guard let breakablesTileMap = childNode(withName: "breakables")as? SKTileMapNode else {
            return
        }

        for row in 0..<breakablesTileMap.numberOfRows{
            for column in 0..<breakablesTileMap.numberOfColumns{
                
                guard let tile = tile(in: breakablesTileMap, at: (column, row)) else {continue}
                guard tile.userData?.object(forKey: "breakable") != nil else {continue}
                
                var breakable: BreakableObject
                //eventualy different types of breakable obj???
                if tile.userData?.value(forKey: "breakable") as! Bool == true{
                    
                    breakable = BreakableObject()
                    
                }else{
                    
                    breakable = BreakableObject()
                }
                
                breakable.createPhysicsBody(tile: tile)
                breakable.position = breakablesTileMap.centerOfTile(atColumn: column, row: row)
                
                breakablesNode!.addChild(breakable)
                
            }
        }
        
        breakablesNode!.name = "BreakableObjects"
        addChild(breakablesNode!)
        breakablesTileMap.removeFromParent()
    }
    
    
    func setupObstaclesPhysics(){
        guard let obstaclesTileMap = childNode(withName: "obstacles")as? SKTileMapNode else {
            return
        }

        for row in 0..<obstaclesTileMap.numberOfRows{
            for column in 0..<obstaclesTileMap.numberOfColumns{
                
                guard let tile = tile(in: obstaclesTileMap, at: (column, row)) else {continue}
                guard tile.userData?.object(forKey: "obstacle") != nil else {continue}
                
                var obstacle: ObstacleObject
                if tile.userData?.value(forKey: "obstacle") as! Bool == true{
                    
                    obstacle = ObstacleObject()
                    
                }else{
                    
                    obstacle = ObstacleObject()
                }
                
                obstacle.createPhysicsBody(tile: tile)
                obstacle.position = obstaclesTileMap.centerOfTile(atColumn: column, row: row)
                
                obstaclesNode!.addChild(obstacle)
            }
        }
        
        obstaclesNode!.name = "ObstaclesObjects"
        addChild(obstaclesNode!)
        obstaclesTileMap.removeFromParent()
    }
    
    func setupEnemiesPhysics() {
        
        guard let enemiesMap = childNode(withName: "enemies") as? SKTileMapNode else {
            return
        }
        
        for row in 0..<enemiesMap.numberOfRows {
            for column in 0..<enemiesMap.numberOfColumns {
                
                guard let tile = tile(in: enemiesMap, at: (column, row)) else {
                    continue
                }
                
                if tile.userData?.object(forKey: "enemyType") != nil {
                    
                    let value = tile.userData?.value(forKey: "enemyType") as! String
                    
                    var enemy: Enemy
                    
                    if value == "testEnemy" {
                        enemy = TestEnemy()

                    }
                    else {
                        enemy = TestEnemy()
                    }
                
                    enemy.position = enemiesMap.centerOfTile(atColumn: column, row: row)
                    Enemy.enemies.append(enemy)
                    enemyNode!.addChild(enemy)
                    
                }
            }
        }
        
        enemyNode!.name = "Enemies"
        addChild(enemyNode!)
        
        enemiesMap.removeFromParent()
    }
    
    
    func tile(in tileMap: SKTileMapNode, at coordinates: tileCoordinates) -> SKTileDefinition?{
      return tileMap.tileDefinition(atColumn: coordinates.column, row: coordinates.row)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        movementManager!.checkInput(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        movementManager!.checkInput(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        movementManager!.stopMovement()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        //Game logic for updating movement goes in movementManagers update()-method
        movementManager?.update()
        
        //Call update()-method on all enemies
        for enemy in Enemy.enemies {
            enemy.update()
        }
        
    }
    
    func stopScene() {
        backgroundMap = nil
        enemyNode = nil
        breakablesNode = nil
        obstaclesNode = nil
        player = nil
        movementManager = nil
    }
}

extension GameScene: SKPhysicsContactDelegate{
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node

        
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
                print("Beakable-Player")
                
                // BodyB is an Enemy
            case PhysicsCategory.Enemy:
                
                let enemy = getEnemy(node: nodeB!)
                print(enemy)
                
                //BodyB is a Bomb
            case PhysicsCategory.Bomb:
                print("Breakable-Bomb")
                                
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
            
            
            /*
            // BodyA is an explosion
            case PhysicsCategory.Explosion:
                
                //let bomb = contact.bodyA.node as! Explosion
                
                switch contact.bodyB.categoryBitMask{
                    
                case PhysicsCategory.Player:
                    print("Bomb-Player")
                    
                case PhysicsCategory.Enemy:
                    print("Bomb-Enemy")
                    
                case PhysicsCategory.Breakable:
                    print("Bomb-Breakable")
                    
                case PhysicsCategory.Bomb:
                    print("Bomb-Bomb")
                    
                case PhysicsCategory.Obstacle:
                    print("Bomb-Obstacle")
                    
                default:
                    print("mystery")
                }
             */
        
        //default case for main switch
        default:
            print("mystery")
        }
        
        
        /*
        //Check if any of the contacts are enemies
        if contact.bodyA.node is Enemy {
            let enemy = contact.bodyA.node as! Enemy
            enemy.collision(with: contact.bodyB.node ?? nil)
        }
        if contact.bodyB.node is Enemy {
            let enemy = contact.bodyB.node as! Enemy
            enemy.collision(with: contact.bodyA.node ?? nil)
        }
        
        if contact.bodyA.node is Player {
            let player = contact.bodyA.node as! Player
            player.collision(with: contact.bodyA.node ?? nil)
        }
        if contact.bodyB.node is Player {
            let player = contact.bodyB.node as! Player
            player.collision(with: contact.bodyA.node ?? nil)
        }
        
        
        let otherBody = contact.bodyA.categoryBitMask == PhysicsCategory.Player ?
        contact.bodyB : contact.bodyA
              
        switch otherBody.categoryBitMask{
            
        case PhysicsCategory.Breakable:
            let obstacleNode = otherBody.node
            obstacleNode?.removeFromParent()
            obstacleNode?.physicsBody = nil
            
        default:
            break
        }
  
         */
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
    
    func getBomb(node: SKNode){
        
    }
    
    func getExplosion(node: SKNode){
        
    }
    
    
    
}


