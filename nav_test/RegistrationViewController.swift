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
            if let urlToReq = NSURL(string: "http://192.168.1.140:7000/addUser") {
                let request: NSMutableURLRequest = NSMutableURLRequest(URL: urlToReq)
                request.HTTPMethod = "POST"
                // Get all info from textfields to send to node server
                let bodyData = "firstName=\(firstNameTextField.text!)&lastName=\(lastNameTextField.text!)&email=\(emailTextField.text!)&password=\(passTextField.text!)&confirm=\(confirmPassTextField.text!)"
                request.HTTPBody = bodyData.dataUsingEncoding(NSUTF8StringEncoding);
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                    (response, data, error) in
                    //print(NSString(data: data!, encoding: NSUTF8StringEncoding))

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
    
    //helper function for names validation
    func validateName(candidate: String) -> Bool {
        let nameRegex = "^[a-zA-Z]+(([\\'\\,\\.\\-][a-zA-Z])?[a-zA-Z]*)*$"
        return NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluateWithObject(candidate)
    }
    
    func validatePhone(candidate: String) -> Bool {
        let nameRegex = "^[2-9]\\d{2}-\\d{3}-\\d{4}$"
        return NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluateWithObject(candidate)
    }
    
    //total VALIDATION ALERT helper combining the other validation helpers. Returns an alert controller if validation fails.
    func validateLogin(email: String, password: String) -> UIAlertController? {
        let emailIsValid = validateEmail(email)
        let passwordIsValid = validatePassword(password)
        //if BOTH are bad
        if emailIsValid == false && passwordIsValid == false {
            let alert = UIAlertController(title: "Login Error", message: "Please enter a valid email and password", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.Default, handler: nil))
            return alert
            //only EMAIL is bad
        } else if emailIsValid == false {
            let alert = UIAlertController(title: "Login Error", message: "Please enter a valid email", preferredStyle: UIAlertControllerStyle.Alert)
            return alert
            //only PASSWORD is bad
        } else if passwordIsValid == false {
            let alert = UIAlertController(title: "Login Error", message: "Please enter a valid password. Accepted characters: letters, numbers and underscore Allowed Length: 5-14 characters", preferredStyle: UIAlertControllerStyle.Alert)
            return alert
            
        }
        return nil
    }
    
    
}

