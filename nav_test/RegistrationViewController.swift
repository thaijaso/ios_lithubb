//
//  ViewController.swift
//  nav_test
//
//  Created by mac on 9/14/15.
//  Copyright © 2015 mac. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //changes to regestration view
    @IBAction func signInButtonPressed(sender: UIButton) {
        performSegueWithIdentifier("SignIn", sender: sender)
    }

    //registers user and goes to orders view
    @IBAction func registerButtonPressed(sender: UIButton) {
        performSegueWithIdentifier("UserAuthenticated", sender: sender)
    }
}

