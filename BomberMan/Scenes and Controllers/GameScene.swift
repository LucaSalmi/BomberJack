//
//  GameScene.swift
//  BomberMan
//
//  Created by Luca Salmi, Daniel Falkedal, Calle Höglund, Hampus Brandtman on 2022-02-15.
//

import SpriteKit
import GameplayKit
import SwiftUI

class GameScene: SKScene {
    
    static var viewController: GameViewController? = nil
    static var tileSize: CGSize? = CGSize(width: 32, height: 32)
    static var gameState = GameState.play
    static var canUseTraps = true
    static var gameOverInsult : String = ""
    
    var trapDelayCounter = 120
    
    var isCaveLevel: Bool = false
    
    var leftUI: SKSpriteNode? = nil
    var rightUI: SKSpriteNode? = nil
    
    var lightNode: SKLightNode? = nil
    var darknessMaskNode: SKSpriteNode? = nil
    
    var bombsNode: SKNode? = SKNode()
    var explosionsNode: SKNode? = SKNode()
    var actionManager: ActionManagager!
    var backgroundMap: SKTileMapNode?
    
    var enemyNode: SKNode? = SKNode()
    var breakablesNode: SKNode? = SKNode()
    var obstaclesNode: SKNode? = SKNode()
    var lootNode: SKNode? = SKNode()
    var eventsNode: SKNode? = SKNode()
    var currentDialogue: Dialogue? = nil
    var playerCutscene: PlayerCutscene? = nil
    var player: Player? = nil
    var victoryCondition: VictoryConditions?
    
    var movementManager: MovementManager? = nil
    
    var cutsceneRunning = false
    var isGameOver = false
    var isDoorOpen = false
        
    let endLevelDelay = 60
    var endLevelCounter = 0
    
