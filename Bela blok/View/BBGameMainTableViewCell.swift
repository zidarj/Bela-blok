//
//  BBGameMainTableViewCell.swift
//  Bela blok
//
//  Created by Josip Zidar on 01/07/2019.
//  Copyright © 2019 Josip Zidar. All rights reserved.
//

import UIKit

class BBGameMainTableViewCell: UITableViewCell {
    @IBOutlet private weak var miLabel: UILabel!
    @IBOutlet private weak var viLabel: UILabel!
    @IBOutlet private weak var separatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        miLabel.textColor = .blackColour
        viLabel.textColor = .blackColour
        separatorView.backgroundColor = .brownColour
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func config(game: BBGame) {
        let miResult = String(game.miScore + game.miZvanje)
        miLabel.text = miResult
        let viResult = String(game.viScore + game.viZvanje)
        viLabel.text = viResult
    }
}
