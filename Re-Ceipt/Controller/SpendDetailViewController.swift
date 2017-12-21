//
//  SpendDetailViewController.swift
//  Re-Ceipt
//
//  Created by 유영정 on 2017. 12. 21..
//  Copyright © 2017년 SSU. All rights reserved.
//

import UIKit
import EFCountingLabel

class SpendDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var amountLabel: EFCountingLabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dislikeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBAction func onLike() {
        
    }
    @IBAction func onDislike() {
        
    }
    @IBAction func onComment() {
        
    }
    
    var spend: Spend! = nil
    var comments: [Comment]? = [] {
        didSet {
            tableView?.reloadData()
        }
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
        
        Communicator.getCommentList(self.view, from: spend) { commentList in
            self.comments = commentList
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        amountLabel.countFrom(0, to: CGFloat(spend!.amount!))
        likeLabel.text = String(spend.like_cnt!)
        dislikeLabel.text = String(spend.dislike_cnt!)
        commentLabel.text = String(spend.comment_cnt!)
        descriptionLabel.text = "\(spend.title!)한다고 \(spend.type!)에 이만큼 썼습니다!"
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
        return comments!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CommentCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CommentTableViewCell
        cell.userLabel.text = comments![indexPath.row].author?.username
        cell.commentLabel.text = comments![indexPath.row].content
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
    
}