    let databaseUpdateLimit = 60 * 120
    var databaseUpdateCounter = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundMap = (childNode(withName: "background") as! SKTileMapNode)
        addChild(bombsNode!)
        addChild(explosionsNode!)
        
    }
    
    override func didMove(to view: SKView) {
        
        setupWorldPhysics()
        setupObstaclesPhysics()
        setupBreakablesPhysics()
        setupEnemiesPhysics()
        setupPlayer()
        setupCamera()
        setupVictoryCond()
        movementManager = MovementManager(self)
        actionManager = ActionManagager(self, camera!)
        setupLootObjects()
        setupEvents()
        setupLightning()
    }
    
    
    
    override func sceneDidLoad() {
        
        //gets a pirate insult from html adress
        getPirateInsult()
    }
    
    func setupLightning() {
        
        guard let node = childNode(withName: "lightNode") else {
            return
        }
        if !(node is SKLightNode) {
            return
        }
        lightNode = (node as! SKLightNode)
        lightNode!.position = player!.position
        lightNode!.falloff = 3
        
        guard let darknessNode = childNode(withName: "darknessMask") else { return }
        darknessMaskNode = (darknessNode as! SKSpriteNode)
        darknessMaskNode!.position = player!.position
        
        isCaveLevel = true
    }
    
    // decides a victory conditions based on what level is loaded
    func setupVictoryCond(){
        
        if UserData.currentLevel > 1 {
            PlayerSettingsUI.instance.haveBombs = true
        }
        
        switch UserData.currentLevel{
            
        case 1:
            victoryCondition = VictoryConditions.openDoor
            
        case 2:
            victoryCondition = VictoryConditions.openDoor
//            let newScale: SKAction = SKAction.scale(by: 0.6, duration: 1)
//            Player.camera!.run(newScale)
//
        case 3:
            victoryCondition = VictoryConditions.openDoorAndKillAll
            
        case 4:
            victoryCondition = VictoryConditions.killAll
            
        default:
            victoryCondition = VictoryConditions.killAll
//            Player.camera!.setScale(CGFloat(0.42))
//            let newScale: SKAction = SKAction.scale(by: 1.66, duration: 1)
//            Player.camera!.run(newScale)
            
        }
    }
    
    func setupCamera(){
        
        let camera = Player.camera!
        
        camera.setScale(CGFloat(0.7))
        
        leftUI = (camera.childNode(withName: "leftUI") as! SKSpriteNode)
        rightUI = (camera.childNode(withName: "rightUI") as! SKSpriteNode)
        
        let zeroDistance = SKRange(constantValue: 0)
        let playerConstraint = SKConstraint.distance(zeroDistance, to: player!.playerTexture)
        
        let xInset = min((view?.bounds.width)!/2*camera.xScale, backgroundMap!.frame.width/2)
        let yInset = min((view?.bounds.height)!/2*camera.yScale, backgroundMap!.frame.height/2)
        
        let constrainRect = backgroundMap!.frame.insetBy(dx: xInset, dy: yInset)
        
        let xRange = SKRange(lowerLimit: constrainRect.minX, upperLimit: constrainRect.maxX)
        let yRange = SKRange(lowerLimit: constrainRect.minY, upperLimit: constrainRect.maxY)
        
        let edgeConstraint = SKConstraint.positionX(xRange, y: yRange)
        edgeConstraint.referenceNode = backgroundMap
        
        camera.constraints = [playerConstraint, edgeConstraint]
        
        camera.removeFromParent()
        self.camera = camera
        addChild(camera)
    }
    
    func setupWorldPhysics(){
        backgroundMap?.physicsBody = SKPhysicsBody(edgeLoopFrom: backgroundMap!.frame)
        backgroundMap?.physicsBody?.categoryBitMask = PhysicsCategory.Edge
        physicsWorld.contactDelegate = self
    }
    
    func setupBreakablesPhysics(){
        
        guard let breakablesTileMap = childNode(withName: "breakables")as? SKTileMapNode else {
            return
        }
        
        for row in 0..<breakablesTileMap.numberOfRows{
            for column in 0..<breakablesTileMap.numberOfColumns{
                
                guard let tile = tile(in: breakablesTileMap, at: (column, row)) else {continue}
                GameScene.tileSize = tile.size
                guard tile.userData?.object(forKey: "tree") != nil || tile.userData?.object(forKey: "fence") != nil else {continue}
                
                var breakable: BreakableObject
                //eventualy different types of breakable obj???
                
                if tile.userData?.value(forKey: "tree") != nil{
                    
                    let textureName = tile.userData!.value(forKey: "tree") as! String
                    
                    breakable = Tree(textureName: textureName)
                    
                }else if tile.userData?.value(forKey: "fence") != nil{
                    
                    let textureName = tile.userData!.value(forKey: "fence") as! String
                    
                    breakable = Fence(textureName: textureName)
                }else{
                    
                    return
                }
                
                breakable.createPhysicsBody(tile: tile)
                breakable.position = breakablesTileMap.centerOfTile(atColumn: column, row: row)
                breakable.breakableTexture.position = breakable.position
                GameScene.updateZPosition(object: breakable)
                breakable.breakableTexture.zPosition = breakable.zPosition
                breakable.breakableTexture.position.y += PlayerSettings.textureOffset
                
                breakablesNode!.addChild(breakable)
                breakablesNode!.addChild(breakable.breakableTexture)
                
            }
        }
        
        breakablesNode!.name = "BreakableObjects"
        addChild(breakablesNode!)
        breakablesTileMap.removeFromParent()
    }
    
    func setupEvents() {
        
        guard let eventsTileMap = childNode(withName: "events")as? SKTileMapNode else {
            return
        }
        
        let eventKey: String = "eventType"
        
        for row in 0..<eventsTileMap.numberOfRows{
            for column in 0..<eventsTileMap.numberOfColumns{
                
                guard let tile = tile(in: eventsTileMap, at: (column, row)) else {continue}
                guard tile.userData?.object(forKey: eventKey) != nil else {continue}
                
                var event: Event
                
                if tile.userData?.value(forKey: eventKey) != nil{
                    let value = tile.userData?.value(forKey: eventKey) as! String
                    switch value{
                        
                    case "needBombsHint":
                        event = NeedBombsEvent()
                        
                    case "needKeyHint":
                        event = NeedKeyEvent()
                        
                    default:
                        event = NeedBombsEvent()
                        
                    }
                    
                    event.position = eventsTileMap.centerOfTile(atColumn: column, row: row)
                    eventsNode!.addChild(event)
                }
            }
        }
        
        eventsNode!.name = "event"
        addChild(eventsNode!)
        eventsTileMap.removeFromParent()
        
    }
    
    func setupLootObjects(){
        guard let lootObjectTileMap = childNode(withName: "lootObjects")as? SKTileMapNode else {
            return
        }
        
        for row in 0..<lootObjectTileMap.numberOfRows{
            for column in 0..<lootObjectTileMap.numberOfColumns{
                
                guard let tile = tile(in: lootObjectTileMap, at: (column, row)) else {continue}
                guard tile.userData?.object(forKey: "lootObject") != nil else {continue}
                
                var lootObject: LootObject
                
                if tile.userData?.value(forKey: "lootObject") != nil{
                    let value = tile.userData?.value(forKey: "lootObject") as! String
                    switch value{
                        
                    case "keyOneLoot":
                        lootObject = Key()
                        print("loot key created")
                        
                        
                    case "bombPile":
                        lootObject = BombPile()
                        print("loot bombpile created")
                        
                        
                    default:
                        lootObject = BombPile()
                        print("loot mistarrryyy")
                        
                    }
                    
                    lootObject.position = lootObjectTileMap.centerOfTile(atColumn: column, row: row)
                    GameScene.updateZPosition(object: lootObject)
                    lootObject.zPosition -= 1
                    lootNode!.addChild(lootObject)
                }
            }
        }
        
        lootNode!.name = "lootObject"
        addChild(lootNode!)
        lootObjectTileMap.removeFromParent()
    }
    
    
    func setupObstaclesPhysics(){
        guard let obstaclesTileMap = childNode(withName: "obstacles")as? SKTileMapNode else {
            return
        }
        
        for row in 0..<obstaclesTileMap.numberOfRows{
            for column in 0..<obstaclesTileMap.numberOfColumns{
                
                guard let tile = tile(in: obstaclesTileMap, at: (column, row)) else {continue}
                guard tile.userData?.object(forKey: "obstacle") != nil || tile.userData?.object(forKey: "door") != nil else {continue}
                
                var obstacle: ObstacleObject?
                var door: Door?
                
                
                if tile.userData?.value(forKey: "obstacle") != nil{
                    let textureName = tile.userData?.value(forKey: "obstacle") as! String
                    
                    obstacle = ObstacleObject(textureName: textureName)
                    
                    
                }else if tile.userData?.value(forKey: "door") != nil{
                    let doorType = tile.userData?.value(forKey: "door") as! String
                    
                    switch doorType {
                    case "door_horizontal":
                        door = DoorHorizontal(textureName: doorType)
                    default:
                        door = DoorVertical(textureName: doorType)
                    }
                    
                }
                
                if obstacle != nil{
                    obstacle!.createPhysicsBody(tile: tile)
                    obstacle!.position = obstaclesTileMap.centerOfTile(atColumn: column, row: row)
                    obstacle?.obstacleTexture.position = obstacle!.position
                    GameScene.updateZPosition(object: obstacle!)
                    obstacle?.obstacleTexture.zPosition = obstacle!.zPosition
                    obstacle?.obstacleTexture.position.y += PlayerSettings.textureOffset
                    
                    obstaclesNode!.addChild(obstacle!)
                    obstaclesNode?.addChild(obstacle!.obstacleTexture)
                    
                }
                
                
                if door != nil{
                    door!.position = obstaclesTileMap.centerOfTile(atColumn: column, row: row)
                    door?.doorTexture.position = door!.position
                    GameScene.updateZPosition(object: door!)
                    door?.doorTexture.zPosition = door!.zPosition
                    door?.doorTexture.position.y += PlayerSettings.textureOffset
                    
                    obstaclesNode!.addChild(door!)
                    obstaclesNode?.addChild(door!.doorTexture)
                }
                
                
                
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
                    
                    if value == "rushEnemy" {
                        enemy = RushEnemy()
                        
                    }
                    else {
                        enemy = TestEnemy()
                    }
                    
                    enemy.position = enemiesMap.centerOfTile(atColumn: column, row: row)
                    enemy.enemyTexture.position = enemy.position
                    enemy.enemyTexture.position.y += PlayerSettings.textureOffset
                    Enemy.enemies.append(enemy)
                    enemyNode!.addChild(enemy)
                    enemyNode!.addChild(enemy.enemyTexture)
                    
                }
            }
        }
        
        enemyNode!.name = "Enemies"
        addChild(enemyNode!)
        
        enemiesMap.removeFromParent()
    }
    
    private func setupPlayer() {
        
        guard let playerMap = childNode(withName: "player") as? SKTileMapNode else {
            return
        }
        
        
        for row in 0..<playerMap.numberOfRows {
            for column in 0..<playerMap.numberOfColumns {
                
                guard let tile = tile(in: playerMap, at: (column, row)) else {
                    continue
                }
                
                if tile.userData?.object(forKey: "player") != nil {
                    
                    player = Player()
                    player!.position = playerMap.centerOfTile(atColumn: column, row: row)
                    player!.playerTexture.position.x = player!.position.x
                    player!.playerTexture.position.y = player!.position.y + PlayerSettings.textureOffset
                }
                
//                if tile.userData?.object(forKey: "playerCutscene") != nil {
//                    
//                    playerCutscene = PlayerCutscene()
//                    playerCutscene!.position = playerMap.centerOfTile(atColumn: column, row: row)
//                    cutsceneRunning = true
//                    addChild(playerCutscene!)
//                    
//                }
            }
        }
        
        if playerCutscene != nil {
            player!.hidePlayer()
        }
        
        addChild(player!)
        
        playerMap.removeFromParent()
        
    }
    
    func tile(in tileMap: SKTileMapNode, at coordinates: tileCoordinates) -> SKTileDefinition?{
        return tileMap.tileDefinition(atColumn: coordinates.column, row: coordinates.row)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        movementManager!.updateJoystickPosition(touches, with: event)
        
        actionManager.checkInput(touches, with: event)
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
        
        if cutsceneRunning {
            updateCutscene()
            return
        }
        
        if GameScene.gameState == .pause{
            return
        }
        
        if !GameScene.canUseTraps{
            
            trapDelayCounter -= 1
            
            if trapDelayCounter <= 0{
                
                GameScene.canUseTraps = true
                trapDelayCounter = 120
                
            }
        }
        
        if isGameOver{
            
            if endLevelCounter < endLevelDelay{
                endLevelCounter += 1
                return
                
            }else{
                
                endLevelCounter = 0
            }
            
            //Deallocate all nodes/children from the old scene
//            self.removeAllChildren()
//            self.removeAllActions()
  //            self.stopScene()
            
            SwiftUICommunicator.instance.setIsGameOver()
            
            //Present a new instance of the scene
//            let restartScene = "GameScene" + String(GameScene.viewController!.currentLevel)
//            GameScene.viewController!.presentScene(restartScene)
//            return
            
        }else{
            
            checkVictory()
            
            //Game logic for updating movement goes in movementManagers update()-method
            movementManager?.update()
            
            //Call update()-method on all enemies
            for enemy in Enemy.enemies {
                if !enemy.isAlive {
                    for i in 0..<Enemy.enemies.count {
                        if i >= Enemy.enemies.count { continue }
                        let checkEnemy = Enemy.enemies[i]
                        if checkEnemy == enemy {
                            Enemy.enemies.remove(at: i)
                        }
                    }
                    enemy.deathParticle()
                    enemy.removeFromParent()
                    enemy.enemyTexture.removeFromParent()
                    
                    return
                }
                enemy.update()
            }
            
            for explosion in ExplosionSettings.explosionsArray{
                explosion.update()
            }
            
            for bomb in Bomb.bombs {
                bomb.update()
            }
            //call update method on Player
            player!.update()
            
            if let lightNode = lightNode {
                lightNode.position = player!.position
            }
            
            if let darknessMaskNode = darknessMaskNode {
                darknessMaskNode.position = player!.position
            }
            
        }
        
        if let currentDialogue = currentDialogue {
            currentDialogue.update()
        }
        
        player?.update()
        
        if databaseUpdateCounter < databaseUpdateLimit{
            databaseUpdateCounter += 1
        }else{
            databaseUpdateCounter = 0
            dataReaderWriter.updateDatabase()
            print("Luca: Database Updated")
        }
        
        
    }
    
    private func updateCutscene() {
        switch UserData.currentLevel {
        case 1:
            playerCutscene?.update()
        default:
            print("updateCutscene() couldnt find the current level")
            player!.showPlayer()
            cutsceneRunning = false
        }
    }
    
    func stopScene() {
        
        backgroundMap = nil
        enemyNode = nil
        explosionsNode = nil
        breakablesNode = nil
        obstaclesNode = nil
        player = nil
        movementManager = nil
        actionManager = nil
        bombsNode = nil
        lootNode = nil
        eventsNode = nil
        currentDialogue = nil
        Bomb.bombs.removeAll()
        Enemy.enemies.removeAll()
        ExplosionSettings.explosionsArray.removeAll()
    }
    
    //checks the current level´s victory condition and, if met, brings the player to the next level.
    func checkVictory(){
        
        if victoryCondition != nil{
            
            switch victoryCondition{
                
            case .killAll:
                
                if Enemy.enemies.count <= 0{
                    
                    UserData.currentLevel += 1
                    dataReaderWriter.saveLocalSaveData()
                    let sceneName = "GameScene\(UserData.currentLevel)"
                    GameScene.viewController!.presentScene(sceneName)
                    print("you killed everyone, you monster.....")
                }
                
            case .openDoor:
                
                guard let obstaclesArray = obstaclesNode?.children else {return}
                for obj in obstaclesArray{
                    
                    if obj is Door {
                        let door = obj as! Door
                        if !door.isOpened {
                            return
                        }
                    }
                }
                
                if PlayerSettingsUI.instance.haveBombs{
                    isDoorOpen = true
                }
                
                
                if isDoorOpen{
                    
                    UserData.currentLevel += 1
                    dataReaderWriter.saveLocalSaveData()
                    let sceneName = "GameScene\(UserData.currentLevel)"
                    GameScene.viewController!.presentScene(sceneName)
                    print("keys found and door opened, good job...")
                    
                }
                
            case .openDoorAndKillAll:
                
                guard let obstaclesArray = obstaclesNode?.children else {return}
                for obj in obstaclesArray{
                    
                    if obj is Door {
                        let door = obj as! Door
                        if !door.isOpened {
                            return
                        }
                    }
                }
                
                if PlayerSettingsUI.instance.haveBombs{
                    isDoorOpen = true
                }
                
                
                if isDoorOpen && Enemy.enemies.count <= 0{
                    
                    UserData.currentLevel += 1
                    dataReaderWriter.saveLocalSaveData()
                    let sceneName = "GameScene\(UserData.currentLevel)"
                    GameScene.viewController!.presentScene(sceneName)
                    print("keys found and door opened, good job...")
                    
                }
                
                
            default:
                print("something went VERY wrong...")
            }
            
        }else {
            print("no victory condition assigned")
        }
    }
    
    static func updateZPosition(object: SKNode) {
        guard let tileSize = tileSize else { return }
        let margin: CGFloat = 10
        object.zPosition = round(object.position.y/(tileSize.height-margin)) * -1
    }
    
    func getPirateInsult(){
        
        let url = URL(string: "https://pirate.monkeyness.com/api/insult")!

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            GameScene.gameOverInsult = String(data: data, encoding: .utf8)!
        }

        task.resume()
    }
    
}

