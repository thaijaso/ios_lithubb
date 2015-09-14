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
        if let urlToReq = NSURL(string: "http://192.168.1.137:7000/dispensaries") {
            if let data = NSData(contentsOfURL: urlToReq) {
                let arrOfDispensaries = parseJSON(data)
                for dispensary in arrOfDispensaries! {
                    let object = dispensary as! NSDictionary
                    let id = object["id"]
                    let name = object["name"]
                    let address = object["address"]
                    let latitude = object["latitude"]
                    let longitude = object["longitude"]
                    let phone = object["phone"]
                    let email = object["email"]
                    let online_reservation = object["online_reservation"]
                    let phone_reservation = object["phone_reservation"]
                    
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parseJSON(inputData: NSData) -> NSArray? {
        do {
            var arrOfObjects = try NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers) as! NSArray
            return arrOfObjects
        } catch {
            print(error)
            return nil
        }
    }

}