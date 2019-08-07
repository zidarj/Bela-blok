//
//  StoreInfo.swift
//  Bela blok
//
//  Created by Josip Zidar on 23/07/2019.
//  Copyright © 2019 Josip Zidar. All rights reserved.
//

import Foundation

struct BBStoreInfo {
    var miResult: Int
    var viResult: Int
    
    init(miResult: Int, viResult: Int) {
        self.miResult = miResult
        self.viResult = viResult
    }
    init?(dictionary : [String:Any]) {
        guard let miResult = dictionary["miResult"] as? Int,
            let viResult = dictionary["viResult"] as? Int else { return nil }
        self.init(miResult: miResult, viResult: viResult)
    }
    var propertyListRepresentation : [String:Any] {
        return ["miResult" : miResult, "viResult" : viResult]
    }
}
func storeInfo(settings: BBStoreInfo) {
    let propertylistSettings = settings.propertyListRepresentation
    UserDefaults.standard.set(propertylistSettings, forKey: "BBStoreInfo")
}

func getInfo() -> BBStoreInfo? {
    if let propertylistSettings = UserDefaults.standard.dictionary(forKey: "BBStoreInfo") {
        return BBStoreInfo.init(dictionary: propertylistSettings)
    }
    return nil
}
