//
//  AddSpendViewController.swift
//  Re-Ceipt
//
//  Created by Sunwoo Lee on 2017. 12. 18..
//  Copyright © 2017년 SSU. All rights reserved.
//

import UIKit

class AddSpendViewController: UIViewController {

    
    @IBOutlet var date_field: UITextField!
    @IBOutlet var amount_field: UITextField!
    @IBOutlet var next_button: UIButton!
    
    var delegate: TopViewControllerProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            let today_date = Date()
            let formatter = DateFormatter()
            
            formatter.dateFormat = "yyyy-MM-dd"
            
            let result = formatter.string(from: today_date)
            date_field.text = result
            
            let datePicker = UIDatePicker()
            datePicker.datePickerMode = UIDatePickerMode.date
            datePicker.addTarget(self, action: #selector(self.datePickerValueChanged(sender:)), for: UIControlEvents.valueChanged)
            
            date_field.inputView = datePicker
            
            
            self.amount_field.keyboardType = UIKeyboardType.decimalPad
  
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewController(animated: true)
        self.delegate.dismissViewController()
    }
    
    @objc
    func datePickerValueChanged(sender: UIDatePicker){
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd"
        
        let result = formatter.string(from: sender.date)
        date_field.text = result
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddSpendNextStepSegue"{
            let target_controller = segue.destination as! AddSpend2ViewController
            target_controller.amount = amount_field.text!
            target_controller.date = date_field.text!
            target_controller.delegate = self.delegate
        }
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
