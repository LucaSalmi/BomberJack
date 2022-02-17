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
    
    var enemyNode = SKNode()
    var breakablesNode = SKNode()
    var bombsNode = SKNode()
    var player = Player()
    
    var movementManager: MovementManager!
    var actionManager: ActionManagager!
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
        backgroundMap = (childNode(withName: "background") as! SKTileMapNode)
        obstaclesTileMap = (childNode(withName: "obstacles")as! SKTileMapNode)
        
        movementManager = MovementManager(self, camera!)
        actionManager = ActionManagager(self, camera!)
        
        addChild(bombsNode)
        
        
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
                
                breakablesNode.addChild(breakable)
                
            }
        }
        
        breakablesNode.name = "BreakableObjects"
        addChild(breakablesNode)
        breakablesTileMap.removeFromParent()
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
                    
                }
            }
        }
        
        enemyNode.name = "Enemies"
        addChild(enemyNode)
        
        enemiesMap.removeFromParent()
    }
    
    func placeBomb(){
        
        let bomb = Bomb()
        
        
        var tileFound = false
        
        for row in 0..<backgroundMap.numberOfRows{
            for column in 0..<backgroundMap.numberOfColumns{
                 guard let tile = tile(in: backgroundMap, at: (column, row)) else {
                    continue
                 }
                
                let tilePosition = backgroundMap.centerOfTile(atColumn: column, row: row)
                
                let leftSide = tilePosition.x - (tile.size.width/2)
                let topSide = tilePosition.y + (tile.size.height/2)
                let rightSide = tilePosition.x + (tile.size.width/2)
                let bottomSide = tilePosition.y - (tile.size.height/2)
                
                if player.position.x > leftSide && player.position.x < rightSide{
                    if player.position.y > bottomSide && player.position.y < topSide{
                        bomb.position = tilePosition
                        tileFound = true
                        break
                    }
                }
            }
            
            if tileFound {break}
        }
        
        let pos = bomb.position
        bombsNode.addChild(bomb)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            //let bombPos: CGPoint = bomb.position
            bomb.removeFromParent()
            
            self.explosion(pos)
            
            
         }
        
    }
    func explosion(_ position: CGPoint){
        
        let bomb0 = Bomb()
        bomb0.position = position
        
        let bomb1 = Bomb()
        bomb1.position = position
        bomb1.position.x += -32
        
        let bomb2 = Bomb()
        bomb2.position = position
        bomb2.position.x += 32
        
        let bomb3 = Bomb()
        bomb3.position = position
        bomb3.position.y += -32
        
        let bomb4 = Bomb()
        bomb4.position = position
        bomb4.position.y += 32
        
        bombsNode.addChild(bomb0)
        bombsNode.addChild(bomb1)
        bombsNode.addChild(bomb2)
        bombsNode.addChild(bomb3)
        bombsNode.addChild(bomb4)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            //let bombPos: CGPoint = bomb.position
            bomb0.removeFromParent()
            bomb1.removeFromParent()
            bomb2.removeFromParent()
            bomb3.removeFromParent()
            bomb4.removeFromParent()
            
            }
        
        
        
        
        
        
    }
    
    
    func tile(in tileMap: SKTileMapNode, at coordinates: tileCoordinates) -> SKTileDefinition?{
      return tileMap.tileDefinition(atColumn: coordinates.column, row: coordinates.row)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        movementManager.checkInput(touches, with: event)
        actionManager.checkInput(touches, with: event)
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
        
        //Check if any of the contacts are enemies
        if contact.bodyA.node is Enemy {
            let enemy = contact.bodyA.node as! Enemy
            enemy.collision(with: contact.bodyB.node ?? nil)
        }
        if contact.bodyB.node is Enemy {
            let enemy = contact.bodyB.node as! Enemy
            enemy.collision(with: contact.bodyA.node ?? nil)
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
    
    }
}
