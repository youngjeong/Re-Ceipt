//
//  ViewController.swift
//  Re-Ceipt
//
//  Created by 유영정 on 2017. 12. 7..
//  Copyright © 2017년 SSU. All rights reserved.
//

import UIKit
import Foundation

class LoginViewController: UIViewController {
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var pwTextField: UITextField!
    
    @IBAction func onSignUp() {
        Communicator.signUp(self.view, username: idTextField.text!, password: pwTextField.text!) {

        }
    }

    @IBAction func onSignIn() {
        Communicator.signIn(self.view, username: idTextField.text!, password: pwTextField.text!) {
            Communicator.getMySpend(self.view) { spendList in
                self.performSegue(withIdentifier: "LoginSuccessSegue", sender: spendList)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoginSuccessSegue" {
            let barViewControllers = segue.destination as! UITabBarController
            let destinationNavigationController = barViewControllers.viewControllers![0] as! UINavigationController
            let targetController = destinationNavigationController.topViewController as! MySpendViewController
            let spendList = sender as! [Spend]
            targetController.spendList = spendList
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

