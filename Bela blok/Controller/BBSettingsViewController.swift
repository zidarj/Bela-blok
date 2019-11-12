//
//  BBSettingsViewController.swift
//  Bela blok
//
//  Created by Josip Zidar on 07/06/2019.
//  Copyright © 2019 Josip Zidar. All rights reserved.
//

import UIKit
import Localize_Swift
protocol BBSettingsViewDelegate: class {
    func onChangeLanguage()
}

class BBSettingsViewController: BBViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var holderView: BBView!
    
    //MARK: - Enum
    private enum Settings: Int {
        case language
        case deleteData
        case game
        case doublePount
        case activeScreen
        case contact
        case defaultSettings
    }
    
    //MARK: - Variables
    private var settings: BBSettings = {
        if let value = getSettings() {
            return value
        }else {
            return BBSettings()
        }
    }()
    
    var delegate: BBSettingsViewDelegate?
    
    //MARK: - LifeCycle app
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupHolder()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        let test: BBSettings = getSettings() ?? BBSettings()
        if test != settings {
            storeSettings(settings: settings)
        }
        NotificationCenter.default.post(.init(name: .ScoreLabel))
    }
    
    //MARK: - Functions
    private func setupUI() {
        title = "settings".localized()
        tableView.registerNib(BBBaseTableViewCell.self)
        tableView.registerNib(BBCheckboxTableViewCell.self)
        tableView.registerNib(BBGameTableViewCell.self)
        tableView.isScrollEnabled = false
    }
    
    private func setupHolder() {
        holderView.initHolderView()
        tableView.layer.cornerRadius = 20
    }
    
    private func storeGame(textField: UITextField) {
        if textField.text!.isEmpty {
            return
        }
        guard let number = Int(textField.text!) else { return }
        if number <= 1001 && number >= 1 {
            settings.game = number
        }else {
            return
        }
    }
    
    private func reload() {
        title = "settings".localized()
    }
    
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension BBSettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Settings.init(rawValue: indexPath.row)! {
        case .contact:
            let cell: BBBaseTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.config(title: "contact".localized())
            return cell
        case .deleteData:
            let cell: BBBaseTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.config(title: "delete_data".localized())
            return cell
        case .game:
            let cell: BBGameTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.config(title: "game".localized(), gameNumber: settings.game)
            return cell
        case .language:
            let cell: BBBaseTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.config(title: "language".localized())
            return cell
        case .activeScreen:
            let cell: BBCheckboxTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.config(title: "active_screen".localized())
            UIApplication.shared.isIdleTimerDisabled = settings.isActiveScreen
            cell.isChecked(state: settings.isActiveScreen)
            return cell
        case .doublePount:
            let cell: BBCheckboxTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.config(title: "double_point".localized())
            cell.isChecked(state: settings.isDoublePoint)
            return cell
        case .defaultSettings:
            let cell: BBBaseTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.config(title: "default_settings".localized())
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch Settings.init(rawValue: indexPath.row)! {
        case .contact:
            break
        case .deleteData:
            NotificationCenter.default.post(name: .deleteData, object: nil)
            navigationController?.popViewController(animated: true)
        case .game:
            let alertController = UIAlertController(title: "game".localized().uppercased(), message: "", preferredStyle: .alert)
            alertController.addTextField { (textField) in
                textField.text = "\(self.settings.game)"
                textField.keyboardType = .numberPad
            }
            let submitAction = UIAlertAction(title: "submit".localized().uppercased(), style: .default) { [unowned alertController] _ in
                let answer = alertController.textFields![0]
                self.storeGame(textField: answer)
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            alertController.addAction(submitAction)
            present(alertController, animated: true)
        case .language:
            let alertController = UIAlertController(title: "select_language".localized(), message: "\n\n\n\n\n\n", preferredStyle: .alert)
            
            
            alertController.isModalInPopover = true
            let pickerView = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 140))
            alertController.view.addSubview(pickerView)
            pickerView.dataSource = self
            pickerView.delegate = self
            alertController.view.addSubview(pickerView)
            
            let ok = UIAlertAction(title: "ok".localized(), style: .default, handler: { (_) in
                let selectedLanguage = pickerView.selectedRow(inComponent: 0)
                if selectedLanguage == 0 {
                    Localize.setCurrentLanguage("hr")
                    self.reload()
                }else {
                    Localize.setCurrentLanguage("en")
                    self.reload()
                }
                if let del = self.delegate {
                    del.onChangeLanguage()
                }
                self.tableView.reloadData()
            })
            let cancel = UIAlertAction(title: "cancel", style: .default, handler: nil)
            alertController.addAction(ok)
            alertController.addAction(cancel)
            self.present(alertController, animated: true, completion: nil)
        case .doublePount:
            settings.isDoublePoint = settings.isDoublePoint ? false : true
            tableView.reloadRows(at: [indexPath], with: .automatic)
        case .activeScreen:
            settings.isActiveScreen = settings.isActiveScreen ? false : true
            tableView.reloadRows(at: [indexPath], with: .automatic)
        case .defaultSettings:
            settings = defaultSettings()
            self.tableView.reloadData()
        }
    }
}

//MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension BBSettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if row == 0 {
            return "croatia".localized()
        }else {
            return "english".localized()
        }
    }
    
}
