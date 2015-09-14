//
//  DispensariesViewController.swift
//  nav_test
//
//  Created by mac on 9/14/15.
//  Copyright © 2015 mac. All rights reserved.
//

import UIKit

class DispensariesViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let urlToReq = NSURL(string: "http://localhost:7000/dispensaries") {
            print("here")
            if let data = NSData(contentsOfURL: urlToReq) {
                print("here")
                print(data)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}