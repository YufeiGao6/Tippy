//
//  SettingsViewController.swift
//  Tippy
//
//  Created by Yufei Gao on 7/18/20.
//  Copyright © 2020 Yufei Gao. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var percent1: UITextField!
    @IBOutlet weak var percent2: UITextField!
    @IBOutlet weak var percent3: UITextField!
    @IBOutlet weak var optionSelect: UISegmentedControl!
    
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        // This is a good place to retrieve the default tip percentage from UserDefaults
        // and use it to update the tip amount
        // Access UserDefaults
        let defaults = UserDefaults.standard
        let p1 = (defaults.string(forKey: "p1") ?? "15")
        let p2 = (defaults.string(forKey: "p2") ?? "18")
        let p3 = (defaults.string(forKey: "p3") ?? "20")
        percent1.text = p1
        percent2.text = p2
        percent3.text = p3
        optionSelect.selectedSegmentIndex = defaults.integer(forKey: "option")
    }
    
    @IBAction func sync(_ sender: Any) {
        defaults.set(percent1.text, forKey: "p1")
        defaults.set(percent2.text, forKey: "p2")
        defaults.set(percent3.text, forKey: "p3")
        defaults.set(optionSelect.selectedSegmentIndex, forKey: "option")
        // Force UserDefaults to save.
        defaults.synchronize()
    }
    
//    @IBAction func onTap(_ sender: Any) {
//        view.endEditing(true)
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
