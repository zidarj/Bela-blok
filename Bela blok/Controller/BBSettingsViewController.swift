//
//  BBSettingsViewController.swift
//  Bela blok
//
//  Created by Josip Zidar on 07/06/2019.
//  Copyright © 2019 Josip Zidar. All rights reserved.
//

import UIKit
import Localize_Swift
class BBSettingsViewController: BBViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var holderView: BBView!
    enum Settings: Int {
        case language
        case deleteData
        case game
        case doublePount
        case activeScreen
        case contact
    }
    
    var settings: BBSettings = {
            if let value = getSettings() {
                return value
            }else {
                return BBSettings()
            }
    }()
    
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
    }
    private func setupUI() {
        title = "settings".localized()
        tableView.registerNib(BBBaseTableViewCell.self)
        tableView.registerNib(BBCheckboxTableViewCell.self)
        
    }
    private func setupHolder() {
        holderView.initHolderView()
        tableView.layer.cornerRadius = 20
    }
    
    func reload() {
        title = "settings".localized()
    }
    

}
extension BBSettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
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
            let cell: BBBaseTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.config(title: "game".localized())
            return cell
        case .language:
            let cell: BBBaseTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.config(title: "language".localized())
            return cell
        case .activeScreen:
            let cell: BBCheckboxTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.config(title: "active_screen".localized())
            cell.isChecked(state: settings.isActiveScreen)
            return cell
        case .doublePount:
            let cell: BBCheckboxTableViewCell = tableView.dequeueReusableCell(for: indexPath)
            cell.config(title: "double_point".localized())
            cell.isChecked(state: settings.isDoublePoint)
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch Settings.init(rawValue: indexPath.row)! {
        case .contact:
            break
        case .deleteData:
            break
        case .game:
            break
        case .language:
            let alertController = UIAlertController(title: "select_language".localized(), message: "\n\n\n\n\n\n", preferredStyle: .alert)
            
            
            alertController.isModalInPopover = true
            let pickerView = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 140))
            alertController.view.addSubview(pickerView)
            pickerView.dataSource = self
            pickerView.delegate = self
            alertController.view.addSubview(pickerView)
            
            let ok = UIAlertAction(title: "ok", style: .default, handler: { (_) in
               let selectedLanguage = pickerView.selectedRow(inComponent: 0)
                if selectedLanguage == 0 {
                    Localize.setCurrentLanguage("hr")
                    self.reload()
                }else {
                    Localize.setCurrentLanguage("en")
                    self.reload()
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
        }
    }
    
    
}
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
