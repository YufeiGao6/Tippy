//
//  ViewController.swift
//  Test
//
//  Created by Yufei Gao on 7/17/20.
//  Copyright © 2020 Yufei Gao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var percentLabel: UILabel!
    var percentTextField: UITextField?
    var percentage: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    let defaults = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        // This is a good place to retrieve the default tip percentage from UserDefaults
        // and use it to update the tip amount
        // Access UserDefaults
        
        let p1 = (defaults.string(forKey: "p1") ?? "15") + "%"
        let p2 = (defaults.string(forKey: "p2") ?? "18") + "%"
        let p3 = (defaults.string(forKey: "p3") ?? "20") + "%"
        tipControl.setTitle(p1, forSegmentAt: 0)
        tipControl.setTitle(p2, forSegmentAt: 1)
        tipControl.setTitle(p3, forSegmentAt: 2)
        tipControl.selectedSegmentIndex = (defaults.integer(forKey: "option"))
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        // Get the bill amount
        let billStr:String = billField.text!
        let bill = Double(billStr) ?? 0
        // Calculate the tip and total
        let p1 = Double(defaults.string(forKey: "p1") ?? "15")!*0.01
        let p2 = Double(defaults.string(forKey: "p2") ?? "18")!*0.01
        let p3 = Double(defaults.string(forKey: "p3") ?? "20")!*0.01
        let tipPercentages = [p1, p2, p3, percentage]
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        // Update the tip and total labels
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    @IBAction func percentageChanged(_ sender: Any) {
        view.endEditing(true)
        if(tipControl.selectedSegmentIndex != 3){
            calculateTip(self)
        }else{
            let alertController = UIAlertController(title: "Custom Tip", message: nil, preferredStyle: .alert)
            alertController.addTextField(configurationHandler: percentTextField)
            let okAction = UIAlertAction(title:"OK", style: .default, handler: self.okHandler)
            let cancelAction = UIAlertAction(title:"Cancel", style: .cancel, handler: nil)
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            self.present(alertController, animated: true)
        }
    }
    
    func percentTextField(textField: UITextField!){
        percentTextField = textField
        percentTextField?.placeholder = "0%"
        percentTextField?.keyboardType = UIKeyboardType.decimalPad
        
    }
    
    func okHandler(alert:UIAlertAction!){
        let billStr:String = billField.text!
        let bill = Double(billStr) ?? 0
        percentage = 0.01*(Double((percentTextField?.text)!) ?? 0)
        percentLabel.text = String(format: "%.1f%%", percentage*100)
        let tip = bill * 0.01*(Double((percentTextField?.text)!) ?? 0)
        let total = bill + tip
        // Update the tip and total labels
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
}

