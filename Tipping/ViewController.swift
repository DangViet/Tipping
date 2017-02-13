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
    
    var themes = ["Light", "Dark"]
    var pickViewColour = UIColor.black
    var lowTip = 10
    var medTip = 18
    var highTip = 25
    
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
        
        lowTip = defaults.integer(forKey: "LowTip")
        print("Will apprear ", lowTip)
        if(lowTip == 0){
            lowTip = 10
            defaults.set(lowTip, forKey: "LowTip")
        }
        segTipPercent.setTitle(String(lowTip) + "%", forSegmentAt: 0)
        
        medTip = defaults.integer(forKey: "MediumTip")
        if(medTip == 0){
            medTip = 18
            defaults.set(medTip, forKey: "MediumTip")
        }
        segTipPercent.setTitle(String(medTip) + "%", forSegmentAt: 1)
        
        highTip = defaults.integer(forKey: "HighTip")
        if(highTip == 0){
            highTip = 25
            defaults.set(highTip, forKey: "HighTip")
        }
        
        defaults.synchronize()
        
        segTipPercent.setTitle(String(highTip) + "%", forSegmentAt: 2)
        
        
        calcTotal(nil)
        
        changeColor()
        
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
        
        let defaults = UserDefaults.standard
        
        UIView.animate(withDuration: 1, animations: {
            self.blankView.alpha = 0
            
            
        })
            UIView.animate(withDuration: 0.5, animations: {
                self.blankView.alpha = 1
                
        })
        var tipPercentage = 0.0
        if(segTipPercent.selectedSegmentIndex == 0){
            tipPercentage = defaults.double(forKey: "LowTip") / 100
        } else if (segTipPercent.selectedSegmentIndex == 1){
            tipPercentage = defaults.double(forKey: "MediumTip") / 100
        } else {
            tipPercentage = defaults.double(forKey: "HighTip") / 100
        }
        
        let bill = Double(txtBill.text!) ?? 0
        
        
        
        let tip = bill * (tipPercentage)
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

    func changeColor() {
        let defaults = UserDefaults.standard
        let themeSetting = defaults.integer(forKey: "theme")
        if (themeSetting == 1) {
            self.view.backgroundColor = UIColor.black;
            
            //Get all UIViews in self.view.subViews
            for subview in self.view.subviews as [UIView]  {
                //Check if the view is of UILabel class
                if let labelView = subview as? UILabel {
                    //Set the color to label
                    labelView.textColor = UIColor.blue;
                }
                if let textView = subview as? UITextField{
                    textView.textColor = UIColor.blue
                }
                if let pickerView = subview as? UIPickerView{
                    pickerView.backgroundColor = UIColor.black
                    
                }
            }
            pickViewColour = UIColor.red
            
        } else {
            self.view.backgroundColor = UIColor.white;
            //Get all UIViews in self.view.subViews
            for subview in self.view.subviews as [UIView]  {
                //Check if the view is of UILabel class
                if let labelView = subview as? UILabel {
                    //Set the color to label
                    labelView.textColor = UIColor.black;
                }
                if let textView = subview as? UITextField{
                    textView.textColor = UIColor.black;
                }
                if let pickerView = subview as? UIPickerView{
                    pickerView.backgroundColor = UIColor.white
                    
                }
                
                
            }
            pickViewColour = UIColor.black
        }
    }


}

