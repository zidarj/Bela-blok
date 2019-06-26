//
//  BBCheckboxTableViewCell.swift
//  Bela blok
//
//  Created by Josip Zidar on 12/06/2019.
//  Copyright © 2019 Josip Zidar. All rights reserved.
//

import UIKit

class BBCheckboxTableViewCell: UITableViewCell {

    @IBOutlet weak var checkboxImageView: UIImageView!
    @IBOutlet weak var checkBoxView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        checkBoxView.layer.cornerRadius = 3
        checkBoxView.layer.borderWidth = 1
        checkBoxView.layer.borderColor = UIColor.black.cgColor
        titleLabel.text = ""
        checkBoxView.backgroundColor = .white
        checkboxImageView.backgroundColor = .white
    }

    func config(title: String) {
        titleLabel.text = title
    }
    func isChecked(state: Bool) {
        checkboxImageView.image = state ? UIImage(named: "check") : nil
    }
    
}
