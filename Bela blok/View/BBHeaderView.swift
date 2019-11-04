//
//  BBHeaderView.swift
//  Bela blok
//
//  Created by Josip Zidar on 01/07/2019.
//  Copyright © 2019 Josip Zidar. All rights reserved.
//

import UIKit

class BBHeaderView: UIView {
    @IBOutlet private weak var miLabel: UILabel!
    @IBOutlet private weak var viLabel: UILabel!
    @IBOutlet private weak var separatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        miLabel.text = "mi".localized().uppercased()
        viLabel.text = "vi".localized().uppercased()
        miLabel.textColor = UIColor.blackColour
        viLabel.textColor = UIColor.blackColour
        separatorView.backgroundColor = UIColor.redColor
    }
    

}
