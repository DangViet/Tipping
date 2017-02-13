//
//  SettingsViewController.swift
//  Tipping
//
//  Created by Viet Dang Ba on 2/8/17.
//  Copyright © 2017 Viet Dang. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var txtLowTip: UITextField!
    @IBOutlet weak var txtMediumTip: UITextField!
    @IBOutlet weak var txtHighTip: UITextField!
    
    @IBOutlet weak var pickTheme: UIPickerView!
    
    //@IBOutlet weak var segDefaultTipPercent: UISegmentedControl!
    var themes = ["Light", "Dark"]
    var pickViewColour = UIColor.black
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        txtLowTip.delegate = self
        txtMediumTip.delegate = self
        txtHighTip.delegate = self
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
        
        let themeSetting = defaults.integer(forKey: "theme")
        pickTheme.selectRow(themeSetting, inComponent: 0, animated: false)
        changeColor()
        
        let lowTip = defaults.integer(forKey: "LowTip")
        txtLowTip.text = String(lowTip) + "%"
        
        let medTip = defaults.integer(forKey: "MediumTip")
        txtMediumTip.text = String(medTip) + "%"
        
        let highTip = defaults.integer(forKey: "HighTip")
        txtHighTip.text = String(highTip) + "%"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.endEditing(true)
        UIView.animate(withDuration: 0.4, animations: {
            self.view.alpha = 0.5
            
        })
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    @IBAction func onChangeDefaultTipPercent(_ sender: Any) {
        let defaults = UserDefaults.standard
        //defaults.set(segDefaultTipPercent.selectedSegmentIndex, forKey: "percent")
        //defaults.synchronize()
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return themes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return themes[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let defaults = UserDefaults.standard
        defaults.set(row, forKey: "theme")
        defaults.synchronize()
        changeColor()
        pickerView.reloadAllComponents()
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        
        let strTitle = themes[row]
        print(strTitle, pickViewColour)
        let attString = NSAttributedString(string: strTitle, attributes: [NSForegroundColorAttributeName : pickViewColour])
        return attString
    }

    @IBAction func onViewTap(_ sender: Any) {
        view.endEditing(true)
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
            pickViewColour = UIColor.blue
            
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
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if(string == "."){
            return false
        }
        
        if(textField.text == "" && string == "0"){
            return false
        }
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 2 // Bool
    }

    @IBAction func onEditEndLowTip(_ sender: AnyObject) {
        let defaults = UserDefaults.standard
        print("Editing End ", txtLowTip.text)
        var lowTip = Int(txtLowTip.text!) ?? 0
        if(lowTip == 0){
            lowTip = 10
        }
        defaults.set(lowTip, forKey: "LowTip")
        defaults.synchronize()
        txtLowTip.text = String(describing: lowTip) + "%"
    }

    @IBAction func onEditEndMedTip(_ sender: Any) {
        let defaults = UserDefaults.standard
        var medTip = Int(txtMediumTip.text!) ?? 0
        if(medTip == 0){
            medTip = 18
        }
        defaults.set(medTip, forKey: "MediumTip")
        defaults.synchronize()
        txtMediumTip.text = String(describing: medTip) + "%"
    }

    @IBAction func onEditEndHighTip(_ sender: Any) {
        let defaults = UserDefaults.standard
        var highTip = Int(txtHighTip.text!) ?? 0
        if(highTip == 0){
            highTip = 25
        }
        defaults.set(highTip, forKey: "HighTip")
        defaults.synchronize()
        txtHighTip.text = String(describing: highTip) + "%"

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
