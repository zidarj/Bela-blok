//
//  BBView.swift
//  Bela blok
//
//  Created by Josip Zidar on 12/06/2019.
//  Copyright © 2019 Josip Zidar. All rights reserved.
//

import UIKit

class BBView: UIView {

    
    func initHolderView() {
        dropShadow()
        self.layer.cornerRadius = 20
        //self.layer.borderColor = UIColor.black.cgColor
        //self.layer.borderWidth = 1
        
    }
    
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    func dropShadow() {
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero
        layer.shadowRadius = 20
    }
}
