//
//  WorldMapAnimation.swift
//  BomberMan
//
//  Created by Daniel Falkedal on 2022-03-15.
//

import Foundation

class WorldMapAnimation: ObservableObject {
    
    static let instance = WorldMapAnimation()
    
    static let worldMapImageNames = [
    
        "map_level_1_phase_1",  //LEVEL 1
        "map_level_1_phase_2",
        "map_level_1_phase_3",
        "map_level_1_phase_4",
        "map_level_1_phase_5",
        "map_level_1_phase_6",
        "map_level_1_phase_7",
        "map_level_1_phase_8",
        "map_level_1_phase_9",
        "map_level_1_phase_10",
        "map_level_1_phase_11",
        "map_level_1_phase_12",
        "map_level_2_phase_1",  //LEVEL 2
        "map_level_2_phase_2",
        "map_level_2_phase_3",
        "map_level_2_phase_4",
        "map_level_2_phase_5",
        "map_level_2_phase_6",
        "map_level_2_phase_7",
        "map_level_2_phase_8",
        "map_level_2_phase_9",
        "map_level_2_phase_10",
        "map_level_2_phase_11",
        "map_level_2_phase_12",
        "map_level_3_phase_1",  //LEVEL 3
        "map_level_3_phase_2",
        "map_level_3_phase_3",
        "map_level_3_phase_4",
        "map_level_3_phase_5",
        "map_level_3_phase_6",
        "map_level_3_phase_7",
        "map_level_3_phase_8",
        "map_level_3_phase_9",
        "map_level_3_phase_10",
        "map_level_3_phase_11",
        "map_level_3_phase_12",
        "MapRoll",              //LEVEL 4
        "MapRoll",
        "MapRoll",
        "MapRoll",
        "MapRoll",
        "MapRoll",
        "MapRoll",
        "MapRoll",
        "MapRoll",
        "MapRoll",
        "MapRoll",
        "MapRoll",
        "MapRoll",              //LEVEL 5
        "MapRoll",
        "MapRoll",
        "MapRoll",
        "MapRoll",
        "MapRoll",
        "MapRoll",
        "MapRoll",
        "MapRoll",
        "MapRoll",
        "MapRoll",
        "MapRoll",
        "MapRoll",              //LEVEL 6
        "MapRoll",
        "MapRoll",
        "MapRoll",
        "MapRoll",
        "MapRoll",
        "MapRoll",
        "MapRoll",
        "MapRoll",
        "MapRoll",
        "MapRoll",
        "MapRoll",
    
    ]
    
    static let imagesPerLevel: Int = 12
    
    @Published var currentFrameIndex: Int = 0
    
    private init() { /* SINGELTON (PRIVATE CONSTRUCTOR! */ }
        
    func animateWorldMap() {
        
        
        
    }
}
