//
//  SignInViewController.swift
//  nav_test
//
//  Created by mac on 9/14/15.
//  Copyright © 2015 mac. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        //        delegate this viewcontroller so we can press return to dismiss keyboard.
        self.emailTextField.delegate = self
        self.passTextField.delegate = self
        
    }
    
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
    
    //goes to registration view
    @IBAction func registerButtonPressed(sender: UIButton) {
        performSegueWithIdentifier("Register", sender: sender)
    }
    
    //signs in user and goes to orders view
    @IBAction func signInButtonPressed(sender: UIButton) {
        if let urlToReq = NSURL(string: "http://192.168.1.137:7000/loginUser") {
            let request: NSMutableURLRequest = NSMutableURLRequest(URL: urlToReq)
            request.HTTPMethod = "POST"
            // Get all info from textfields to send to node server
            let bodyData = "email=\(emailTextField.text!)&password=\(passTextField.text!)"
            request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                (response, data, error) in
                print(NSString(data: data!, encoding: NSUTF8StringEncoding)!)
            }
        }
    }
}
