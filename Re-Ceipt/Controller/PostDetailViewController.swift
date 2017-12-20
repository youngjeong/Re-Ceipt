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

class PostDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIViewControllerPreviewingDelegate {
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        let previewView = storyboard?.instantiateViewController(withIdentifier: "Preview")
        return previewView
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var amountLabel: EFCountingLabel!
    
    var post: Post? = nil {
        didSet {
            tableView?.reloadData()
        }
    }
    
    let floaty = Floaty()
    
    fileprivate func AddFloaty() {
        let showGraphItem = FloatyItem()
        showGraphItem.icon = UIImage(named: "graph")!
        showGraphItem.title = "그래프 보기"
        
        let uploadItem = FloatyItem()
        uploadItem.icon = UIImage(named: "share")!
        uploadItem.title = "내역 올리기"
        
        
        floaty.addItem(item: showGraphItem)
        floaty.addItem(item: uploadItem)
        
        floaty.paddingY = 100
        self.view.addSubview(floaty)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        AddFloaty()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        var amount = 0
        for spend in post!.spend_list! {
            amount += spend.amount!
        }
        
        amountLabel.countFrom(0, to: CGFloat(amount))
    }
    
    func addMenuItems(menu:String ...) -> [UIPreviewActionItem] {
        var arrPreview = [UIPreviewActionItem]()
        for m in menu {
            let likeAction = UIPreviewAction(title:m, style: .default) { (action, viewController) -> Void in
                print(action.title)
            }
            arrPreview.append(likeAction)
        }
        return arrPreview
    }
    
    // Add Action of preview
    override var previewActionItems: [UIPreviewActionItem] {
        return self.addMenuItems(menu: "Open","Bookmark")
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
        return post!.spend_list!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let spendList = post!.spend_list!
        let cellIdentifier = "SpendCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SpendViewCell
        cell.titleLabel.text = spendList[indexPath.row].title
        let date = spendList[indexPath.row].date!
        cell.dateLabel.text = date
        
        
        let amount = NSNumber(value: spendList[indexPath.row].amount!)
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "PreviewSegue" {
            let previewViewController = segue.destination as! PreviewViewController
            previewViewController.imagePath = "like"
        }
    }
    
}

