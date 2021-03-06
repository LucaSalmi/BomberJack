//
//  Types.swift
//  BomberMan
//
//  Created by Luca Salmi, Daniel Falkedal, Calle Höglund, Hampus Brandtman on 2022-02-15.
//

import Foundation

enum Direction: Int{
    case forward = 0, backward, left, right
}

enum VictoryConditions: Int{
    
    case openDoor = 0, killAll, openDoorAndKillAll, testCond
}

typealias tileCoordinates = (column: Int, row: Int)

struct PhysicsCategory{
    
    static let None: UInt32 = 0
    static let All: UInt32 = 0xFFFFFFFF
    static let Edge: UInt32 = 0b1
    static let Player: UInt32 = 0b10
    static let Enemy: UInt32 = 0b100
    static let Bomb: UInt32 = 0b1000
    static let Breakable: UInt32 = 0b10000
    static let Obstacle: UInt32 = 0b100000
    static let Explosion: UInt32 = 0b1000000
    static let InactiveBomb: UInt32 = 0b10000000
    static let TrapBomb: UInt32 = 0b100000000
    static let Loot: UInt32 = 0b1000000000
    static let Door: UInt32 = 0b10000000000
    static let Event: UInt32 = 0b100000000000
    
}

enum GameState: Int{
    
    case mainMenu = 0,  start, play, win, lose, pause
}

enum ExplosionPosition: Int{
    
    case center = 0, right, left, top, bottom
    
}
