//
//  ViewController.swift
//  Bela blok
//
//  Created by Josip Zidar on 29/05/2019.
//  Copyright © 2019 Josip Zidar. All rights reserved.
//

import UIKit
import Localize_Swift

class BBViewController: UIViewController {
    
    private(set) lazy var settingsBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage(named: "settings"), style: .done, target: self, action: #selector(onTouchSettingsButton))
    }()
    private(set) lazy var rulesBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage(named: "rules"), style: .done, target: self, action: #selector(onTouchRulesButton))
    }()
    private(set) lazy var backBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage(named: "back_icon"), style: .done, target: self, action: #selector(onTouchBackButton))
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
    }
    @objc func onTouchSettingsButton() {
        assertionFailure("Override")
    }
    @objc func onTouchRulesButton() {
        assertionFailure("Override")
    }
    @objc func onTouchBackButton() {
        assertionFailure("Override")
    }
}

