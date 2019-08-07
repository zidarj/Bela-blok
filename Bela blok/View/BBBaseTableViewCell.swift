//
//  BBBaseTableViewCell.swift
//  Bela blok
//
//  Created by Josip Zidar on 11/06/2019.
//  Copyright © 2019 Josip Zidar. All rights reserved.
//

import UIKit

class BBBaseTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var separatorView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.text = ""
    }

    func config(title: String) {
        titleLabel.text = title
    }
    
}
