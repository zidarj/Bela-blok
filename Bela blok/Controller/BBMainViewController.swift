//
//  BBMainViewController.swift
//  Bela blok
//
//  Created by Josip Zidar on 07/06/2019.
//  Copyright © 2019 Josip Zidar. All rights reserved.
//

import UIKit

class BBMainViewController: BBViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    
    private func setupUI() {
        title = "bela_blok".localized()
        navigationItem.leftBarButtonItems = [rulesBarButtonItem]
        navigationItem.rightBarButtonItems = [settingsBarButtonItem]
        statusBarStyle = .lightContent
    }

    override func onTouchRulesButton() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "BBWebViewController") as? BBWebViewController, let url = URL(string: "https://google.com") else { return }
        //vc.url = URLRequest(url: url)
        navigationController?.pushViewController(vc, animated: true)
    }
    override func onTouchSettingsButton() {
        
    }

}
