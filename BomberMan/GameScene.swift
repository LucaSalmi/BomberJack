//
//  GameScene.swift
//  BomberMan
//
//  Created by Luca Salmi on 2022-02-09.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var backgroundMap: SKTileMapNode!
    var obstaclesTileMap: SKTileMapNode?
    var player = Player()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundMap = (childNode(withName: "background") as! SKTileMapNode)
        obstaclesTileMap = (childNode(withName: "obstacles")as! SKTileMapNode)
        
    }
    
    override func didMove(to view: SKView) {
        
        addChild(player)
        setupCamera()
        setupWorldPhysics()
        setupObstaclePhysics()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        player.move(target: touch.location(in: self))
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
    
    func setupObstaclePhysics() {
      guard let obstaclesTileMap = obstaclesTileMap else { return }
      // 1
      for row in 0..<obstaclesTileMap.numberOfRows {
        for column in 0..<obstaclesTileMap.numberOfColumns {
          // 2
          guard let tile = tile(in: obstaclesTileMap,
                                at: (column, row))
            else { continue }
          guard tile.userData?.object(forKey: "obstacle") != nil
            else { continue }
          // 3
          let node = SKNode()
          node.physicsBody = SKPhysicsBody(rectangleOf: tile.size)
          node.physicsBody?.isDynamic = false
          node.physicsBody?.friction = 0
          

          node.position = obstaclesTileMap.centerOfTile(
            atColumn: column, row: row)
          obstaclesTileMap.addChild(node)
        }
      }
    }
    
    func tile(in tileMap: SKTileMapNode, at coordinates: tileCoordinates) -> SKTileDefinition?{
      return tileMap.tileDefinition(atColumn: coordinates.column, row: coordinates.row)
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
    }
}

extension GameScene: SKPhysicsContactDelegate{
    
}
