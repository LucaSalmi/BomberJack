//
//  TestEnemy.swift
//  BomberMan
//
//  Created by Daniel Falkedal on 2022-02-15.
//

import Foundation
import GameplayKit

class TestEnemy: Enemy {
    
    //Movement AI logic variables
    var changeDirectionInterval: CGFloat = 0.0
    let tileSize: CGFloat = 32.0  //32 = tile size
    let minIntervalMultiplier: Int = 1
    let maxIntervalMultiplier: Int = 5
    var currentMovementDistance: CGFloat = 0.0
    var direction = CGPoint(x: 0, y: 0)
    
    let characterAnimationNames = ["enemy_classic_right_", "enemy_classic_left_", "enemy_classic_down_", "enemy_classic_up_"]
    
    var isAttacking = false
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("use init()")
    }
    
    init(){
        let size: CGSize = CGSize(width: 32, height: 32)
        let tempColor = UIColor(red: 100, green: 100, blue: 100, alpha: 0)
        super.init(SKTexture(imageNamed: "player_shadow"), tempColor, size)
        name = "Test Enemy"
        createAnimationSets(characterAnimationNames: characterAnimationNames, numberOfFrames: AnimationData.numberOfFramesClassicEnemy,
                            timePerFrame: AnimationData.timePerFrameClassicEnemy)
        enemySpeed = 0.5
        difficult = Enemy.superEasy
        direction = getRandomDirection()
        
    }
    
    internal func getRandomDirection() -> CGPoint {
        var newDirection = CGPoint(x: 0, y: 0)
        
        let moveSideways: Bool = Bool.random()
        if moveSideways {
            newDirection.x = 1
        }
        else {
            newDirection.y = 1
        }
        
        let invertDirection: Bool = Bool.random()
        if invertDirection {
            newDirection.x *= -1
            newDirection.y *= -1
        }
        
        //set random move distance based on tile size and a random multiplier within limits
        let intervalMultiplier: Int = Int.random(in: minIntervalMultiplier...maxIntervalMultiplier)
        changeDirectionInterval = tileSize * CGFloat(intervalMultiplier)
        currentMovementDistance = 0 //reset move distance after changing direction
        
        return newDirection
    }
    
    private func updateDirection(newDirection: CGPoint) {
        
        self.position = centerInCurrentTile()
        
        direction = newDirection
    }
    
    
    override func collision(with other: SKNode?) {
        super.collision(with: other)
        
        if isAttacking{
            return
        }
        
        let oldDirection = direction
        var newDirection = direction
        //loop until the new direction is different from the old direction
        while newDirection == oldDirection {
            newDirection = getRandomDirection()
        }
        updateDirection(newDirection: newDirection)
    }
    
    override func update() {
        
        super.update()
                
        if isTrapped || isAttacking{
            return
        }
        
        position.x += (direction.x * enemySpeed)
        position.y += (direction.y * enemySpeed)
        
        currentMovementDistance += enemySpeed
        if currentMovementDistance == changeDirectionInterval {
            updateDirection(newDirection: getRandomDirection())
        }
        
        enemyTexture.position.x = position.x
        enemyTexture.position.y = position.y + PlayerSettings.textureOffset
        
        let direction = PhysicsUtils.findDirection(objDirection: direction)
        runAnim(objDirection: direction)
        
        
    }
    
}
