//
//  BBWebViewController.swift
//  Bela blok
//
//  Created by Josip Zidar on 07/06/2019.
//  Copyright © 2019 Josip Zidar. All rights reserved.
//  https://hr.wikipedia.org/wiki/Belot

import UIKit
import WebKit
import Localize_Swift
class BBWebViewController: BBViewController {

    private var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
        
    }
    private func setupUi() {
        title = "rules".localized()
        webView = WKWebView(frame: view.frame)
        let currentLanguage = Localize.currentLanguage()
        guard let url = URL(string: "https://\(currentLanguage).wikipedia.org/wiki/Belot") else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
        view.addSubview(webView)
    }
}

