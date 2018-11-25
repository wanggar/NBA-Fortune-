//
//  ViewController.swift
//  NBA Player
//
//  Created by Shane Whong on 11/8/18.
//  Copyright © 2018 Shane Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var imageView: UIImageView!
    
    var imageSource: String?

    var dataModel = DataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        dataModel.updateTeams() {
            self.pickerView.reloadComponent(0)
            self.dataModel.updatePlayers() {
                if !self.dataModel.teams.isEmpty {
                    self.dataModel.selectedTeamId = self.dataModel.teams[0].id
                }
                self.pickerView.reloadComponent(1)
            }
        }
    }
    
    // Picker View DataSource
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return dataModel.teams.count
        } else {
            return dataModel.playersFromSelectedTeam.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return (dataModel.teams[row].abbreviation) + " " +  (dataModel.teams[row].name ?? "")
        } else {
            return (dataModel.playersFromSelectedTeam[row].firstName + " " +  dataModel.playersFromSelectedTeam[row].lastName)
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            dataModel.selectedTeamId = dataModel.teams[row].id
            pickerView.reloadComponent(1)
        } else {
            imageSource = dataModel.playersFromSelectedTeam[row].officialImageSrc
            if let imageURL = URL(string: imageSource ?? "") {
                imageView.load(url: imageURL)
            }
        }
    }

}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
