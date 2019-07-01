//
//  BBGame.swift
//  Bela blok
//
//  Created by Josip Zidar on 01/07/2019.
//  Copyright © 2019 Josip Zidar. All rights reserved.
//

import Foundation

struct BBGame: Equatable {
    var miScore: Int
    var viScore: Int
    
    init(miScore: Int, viScore: Int) {
        self.miScore = miScore
        self.viScore = viScore
    }
}
