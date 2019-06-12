//
//  BBSettingsViewController.swift
//  Bela blok
//
//  Created by Josip Zidar on 07/06/2019.
//  Copyright © 2019 Josip Zidar. All rights reserved.
//

import UIKit

class BBSettingsViewController: BBViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var holderView: BBView!
    enum Settings: Int {
        case language
        case deleteData
        case game
        case contact
        case doublePount
        case activeScreen
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupHolder()
    }
    private func setupUI() {
        title = "settings".localized()
        tableView.registerNib(BBBaseTableViewCell.self)
    }
    private func setupHolder() {
        holderView.initHolderView()
        tableView.layer.cornerRadius = 20
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
            break
        case .doublePount:
            break
            
        }
        let cell = UITableViewCell()
        cell.textLabel?.text = String(indexPath.row)
        return cell
    }
    
    
    
}
