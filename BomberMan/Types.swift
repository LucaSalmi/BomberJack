//
//  Types.swift
//  BomberMan
//
//  Created by Luca Salmi on 2022-02-15.
//

import Foundation

enum Direction: Int{
    case forward = 0, backward, left, right
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
}
