//
//  Extensions.swift
//  BomberMan
//
//  Created by Luca Salmi on 2022-02-18.
//

import Foundation
import SpriteKit

extension SKTexture {
  convenience init(pixelImageNamed: String) {
    self.init(imageNamed: pixelImageNamed)
    self.filteringMode = .nearest
  }
}
