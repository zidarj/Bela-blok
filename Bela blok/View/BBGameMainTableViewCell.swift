//
//  BBGameMainTableViewCell.swift
//  Bela blok
//
//  Created by Josip Zidar on 01/07/2019.
//  Copyright © 2019 Josip Zidar. All rights reserved.
//

import UIKit

class BBGameMainTableViewCell: UITableViewCell {
    @IBOutlet weak var miLabel: UILabel!
    @IBOutlet weak var viLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func config(miScore: Int, viScore: Int) {
        miLabel.text = "\(miScore)"
        viLabel.text = String(viScore)
    }
}
