//
//  BBNewGameViewController.swift
//  Bela blok
//
//  Created by Josip Zidar on 01/07/2019.
//  Copyright © 2019 Josip Zidar. All rights reserved.
//

import UIKit
protocol BBNewGameDelegate: class {
     func endGame(game:BBGame)
}
class BBNewGameViewController: BBViewController {
    weak var delegate: BBNewGameDelegate? = nil
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func congig(delegate: BBNewGameDelegate)
    {
        self.delegate = delegate
    }

}
