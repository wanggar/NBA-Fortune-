//
//  DataModel.swift
//  NBA Player
//
//  Created by Shane Whong on 11/8/18.
//  Copyright © 2018 Shane Wang. All rights reserved.
//

import Foundation

class Team {
    let id: Int!
    let city: String!
    let name: String!
    let abbreviation: String!
    var players: [MSFData.Player]
    init(team: MSFData.Team) {
        id = team.id
        city = team.city ?? ""
        name = team.name ?? ""
        abbreviation = team.abbreviation
        players = []
    }
}


class DataModel {
    private(set) var teams: [Team] = []
    private var playerItems: [MSFData.PlayerItem] = []
    var selectedTeamId: Int?
    var playersFromSelectedTeam: [MSFData.Player] {
        guard let id = selectedTeamId else {
            return []
        }
        var result: [MSFData.Player] = []
        for item in playerItems {
            guard let team = item.teamAsOfDate else {
                continue
            }
            if team.id == id,
                let player = item.player {
                result.append(player)
            }
        }
        return result
    }
    func updateAll(completion: (() -> ())? = nil) {
        updateTeams()
        updatePlayers(completion: completion)
    }
    
    func updateTeams(completion: (() -> ())? = nil) {
        let urlString = "https://api.mysportsfeeds.com/v2.0/pull/nba/2018-2019-regular/standings.json"
        MySportsFeeds.sendRequest(urlString: urlString, type: .seasonalStandings) { responseData in
            guard let data = responseData as? MSFData.SeasonalStandings else {
                print("*** Response Data Error! ***")
                return
            }
            for teamItem in data.teams {
                let newTeam = Team(team: teamItem.team)
                self.teams.append(newTeam)
            }
            self.selectedTeamId = self.teams[0].id
            DispatchQueue.main.async {
                completion?()
            }
        }
    }
    
    func updatePlayers(completion: (() -> ())? = nil) {
        let urlString = "https://api.mysportsfeeds.com/v2.0/pull/nba/players.json"
        MySportsFeeds.sendRequest(urlString: urlString, type: .players) { responseData in
            guard let data = responseData as? MSFData.Players else {
                print("*** Response Data Error! ***")
                return
            }
            self.playerItems = data.players
            DispatchQueue.main.async {
                completion?()
            }
        }
    }
}
