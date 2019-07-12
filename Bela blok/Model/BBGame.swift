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
    var miZvanje: Int
    var viScore: Int
    var viZvanje: Int
    
    init(miScore: Int, miZvanje: Int, viScore: Int, viZvanje: Int) {
        self.miScore = miScore
        self.miZvanje = miZvanje
        self.viScore = viScore
        self.viZvanje = viZvanje
        
    }
    
    func miResult() -> Int {
        return miZvanje + miScore
    }
    
    func viResult() -> Int {
        return viZvanje + viScore
    }
}
