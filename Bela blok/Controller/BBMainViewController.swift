//
//  BBMainViewController.swift
//  Bela blok
//
//  Created by Josip Zidar on 07/06/2019.
//  Copyright © 2019 Josip Zidar. All rights reserved.
//

import UIKit
import GoogleMobileAds
extension Notification.Name {
    static let ScoreLabel = Notification.Name("ScoreLable")
    static let deleteData = Notification.Name("DeleteData")
}
//MARk: - Global variables
var games = [BBGame]()
var finalResultMi = 0
var finalResultVi = 0

class BBMainViewController: BBViewController {
    //MARK: - IBOutlets
    @IBOutlet private weak var holderView: BBView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var gameRule: UILabel!
    @IBOutlet private weak var miLabelScore: UILabel!
    @IBOutlet private weak var viLabelScore: UILabel!
    @IBOutlet private weak var miScore: UILabel!
    @IBOutlet private weak var viScore: UILabel!
    @IBOutlet weak var scoreView: UIView!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var banerView: GADBannerView!
    //MARK: - Variables
    private var header: BBHeaderView!
    private var settings: BBSettings?
    
    //MARK: - LifeCycle app
    override func viewDidLoad() {
        super.viewDidLoad()
        checkStoreInfo()
        setupUI()
        setScoreLabels()
        setupScoreView()
        setupNotification()
        banerView.adUnitID = "ca-app-pub-3228246244771060/8766447581"//ca-app-pub-3940256099942544/2934735716
        banerView.rootViewController = self
        banerView.load(GADRequest())
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        let info = BBStoreInfo(miResult: finalResultMi, viResult: finalResultVi)
        storeInfo(settings: info)
        storeGames()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        title = "bela_blok".localized()
        if tableView.contentSize.height > holderView.frame.height {
            tableView.scrollToRow(at: IndexPath(row: games.count - 1, section: 0), at: .none, animated: false)
        }
    }
    //MARK: - Functions
    private func setupUI() {
        navigationItem.leftBarButtonItems = [rulesBarButtonItem]
        navigationItem.rightBarButtonItems = [settingsBarButtonItem]
        statusBarStyle = .lightContent
        tableView.layer.cornerRadius = 20
        holderView.initHolderView()
        tableView.registerNib(BBGameMainTableViewCell.self)
        scoreView.backgroundColor = .mangoColour
        newGameButton.backgroundColor = .redColor
        newGameButton.tintColor = .whiteApricot
        newGameButton.setTitle("newGame".localized(), for: .normal)
        miLabelScore.textColor = .brownColour
        viLabelScore.textColor = .brownColour
        miScore.textColor = .brownColour
        viScore.textColor = .brownColour
        gameRule.textColor = .brownColour
        gameRule.font = UIFont.boldSystemFont(ofSize: 17)
    }
    
    fileprivate func checkStoreInfo() {
        if let info = getStoredInfo() {
            self.miScore.text = "score".localized() + "\(info.miResult)"
            self.viScore.text = "score".localized() + "\(info.viResult)"
            finalResultVi = info.viResult
            finalResultMi = info.miResult
            getGames()
        }
    }
    
    fileprivate func setupNotification() {
        NotificationCenter.default.addObserver(forName: .ScoreLabel, object: nil, queue: nil) { [weak self] (_) in
            guard let welf = self else { return }
            welf.setScoreLabels()
        }
        NotificationCenter.default.addObserver(forName: .deleteData, object: nil, queue: nil) { [weak self](_) in
            guard let welf = self else { return }
            finalResultVi = 0
            finalResultMi = 0
            welf.viScore.text = "score".localized() + "\(finalResultVi)"
            welf.miScore.text = "score".localized() + "\(finalResultMi)"
            games.removeAll()
            removeGames()
            removeStoreInfo()
            welf.setupScoreView()
        }
    }
    
    private func setupScoreView() {
        var miResult = 0
        var viResult = 0
        games.forEach { (game) in
            miResult += game.miResult()
            viResult += game.viResult()
        }
        if miResult >= settings?.game ?? 1001 || viResult >= settings?.game ?? 1001 {
            if miResult == viResult {
                print("finalRound")
                return
            }else if miResult > viResult {
                finalResultMi += (settings!.game / 2) > viResult && settings!.isDoublePoint ? 2 : 1
                miScore.text = "score".localized() + "\(finalResultMi)"
            }else if viResult > miResult {
                finalResultVi += (settings!.game / 2) > miResult && settings!.isDoublePoint ? 2 : 1
                viScore.text = "score".localized() + "\(finalResultVi)"
            }
            miLabelScore.text = "0"
            viLabelScore.text = "0"
            games.removeAll()
            tableView.reloadData()
            return
        }
        miLabelScore.text = "\(miResult)"
        viLabelScore.text = "\(viResult)"
        tableView.reloadData()
    }
    
    private func setScoreLabels() {
        if let sett = getSettings() {
            settings = sett
        }else {
            settings = BBSettings()
        }
        gameRule.text = String(describing: settings!.game)
    }
    
    private func deleteGame(with index: Int) {
        games.remove(at: index)
        setupScoreView()
    }
    //MARK: - Override Actions
    override func onTouchRulesButton() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "BBWebViewController") as? BBWebViewController else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
    override func onTouchSettingsButton() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyBoard.instantiateViewController(withIdentifier: "BBSettingsViewController") as? BBSettingsViewController else { return }
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    //MARK: - IBActions
    @IBAction func onTouchNewGameButton(_ sender: Any) {
        let vc: BBNewGameViewController = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BBNewGameViewController") as? BBNewGameViewController)!
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
//MARK: - UITableViewDelegate, UITableViewDataSource
extension BBMainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BBGameMainTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let score = games[indexPath.row]
        cell.config(game: score)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        header = .fromNib()
        return self.header
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (_, _, completionHandler) in
            self.deleteGame(with: indexPath.row)
            completionHandler(true)
        }
        deleteAction.image = UIImage(named: "trash")
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return configuration
    }
}
//MARK: - BBNewGameDelegate
extension BBMainViewController: BBNewGameDelegate {
    func endGame(game: BBGame) {
        games.append(game)
        setupScoreView()
    }
}
//MARK: - BBSettingsViewDelegate
extension BBMainViewController: BBSettingsViewDelegate {
    func onChangeLanguage() {
        setupScoreView()
        miScore.text = "score".localized() + "\(finalResultMi)"
        viScore.text = "score".localized() + "\(finalResultVi)"
        newGameButton.setTitle("newGame".localized(), for: .normal)
        tableView.reloadData()
    }
}
