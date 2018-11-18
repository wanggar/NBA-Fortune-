//
//  BuySellViewController.swift
//  438 Final App
//
//  Created by BrianLin on 11/18/18.
//  Copyright © 2018 BrianLin. All rights reserved.
//

import UIKit

class BuySellViewController: UIViewController {

    @IBOutlet weak var sharePriceLabel: UILabel!
    @IBOutlet weak var shareNumberLabel: UILabel!
    @IBOutlet weak var transactionTotalLabel: UILabel!
    @IBOutlet weak var currentBalanceLabel: UILabel!
    @IBOutlet weak var sharesInfoLabel: UILabel!
    var buy = false
    @IBAction func buyButton(_ sender: Any) {
        sharesInfoLabel.text = "Number of Shares to Buy"
        buy = true
    }
    @IBAction func sellButton(_ sender: Any) {
        sharesInfoLabel.text = "Number of Shares to Buy"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func shareSlider(_ sender: UISlider) {
        var shareNumber = Int(shareNumberLabel.text!) ?? 0
        var sharePrice = Int(sharePriceLabel.text!) ?? 0
        shareNumberLabel.text = String(Int(sender.value))
        transactionTotalLabel.text = String(sharePrice * shareNumber)
        var transactionTotal = Int(transactionTotalLabel.text!)
    }
    
    @IBAction func confirmButton(_ sender: Any) {
        currentBalanceLabel.text = String(Int(currentBalanceLabel.text!)! + Int(transactionTotalLabel.text!)!)
    }
    
    lazy var currentBalance = currentBalanceLabel.text

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
 
    
    

    

    /*
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
