//
//  BBNewGameViewController.swift
//  Bela blok
//
//  Created by Josip Zidar on 01/07/2019.
//  Copyright © 2019 Josip Zidar. All rights reserved.
//

import UIKit
//MARK: - BBNewGameDelegate
protocol BBNewGameDelegate: class {
    func endGame(game:BBGame)
}

class BBNewGameViewController: BBViewController {
    //MARK: - IBOutlets
    @IBOutlet private weak var topStackView: UIStackView!
    @IBOutlet private weak var miTextField: UITextField!
    @IBOutlet private weak var viTextField: UITextField!
    @IBOutlet private weak var miZvanjeTextField: UITextField!
    @IBOutlet private weak var endGameButton: UIButton!
    @IBOutlet private weak var viZvanjeTextField: UITextField!
    @IBOutlet weak var igraLabel: UILabel!
    @IBOutlet weak var zvanjeLabel: UILabel!
    @IBOutlet weak var viLabel: UILabel!
    @IBOutlet weak var miLabel: UILabel!
    
    //MARK: - Variables
    weak var delegate: BBNewGameDelegate? = nil
    
    //MARK: - LifeCycle app
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
        dismissKeyboard()
    }
    
    //MARK: - Config
    func config(delegate: BBNewGameDelegate)
    {
        self.delegate = delegate
    }
    
    //MARK: - Functions
    private func setupUi() {
        let textFields = [viTextField,miTextField,miZvanjeTextField,viZvanjeTextField]
        textFields.forEach { (textField) in
            textField?.keyboardType  = .numberPad
        }
        viTextField.delegate = self
        miTextField.delegate = self
        topStackView.arrangedSubviews.forEach { (view) in
            view.backgroundColor = .redColor
        }
        endGameButton.backgroundColor = .redColor
        endGameButton.tintColor = .whiteApricot
        endGameButton.setTitle("done".localized(), for: .normal)
        endGameButton.isEnabled = false
        miLabel.text = "mi".localized()
        viLabel.text = "vi".localized()
        igraLabel.text = "points".localized()
        zvanjeLabel.text = "contract".localized()
        
    }
    
    //MARK: - Actions
    @IBAction func onTouchEndGameButton(_ sender: Any) {
        guard let miScore = Int(miTextField.text!), let viScore = Int(viTextField.text!) else { return }
        let miZvanje = Int(miZvanjeTextField.text ?? "0") ?? 0
        let viZvanje = Int(viZvanjeTextField.text ?? "0") ?? 0
        if miScore == 0 && viScore == 0 {
            miTextField.becomeFirstResponder()
            return
        }
        let game = BBGame(miScore: miScore, miZvanje: miZvanje, viScore: viScore, viZvanje: viZvanje)
        delegate?.endGame(game: game)
        navigationController?.popViewController(animated: true)
        
    }
}
//MARK: - UITextFieldDelegate
extension BBNewGameViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text!.isEmpty {
            textField.text = "0"
        }
        if miTextField.text!.isEmpty || viTextField.text!.isEmpty {
            endGameButton.isEnabled = false
        } else {
            endGameButton.isEnabled = true
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
