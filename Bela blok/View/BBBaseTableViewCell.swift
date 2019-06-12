//
//  BBBaseTableViewCell.swift
//  Bela blok
//
//  Created by Josip Zidar on 11/06/2019.
//  Copyright © 2019 Josip Zidar. All rights reserved.
//

import UIKit

class BBBaseTableViewCell: UITableViewCell {

    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var separatorView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.text = ""
    }

    func config(title: String) {
        titleLabel.text = title
    }
    
}
