//
//  BBHeaderView.swift
//  Bela blok
//
//  Created by Josip Zidar on 01/07/2019.
//  Copyright © 2019 Josip Zidar. All rights reserved.
//

import UIKit

class BBHeaderView: UIView {
    @IBOutlet weak var miLabel: UILabel!
    @IBOutlet weak var viLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        miLabel.text = "mi".localized().uppercased()
        viLabel.text = "vi".localized().uppercased()
    }

}
