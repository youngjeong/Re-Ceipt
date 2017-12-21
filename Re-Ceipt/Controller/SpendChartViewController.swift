//
//  SpendChartViewController.swift
//  Re-Ceipt
//
//  Created by Sunwoo Lee on 2017. 12. 21..
//  Copyright © 2017년 SSU. All rights reserved.
//

import UIKit
import Charts
import EFCountingLabel

class SpendChartViewController: UIViewController {

    @IBOutlet weak var StartDateField: UITextField!
    @IBOutlet weak var EndDateField: UITextField!
    @IBOutlet weak var amountLabel: EFCountingLabel!
    
    @IBOutlet weak var pieChart: PieChartView!
    
    
    var spendList: [Spend] = []
    
    var Dataset = [String:Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        amountLabel.method = .easeInOut
        amountLabel.formatBlock = {
            (value) in
            return "₩ " + (formatter.string(from: NSNumber(value: Int(value))) ?? "")
        }
        
        pieChart.data = nil
        pieChart.notifyDataSetChanged()
        let today_date = Date()
        
        let start_formatter = DateFormatter()
        let end_formatter = DateFormatter()

        start_formatter.dateFormat = "yyyy-MM-01"
        end_formatter.dateFormat = "yyyy-MM-31"
        let start_date = start_formatter.string(from: today_date)
        let end_date = end_formatter.string(from: today_date)
        
        StartDateField.text = start_date
        EndDateField.text = end_date
        
        let startdatePicker = UIDatePicker()
        startdatePicker.accessibilityIdentifier = "Start"
        let enddatePicker = UIDatePicker()
        enddatePicker.accessibilityIdentifier = "End"
        startdatePicker.datePickerMode = UIDatePickerMode.date
        enddatePicker.datePickerMode = UIDatePickerMode.date
        startdatePicker.addTarget(self, action: #selector(self.datePickerValueChanged(sender:)), for: UIControlEvents.valueChanged)
        enddatePicker.addTarget(self, action: #selector(self.datePickerValueChanged(sender:)), for: UIControlEvents.valueChanged)
        StartDateField.inputView = startdatePicker
        EndDateField.inputView = enddatePicker
        
        updateChart()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func updateChart() {
        Dataset.removeAll()
        
        var totalAmount = 0
        
        for data in spendList{
            let target: String = data.date!
            if target >= StartDateField.text! && EndDateField.text! >= target{
                if Dataset[data.type!] == nil {
                    Dataset[data.type!] = 0
                }
                Dataset[data.type!]! += Int(data.amount!)
                totalAmount += data.amount!
            }
        }
        
        
        amountLabel.countFrom(0, to: CGFloat(totalAmount))
        
        pieChart.data = nil
        pieChart.notifyDataSetChanged()
        
        var entries = [PieChartDataEntry]()
        for key in Dataset.keys{
            let entry = PieChartDataEntry()
            entry.y = Double(Dataset[key]!)
            entry.label = key
            entries.append(entry)
        }
        
        let set = PieChartDataSet(values: entries, label: "Pie Chart")
        
        var colors: [UIColor] = []
        
        for _ in Dataset.keys {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        set.colors = colors
        
        
        
        set.sliceSpace = 5
        let data = PieChartData(dataSet: set)
        pieChart.data = data
        pieChart.notifyDataSetChanged()
    }
    
    @objc
    func datePickerValueChanged(sender: UIDatePicker){
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd"
        
        let result = formatter.string(from: sender.date)
        if sender.accessibilityIdentifier == "Start"{
            StartDateField.text = result
        }else{
            EndDateField.text = result
        }
        updateChart()
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
