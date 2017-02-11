//
//  ViewController.swift
//  Tipping
//
//  Created by Viet Dang Ba on 2/7/17.
//  Copyright © 2017 Viet Dang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtBill: UITextField!
    @IBOutlet weak var lblTip: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var blankView: UIView!
    
    @IBOutlet weak var segTipPercent: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtBill.becomeFirstResponder()
        txtBill.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
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

        
        let defaults = UserDefaults.standard
        let defaultPercentIndex = defaults.integer(forKey: "percent")
        segTipPercent.selectedSegmentIndex = defaultPercentIndex
        calcTotal(nil)
        
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

    @IBAction func onViewTap(_ sender: Any) {
        view.endEditing(true);
    }
    
    @IBAction func calcTotal(_ sender: AnyObject?) {
        
        UIView.animate(withDuration: 1, animations: {
            self.blankView.alpha = 0
            
            
        })
            UIView.animate(withDuration: 0.5, animations: {
                self.blankView.alpha = 1
                
        })
        
        
        let tipPercentages = [0.1, 0.18, 0.25]
        
        let bill = Double(txtBill.text!) ?? 0
        
        
        
        let tip = bill * (tipPercentages[segTipPercent.selectedSegmentIndex])
        let total = tip + bill
    
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = NSLocale.current
        
        let localizedTip = formatter.string(from: NSNumber(value: tip))
        let localizedTotal = formatter.string(from: NSNumber(value: total))
        
        lblTip.text = localizedTip
        lblTotal.text = localizedTotal
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if(string == "." && textField.text?.range(of:".") != nil){
            return false
        }
        
        if(textField.text == "0"){
            if(string != "."){
                textField.text = "";
            }
            
        }
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 9 // Bool
    }


}

