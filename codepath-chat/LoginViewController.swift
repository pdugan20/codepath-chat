//
//  LoginViewController.swift
//  codepath-chat
//
//  Created by Patrick Dugan on 6/16/15.
//  Copyright (c) 2015 dailydoog. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    @IBAction func didPressSignIn(sender: UIButton) {
        PFUser.logInWithUsernameInBackground(usernameField.text, password: passwordField.text) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                self.performSegueWithIdentifier("loginSegue", sender: self)
            } else {
                println("Error: \(error)")
            }
        }
    }
    
    @IBAction func didPressSignUp(sender: UIButton) {
        var user = PFUser()
        
        user.username = usernameField.text
        user.password = passwordField.text
        
        user.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if success {
                println("New user successfully created!")
                self.performSegueWithIdentifier("loginSegue", sender: self)
            } else {
                println("Error: \(error)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
