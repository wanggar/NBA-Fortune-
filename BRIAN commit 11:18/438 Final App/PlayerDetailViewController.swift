//
//  ViewController.swift
//  438 Final App
//
//  Created by BrianLin on 11/11/18.
//  Copyright © 2018 BrianLin. All rights reserved.
//

import UIKit

class PlayerDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var playerName: UIButton!
    @IBOutlet weak var playerImage: UIImageView!
    
    @IBOutlet weak var statsView: UITableView!
    var gamelogs: [MSFData.PlayerGamelog]?
    var playerData: [MSFData.Player] = []
    var playerId: Int? = 9369
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let gamelogs = gamelogs {
            return gamelogs.count
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! StatsViewCell
        
        cell.awayTeamLabel.text = gamelogs?[indexPath.row].game.awayTeamAbbreviation
        cell.homeTeamLabel.text = gamelogs?[indexPath.row].game.homeTeamAbbreviation
        cell.dateLabel.text = gamelogs?[indexPath.row].game.startTime
        cell.pointsLabel.text = String(gamelogs?[indexPath.row].stats.offense.points ?? -1)
        cell.assistsLabel.text = String(gamelogs?[indexPath.row].stats.offense.assists ?? -1)
        cell.reboundsLabel.text = String(gamelogs?[indexPath.row].stats.rebounds.rebounds ?? -1)
        cell.fieldGoalLabel.text = String(gamelogs?[indexPath.row].stats.fieldGoals.fieldGoal2PointMadePerGame ?? -1)

        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statsView.dataSource = self
        statsView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        let nib = UINib(nibName: "DetailStatsView", bundle: nil)
        
        statsView.register(nib, forCellReuseIdentifier: "LabelCell")
        
        guard let playerId = playerId else {
            return
        }
        DataModel.getGamelogForPlayer(playerId: playerId) {
            gamelogs in
           self.gamelogs = gamelogs
            self.statsView.reloadData()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

