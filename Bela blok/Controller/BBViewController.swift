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
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation { return .slide }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { return .portrait }
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    var statusBarStyle: UIStatusBarStyle = .lightContent {
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    private(set) lazy var settingsBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage(named: "settings"), style: .done, target: self, action: #selector(onTouchSettingsButton))
    }()
    private(set) lazy var rulesBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage(named: "rules"), style: .done, target: self, action: #selector(onTouchRulesButton))
    }()
    private(set) lazy var backBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage(named: "back_button"), style: .done, target: self, action: #selector(onTouchBackButton))
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        navigationItem.hidesBackButton = true
        if navigationController?.viewControllers.count ?? 0 > 1 {
            navigationItem.leftBarButtonItems = [backBarButtonItem]
        }
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    @objc func onTouchSettingsButton() {
        assertionFailure("Override")
    }
    @objc func onTouchRulesButton() {
        assertionFailure("Override")
    }
    @objc func onTouchBackButton() {
        navigationController?.popViewController(animated: true)
    }
    deinit {
        print("Deinit: \(self)")
    }
    func dismissKeyboard() {
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKey))
        view.addGestureRecognizer(tap)
    }
     @objc private func dismissKey(){
        view.endEditing(true)
    }
   
}
extension BBViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let navigation = navigationController else {
            return false
        }
        return navigation.viewControllers.count > 1
    }
}
extension UIView {
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    func dropShadow() {
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero
        layer.shadowRadius = 20
    }
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
   
    static let redColor: UIColor = UIColor(hexString: "#A8201A") //UIColor(hexString: "#A40606")
    static let blackColour: UIColor = UIColor(hexString: "#130303") // UIColor(hexString: "#130303")
    static let whiteApricot: UIColor = UIColor(hexString: "#EAEAEA") // UIColor(hexString: "#FFCDBC")
    static let brownColour: UIColor = UIColor(hexString: "#143642") // UIColor(hexString: "#2D080A")
    static let mangoColour: UIColor = UIColor(hexString: "#E6AA68") // UIColor(hexString: "#F5853F")
}
