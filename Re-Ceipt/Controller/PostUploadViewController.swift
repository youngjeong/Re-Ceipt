//
//  MySpendViewController.swift
//  Re-Ceipt
//
//  Created by Sunwoo Lee on 2017. 12. 16..
//  Copyright © 2017년 SSU. All rights reserved.
//

import UIKit
import Floaty
import EFCountingLabel

class PostUploadViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIViewControllerPreviewingDelegate {
    func updateAmount()
    {
        var amount = 0
        for spend in appliedSpendList {
            amount += spend.amount!
        }
        
        amountLabel.countFrom(0, to: CGFloat(amount))
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
//        let previewView = storyboard?.instantiateViewController(withIdentifier: "Preview") as! SpendDetailViewController
        return nil
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var amountLabel: EFCountingLabel!
    
    var from: String = ""
    var to: String = ""
    
    @IBAction func onUploadPressed() {
        let alert = UIAlertController(title: "포스팅 업로드", message: "타이틀을 입력하세요", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "오늘의 사용 내역"
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField: UITextField = (alert?.textFields![0])!
            if let text = textField.text {
                Communicator.uploadPost(self.view, title: text.count <= 0 ? textField.placeholder! : text, start_date: self.from, end_date: self.to) { post in
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    var originalSpendList: [Spend] = []
    var appliedSpendList: [Spend] = []
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let today_date = Date()
        let yesterday_date = today_date.addingTimeInterval(-86400)
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd"
        
        from = formatter.string(from: yesterday_date)
        to = formatter.string(from: today_date)
    }
    
    func updateAppliedSpendList()
    {
        appliedSpendList = originalSpendList
        let startIndex = appliedSpendList.index(where: { (item) -> Bool in
            item.date!.compare(to).rawValue <= 0
        })
        
        do {
            try appliedSpendList.sort(by: {(p, q) throws -> Bool in
                p.date! < q.date!
            })
        }
        catch {
            print(error)
        }
        
        var endIndex = startIndex
        if let temp = appliedSpendList.index(where: { (item) -> Bool in
            item.date!.compare(from).rawValue >= 0
        }) {
            endIndex = appliedSpendList.count - 1 - temp
            
            if (startIndex! <= endIndex!) {
                appliedSpendList = Array(originalSpendList[startIndex!...endIndex!])
            } else {
                appliedSpendList = []
            }
        } else {
            appliedSpendList = []
        }
        
        updateAmount()
        tableView.reloadData()
    }
    
    func updateTextFields() {
        fromTextField.text = from + " 부터"
        toTextField.text = to + " 까지"
        updateAppliedSpendList()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateTextFields()
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.date
        datePicker.addTarget(self, action: #selector(self.fromDatePickerValueChanged(sender:)), for: .valueChanged)
        fromTextField.inputView = datePicker
        
        let datePicker2 = UIDatePicker()
        datePicker2.datePickerMode = UIDatePickerMode.date
        datePicker2.addTarget(self, action: #selector(self.toDatePickerValueChanged(sender:)), for: .valueChanged)
        toTextField.inputView = datePicker2
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        amountLabel.method = .easeInOut
        amountLabel.formatBlock = {
            (value) in
            return "₩ " + (formatter.string(from: NSNumber(value: Int(value))) ?? "")
        }
        
        if traitCollection.forceTouchCapability == UIForceTouchCapability.available
        {
            registerForPreviewing(with: self, sourceView: view)
        }
        else
        {
            print("NOT AVAILABLE 3D TOUCH")
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc
    func fromDatePickerValueChanged(sender: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        from = formatter.string(from: sender.date)
        updateTextFields()
    }
    
    @objc
    func toDatePickerValueChanged(sender: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        to = formatter.string(from: sender.date)
        updateTextFields()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateAmount()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return appliedSpendList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "SpendCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MySpendViewCell
        cell.titleLabel.text = appliedSpendList[indexPath.row].title
        let date = appliedSpendList[indexPath.row].date!
        cell.dateLabel.text = date
        
        
        let amount = NSNumber(value: appliedSpendList[indexPath.row].amount!)
        
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.init(identifier: "ko_KR")
        cell.amountLabel.text = currencyFormatter.string(from: amount)
        
        return cell
    }
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "CommentListSegue" {
            let spendDetailViewController = segue.destination as! SpendDetailViewController
            let index = tableView.indexPathForSelectedRow?.row
            spendDetailViewController.spend = appliedSpendList[index!]
        }
    }
}

