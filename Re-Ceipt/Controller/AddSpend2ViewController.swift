//
//  AddSpend2ViewController.swift
//  Re-Ceipt
//
//  Created by Sunwoo Lee on 2017. 12. 19..
//  Copyright © 2017년 SSU. All rights reserved.
//

import UIKit

class AddSpend2ViewController: UIViewController {
    @IBOutlet weak var review_field: UILabel!
    @IBOutlet var Buttons: Array<UIButton>?
    
    var amount: String = ""
    var date: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        review_field.numberOfLines=0
        review_field.text = "\(date) 에\n\(amount) 원을 입력합니다.\n카테고리를 선택하세요."
        review_field.sizeToFit()
        
        for button in Buttons! {
            button.layer.cornerRadius=10
            button.clipsToBounds=true
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonTapped(_ sender: UIButton)
    {
        
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
