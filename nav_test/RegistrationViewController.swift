//
//  ViewController.swift
//  nav_test
//
//  Created by mac on 9/14/15.
//  Copyright © 2015 mac. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController, UITextFieldDelegate, NSURLSessionDelegate {

//    Outlets for registration
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var confirmPassTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        //        delegate this viewcontroller so we can press return to dismiss keyboard. This can be made cleaner by putting all the outputs in a collection. Saving time, though.
        self.firstNameTextField.delegate = self
        self.lastNameTextField.delegate = self
        self.emailTextField.delegate = self
        self.phoneTextField.delegate = self
        self.passTextField.delegate = self
        self.confirmPassTextField.delegate = self
    }
    
    //Calls this function when the tap is recognized.
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    
    //Disappears keyboard when return is pressed
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
        
        //Still needs validation on iOS and node backend
        
        // this is where I've been changing the scheme to https
            if let urlToReq = NSURL(string: "http://192.168.1.137:7000/addUser") {
                let request: NSMutableURLRequest = NSMutableURLRequest(URL: urlToReq)
                request.HTTPMethod = "POST"
                // Get all info from textfields to send to node server
                let bodyData = "firstNme=\(firstNameTextField.text!)&lastName=\(lastNameTextField.text!)&email=\(emailTextField.text!)&password=\(passTextField.text!)&confirm=\(confirmPassTextField.text!)"
                request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                    (response, data, error) in
                    print(NSString(data: data!, encoding: NSUTF8StringEncoding))

                }
            }
        performSegueWithIdentifier("UserAuthenticated", sender: sender)
    }
}

