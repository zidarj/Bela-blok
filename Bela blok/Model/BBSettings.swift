//
//  BBSettings.swift
//  Bela blok
//
//  Created by Josip Zidar on 12/06/2019.
//  Copyright © 2019 Josip Zidar. All rights reserved.
//

import Foundation

struct BBSettings: Equatable  {
    
    var isActiveScreen: Bool = false
    var isDoublePoint: Bool = true
    var game: Int = 1001
    
    init(isActive: Bool = false , isDouble: Bool = true, game: Int = 1001) {
        self.isActiveScreen = isActive
        self.isDoublePoint = isDouble
        self.game = game
    }
    init?(dictionary : [String:Any]) {
        guard let isActiveScreen = dictionary["isActiveScreen"] as? Bool,
            let isDoublePoint = dictionary["isDoublePoint"] as? Bool,
            let game = dictionary["game"] as? Int else { return nil }
        self.init(isActive: isActiveScreen, isDouble: isDoublePoint, game: game)
    }
    var propertyListRepresentation : [String:Any] {
        return ["isActiveScreen" : isActiveScreen, "isDoublePoint" : isDoublePoint, "game" : game]
    }
}
func storeSettings(settings: BBSettings) {
    let propertylistSettings = settings.propertyListRepresentation
    UserDefaults.standard.set(propertylistSettings, forKey: "BBSettings")
}

func getSettings() -> BBSettings? {
    if let propertylistSettings = UserDefaults.standard.dictionary(forKey: "BBSettings") {
        return BBSettings.init(dictionary: propertylistSettings)
    }
    return nil
}
func defaultSettings() -> BBSettings {
    if UserDefaults.standard.dictionary(forKey: "BBSettings") != nil {
    UserDefaults.standard.removeObject(forKey: "BBSettings")
    }
    return BBSettings()
}
