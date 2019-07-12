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
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var miTextField: UITextField!
    @IBOutlet weak var viTextField: UITextField!
    @IBOutlet weak var miZvanjeTextField: UITextField!
    
    @IBOutlet weak var endGameButton: UIButton!
    @IBOutlet weak var viZvanjeTextField: UITextField!
    weak var delegate: BBNewGameDelegate? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
        dismissKeyboard()
    }
    
    func congig(delegate: BBNewGameDelegate)
    {
        self.delegate = delegate
    }
    private func setupUi() {
        let buttons = [viTextField,miTextField,miZvanjeTextField,viZvanjeTextField]
        buttons.forEach { (textField) in
            textField?.keyboardType  = .numberPad
        }
        viTextField.delegate = self
        miTextField.delegate = self
    }
    @IBAction func onTouchEndGameButton(_ sender: Any) {
        guard let miScore = Int(miTextField.text!), let viScore = Int(viTextField.text!) else { return }
        let miZvanje = Int(miZvanjeTextField.text ?? "0") ?? 0
        let viZvanje = Int(viZvanjeTextField.text ?? "0") ?? 0
        
        let game = BBGame(miScore: miScore, miZvanje: miZvanje, viScore: viScore, viZvanje: viZvanje)
        delegate?.endGame(game: game)
        navigationController?.popViewController(animated: true)
        
    }
}
extension BBNewGameViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text!.isEmpty {
            textField.text = "0"
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == miTextField {
            if string.isEmpty {
                let resultNumb: String = String((textField.text?.dropLast())!)
                viTextField.text = "\(calculateResult(result: Int(resultNumb) ?? 0))"
            }else {
                viTextField.text = "\(calculateResult(result: Int(textField.text! + string) ?? 0))"
            }
        }else if textField == viTextField{
            if string.isEmpty {
                let resultNumb: String = String((textField.text?.dropLast())!)
                miTextField.text = "\(calculateResult(result: Int(resultNumb) ?? 0))"
            }else {
                miTextField.text = "\(calculateResult(result: Int(textField.text! + string) ?? 0))"
            }
        }
        return true
    }
    private func calculateResult(result: Int) -> Int {
        let game = 162
        if result >= game {
            return 0
        }
        return game - result
    }
}
