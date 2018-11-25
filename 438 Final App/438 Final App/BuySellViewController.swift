//
//  BuySellViewController.swift
//  438 Final App
//
//  Created by BrianLin on 11/18/18.
//  Copyright © 2018 BrianLin. All rights reserved.
//

import UIKit

var getBalance = Balance(balance: 5000)

class BuySellViewController: UIViewController {
    
    var gradient : CAGradientLayer!

    @IBOutlet weak var shareSliderValue: UISlider!
    @IBOutlet weak var sharePriceLabel: UILabel!
    @IBOutlet weak var shareNumberLabel: UILabel!
    @IBOutlet weak var transactionTotalLabel: UILabel!
    @IBOutlet weak var currentBalanceLabel: UILabel!
    @IBOutlet weak var sharesInfoLabel: UILabel!
    @IBOutlet weak var sharesOwned: UILabel!
    @IBOutlet weak var sharesAvailable: UILabel!
    
    
    var buy = false
    var currentBalance = getBalance.balance
    var shareNumber = 0
    var sharesOwnedCount = 0
    var sharePrice = 30
    var sharesAvailableCount = 0
    
    @IBAction func buyButton(_ sender: Any) {
        sharesInfoLabel.text = "Number of Shares to Buy"
        shareNumberLabel.text = String(sharesAvailableCount)
        buy = true
    }
    @IBAction func sellButton(_ sender: Any) {
        sharesInfoLabel.text = "Number of Shares to Sell"
        shareNumberLabel.text = String(sharesOwnedCount)
        buy = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentBalanceLabel.text = String(getBalance.balance)
        print("the share number is \(shareNumber)")
        shareNumberLabel.text = String(shareNumber)
        sharesOwned.text = String(sharesOwnedCount)
        sharesAvailable.text = String(sharesAvailableCount)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        shareNumberLabel.text = String(shareNumber)
        sharesOwned.text = String(sharesOwnedCount)
        sharesAvailable.text = String(sharesAvailableCount)
    }
    
    func calculateCurrentBalance() {
        if (buy == true) {
        currentBalanceLabel.text = String(Int(currentBalanceLabel.text!)! - Int(transactionTotalLabel.text!)!)
        currentBalance = Int(currentBalanceLabel.text!)!
        sharesOwnedCount = sharesOwnedCount + Int(shareNumberLabel.text!)!
            sharesAvailableCount = sharesAvailableCount - sharesOwnedCount
        }
        else {
            currentBalanceLabel.text = String(Int(currentBalanceLabel.text!)! + Int(transactionTotalLabel.text!)!)
            currentBalance = Int(currentBalanceLabel.text!)!
            sharesOwnedCount = sharesOwnedCount - Int(shareNumberLabel.text!)!
             sharesAvailableCount = sharesAvailableCount + sharesOwnedCount
        }
    
    }
    
    
    @IBAction func shareSlider(_ sender: UISlider) {
//        shareNumber = Int(shareNumberLabel.text!) ?? 0
        if (buy == true) {
        shareSliderValue.maximumValue = Float(sharesAvailableCount)
        }
        
        else {
            shareSliderValue.maximumValue = Float(sharesOwnedCount)
        }
        
        
        sharePriceLabel.text = String(sharePrice)
        shareNumberLabel.text = String(Int(sender.value))
        transactionTotalLabel.text = String(sharePrice * Int(shareNumberLabel.text!)!)
        var transactionTotal = Int(transactionTotalLabel.text!)
    }
    
    @IBAction func confirmButton(_ sender: Any) {
        shareNumber = Int(shareNumberLabel.text!)!
        if (Int(transactionTotalLabel.text!)! > getBalance.balance){
            let alert = UIAlertController(title: "Alert", message: "You don't have the money.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
        calculateCurrentBalance()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ConfirmationViewController {
            let confirmationVC = segue.destination as? ConfirmationViewController
            confirmationVC?.currentBalance = currentBalance
        }
    }
    
     func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Something Else"
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
    }
   

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
