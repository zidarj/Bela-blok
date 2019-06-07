//
//  BBWebViewController.swift
//  Bela blok
//
//  Created by Josip Zidar on 07/06/2019.
//  Copyright © 2019 Josip Zidar. All rights reserved.
//  https://hr.wikipedia.org/wiki/Belot

import UIKit

class BBWebViewController: BBViewController {

   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
        
    }
    private func setupUi() {
        title = "rules".localized()
    }
}

