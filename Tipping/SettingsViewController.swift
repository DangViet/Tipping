//
//  SettingsViewController.swift
//  Tipping
//
//  Created by Viet Dang Ba on 2/8/17.
//  Copyright © 2017 Viet Dang. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var segDefaultTipPercent: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animate(withDuration: 0.4, animations: {
            self.view.alpha = 1
            
        })
        
        self.view.backgroundColor = UIColor.darkGray;
        let defaults = UserDefaults.standard
        let defaultPercentIndex = defaults.integer(forKey: "percent")
        segDefaultTipPercent.selectedSegmentIndex = defaultPercentIndex
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIView.animate(withDuration: 0.4, animations: {
            self.view.alpha = 0.5
            
        })
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    @IBAction func onChangeDefaultTipPercent(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(segDefaultTipPercent.selectedSegmentIndex, forKey: "percent")
        defaults.synchronize()
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
