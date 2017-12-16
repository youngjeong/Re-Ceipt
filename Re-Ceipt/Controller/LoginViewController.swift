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
    
    var ind: UIActivityIndicatorView? = nil;
    
    @IBAction func onSignUp() {
        Communicator.signUp(self.view, username: idTextField.text!, password: pwTextField.text!) {
            
        }
    }

    @IBAction func onSignIn() {
        Communicator.signIn(self.view, username: idTextField.text!, password: pwTextField.text!) {
            self.performSegue(withIdentifier: "LoginSucessSegue", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

