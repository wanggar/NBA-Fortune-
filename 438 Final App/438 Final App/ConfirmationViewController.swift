//
//  ConfirmationViewController.swift
//  438 Final App
//
//  Created by BrianLin on 11/18/18.
//  Copyright © 2018 BrianLin. All rights reserved.
//

import UIKit

class ConfirmationViewController: UIViewController {
    var currentBalance = 0
    @IBOutlet weak var currentBalanceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        currentBalanceLabel.text = String(currentBalance)
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
