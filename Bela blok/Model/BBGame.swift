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
    
    init?(dictionary : [String:Int]) {
        guard let miScore = dictionary["miScore"],
            let miZvanje = dictionary["miZvanje"],
            let viScore = dictionary["viScore"],
            let viZvanje = dictionary["viZvanje"] else { return nil }
        self.init(miScore: miScore, miZvanje: miZvanje, viScore: viScore, viZvanje: viZvanje)
    }
    var propertyListRepresentation : [String:Any] {
        return ["miScore" : miScore, "miZvanje" : miZvanje, "viScore" : viScore, "viZvanje" : viZvanje]
    }
    func miResult() -> Int {
        return miZvanje + miScore
    }
    
    func viResult() -> Int {
        return viZvanje + viScore
    }
}
func storeGames() {
    let propertylistSongs = games.map{ $0.propertyListRepresentation }
    UserDefaults.standard.set(propertylistSongs, forKey: "storeGame")
}

func getGames() {
    if let propertylistSongs = UserDefaults.standard.array(forKey: "storeGame") as? [[String:Int]] {
        games = propertylistSongs.compactMap{ BBGame(dictionary: $0) }
    }
}
func removeGames() {
    UserDefaults.standard.removeObject(forKey: "storeGame")
}
