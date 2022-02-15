//
//  GameScene.swift
//  BomberMan
//
//  Created by Luca Salmi, Daniel Falkedal, Calle Höglund, Hampus Brandtman on 2022-02-15.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var backgroundMap: SKTileMapNode!
    var obstaclesTileMap: SKTileMapNode?
    var breakablesTileMap: SKTileMapNode?
    
    var enemyNode = SKNode()
    var player = Player()
    
    var movementManager: MovementManager!
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        backgroundMap = (childNode(withName: "background") as! SKTileMapNode)
        obstaclesTileMap = (childNode(withName: "obstacles")as! SKTileMapNode)
        
        movementManager = MovementManager(self, camera!)
        
        breakablesTileMap = (childNode(withName: "breakables")as! SKTileMapNode)
        
        
    }
    
    override func didMove(to view: SKView) {
        
        addChild(player)
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
      let playerConstraint = SKConstraint.distance(zeroDistance, to: player)
      
      let xInset = min((view?.bounds.width)!/2*camera.xScale, backgroundMap.frame.width/2)
      let yInset = min((view?.bounds.height)!/2*camera.yScale, backgroundMap.frame.height/2)
      
      let constrainRect = backgroundMap.frame.insetBy(dx: xInset, dy: yInset)
      
      let xRange = SKRange(lowerLimit: constrainRect.minX, upperLimit: constrainRect.maxX)
      let yRange = SKRange(lowerLimit: constrainRect.minY, upperLimit: constrainRect.maxY)
      
      let edgeConstraint = SKConstraint.positionX(xRange, y: yRange)
      edgeConstraint.referenceNode = backgroundMap
      
      camera.constraints = [playerConstraint, edgeConstraint]
      
      
    }
    
    func setupWorldPhysics(){
      backgroundMap.physicsBody = SKPhysicsBody(edgeLoopFrom: backgroundMap.frame)
      backgroundMap.physicsBody?.categoryBitMask = PhysicsCategory.Edge
      physicsWorld.contactDelegate = self
    }
    
    func setupBreakablesPhysics(){
        
        guard let breakablesTileMap = breakablesTileMap else {
            return
        }

        for row in 0..<breakablesTileMap.numberOfRows{
            for column in 0..<breakablesTileMap.numberOfColumns{
                
                guard let tile = tile(in: breakablesTileMap, at: (column, row)) else {continue}
                guard tile.userData?.object(forKey: "breakable") != nil else {continue}
                
                let node = SKNode()
                
                node.physicsBody = SKPhysicsBody(rectangleOf: tile.size)
                
                node.physicsBody?.categoryBitMask = PhysicsCategory.Breakable
                node.physicsBody?.contactTestBitMask = PhysicsCategory.Breakable
                    
                node.physicsBody?.isDynamic = false
                node.physicsBody?.friction = 0
                
                node.position = breakablesTileMap.centerOfTile(atColumn: column, row: row)
                breakablesTileMap.addChild(node)
                
            }
        }
    }
    
    
    func setupObstaclesPhysics(){
        guard let obstaclesTileMap = obstaclesTileMap else {
            return
        }

        for row in 0..<obstaclesTileMap.numberOfRows{
            for column in 0..<obstaclesTileMap.numberOfColumns{
                
                guard let tile = tile(in: obstaclesTileMap, at: (column, row)) else {continue}
                guard tile.userData?.object(forKey: "obstacle") != nil else {continue}
                
                let node = SKNode()
                
                node.physicsBody = SKPhysicsBody(rectangleOf: tile.size)

                node.physicsBody?.isDynamic = false
                node.physicsBody?.friction = 0
                
                node.position = obstaclesTileMap.centerOfTile(atColumn: column, row: row)
                obstaclesTileMap.addChild(node)
                
            }
        }
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
                    
                    print("Key found!")
                    
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
                    enemyNode.addChild(enemy)
                    print("Enemy added!")
                    
                }
            }
        }
        
        enemyNode.name = "Enemies"
        addChild(enemyNode)
        
        enemiesMap.removeFromParent()
    }
    
    
    func tile(in tileMap: SKTileMapNode, at coordinates: tileCoordinates) -> SKTileDefinition?{
      return tileMap.tileDefinition(atColumn: coordinates.column, row: coordinates.row)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        movementManager.checkInput(touches, with: event)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        movementManager.checkInput(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        movementManager.stopMovement()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        //Game logic for updating movement goes in movementManagers update()-method
        movementManager.update()
        
        //Call update()-method on all enemies
        for enemy in Enemy.enemies {
            enemy.update()
        }
        
    }
}


extension GameScene: SKPhysicsContactDelegate{
    
    func didBegin(_ contact: SKPhysicsContact) {
        

        let otherBody = contact.bodyA.categoryBitMask == PhysicsCategory.Player ?
        contact.bodyB : contact.bodyA
        
        print(otherBody.categoryBitMask)
      
        switch otherBody.categoryBitMask{
            
        case PhysicsCategory.Breakable:
            let obstacleNode = otherBody.node
            obstacleNode?.removeFromParent()
            
        default:
            break
        }
    
    }
}
