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
        // delegate this viewcontroller so we can press return to dismiss keyboard.
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
    
    //goes to registration view
    @IBAction func registerButtonPressed(sender: UIButton) {
        performSegueWithIdentifier("Register", sender: sender)
    }
    
    //SING IN for user. Goes to orders view if email/pass check succeeds
    @IBAction func signInButtonPressed(sender: UIButton) {
        //here we validate the front-end form using the below helper functions
        if let isValidLogin = validateLogin(emailTextField.text!, password: passTextField.text!) {
            self.presentViewController(isValidLogin, animated: true, completion: nil)
        } else {
            // now we request to get check the email with the server
            if let urlToReq = NSURL(string: "http://192.168.1.140:7000/loginUser") {
                let request: NSMutableURLRequest = NSMutableURLRequest(URL: urlToReq)
                request.HTTPMethod = "POST"
                // Get all info from textfields to send to node server
                let bodyData = "email=\(emailTextField.text!)&password=\(passTextField.text!)"
                request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                    (response, data, error) in
                    let dataToPrint = JSON(data: data!)
                    let integerToCheckUser = Int(String(dataToPrint[0]["id"]))
                    if integerToCheckUser > -1 {
                        self.performSegueWithIdentifier("UserAuthenticated", sender: sender)
                    } else {
                        let alert = UIAlertController(title: "Login Error", message: "Incorrect email or password", preferredStyle: UIAlertControllerStyle.Alert)
                        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
                    }
                }
            }

        }
        
    }
    
    //helper function for email validation
    func validateEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluateWithObject(candidate)
    }
    
    //helper function for password validation
    func validatePassword(candidate: String) -> Bool {
        let passwordRegex = "^[a-zA-Z]\\w{5,14}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluateWithObject(candidate)
    }
    
    //total VALIDATION ALERT helper combining the other validation helpers
    func validateLogin(email: String, password: String) -> UIAlertController? {
        let emailIsValid = validateEmail(email)
        let passwordIsValid = validatePassword(password)
            //if BOTH are bad
        if emailIsValid == false && passwordIsValid == false {
            let alert = UIAlertController(title: "Login Error", message: "Please enter a valid email and password", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            return alert
            //only EMAIL is bad
        } else if emailIsValid == false {
            let alert = UIAlertController(title: "Login Error", message: "Please enter a valid email", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            return alert
            //only PASSWORD is bad
        } else if passwordIsValid == false {
            let alert = UIAlertController(title: "Login Error", message: "Please enter a valid password. Accepted characters: letters, numbers and underscore Allowed Length: 5-14 characters", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            return alert

        }
            return nil
    }
    
    //text fields are checking on "Edit Changed"
    @IBAction func liveTextFieldValidate(sender: AnyObject) {
        liveColorValidation(emailTextField.text!, password: passTextField.text!)
    }

    func liveColorValidation(email: String, password: String) {
        if !validateEmail(email) {
            emailTextField.layer.borderWidth = 2
            emailTextField.layer.borderColor = UIColor.redColor().CGColor
        } else {
            emailTextField.layer.borderWidth = 1
            emailTextField.layer.borderColor = UIColor.greenColor().CGColor
        }
        if !validatePassword(password) {
            passTextField.layer.borderWidth = 2
            passTextField.layer.borderColor = UIColor.redColor().CGColor
        } else {
            passTextField.layer.borderWidth = 1
            passTextField.layer.borderColor = UIColor.greenColor().CGColor
        }
    }
}
