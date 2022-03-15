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
        "map_level_1_phase_1",  //LEVEL 4
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
        "map_level_2_phase_1",  //LEVEL 5
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
        "map_level_3_phase_1",  //LEVEL 6
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

    
    ]
    static let imagesPerLevel: Int = 12
    static let animationStartDelay: Double = 0.75
    static let animationDelay: Double = 0.15
    
    @Published var currentFrameIndex: Int = 0
    
    private init() { /* SINGELTON (PRIVATE CONSTRUCTOR! */ }
        
    func animateWorldMap() {
 
        //Level 1 = 0, Level 2 = 12, Level 3 = 24, etc....
        let startIndex: Int = (UserData.lastSavedLevel-1) * WorldMapAnimation.imagesPerLevel
        
        if startIndex >= (WorldMapAnimation.worldMapImageNames.count - WorldMapAnimation.imagesPerLevel) {
            WorldMapAnimation.instance.currentFrameIndex = WorldMapAnimation.worldMapImageNames.count-1
            print("DANNE: MAX INDEX RETURN = \(WorldMapAnimation.instance.currentFrameIndex) | LAST FRAME INDEX = \(WorldMapAnimation.worldMapImageNames.count-1)")
            return
        }
        
        WorldMapAnimation.instance.currentFrameIndex = startIndex
        
        //Animation start delay
        
        DispatchQueue.main.asyncAfter(deadline: .now() + WorldMapAnimation.animationStartDelay){
            
            //Iterative function
            WorldMapAnimation.instance.animationLoop(startImageIndex: startIndex)
        }
        
    }
    
    private func animationLoop(startImageIndex: Int, loopIndex: Int = 0) {
        
        //print("DANNE: Current loop index = \(loopIndex)")
        
        if loopIndex > WorldMapAnimation.imagesPerLevel-1 { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + WorldMapAnimation.animationDelay){
            
            WorldMapAnimation.instance.currentFrameIndex = startImageIndex + loopIndex
            //print("DANNE: Current image index = \(startImageIndex+loopIndex)")
            
            WorldMapAnimation.instance.animationLoop(startImageIndex: startImageIndex, loopIndex: loopIndex+1)
            
        }
    }
}
