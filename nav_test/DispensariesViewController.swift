//
//  DispensariesViewController.swift
//  nav_test
//
//  Created by mac on 9/14/15.
//  Copyright © 2015 mac. All rights reserved.
//

import UIKit

class DispensariesViewController: UITableViewController {
    var dispensaries = [Dispensary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let urlToReq = NSURL(string: "http://192.168.1.137:7000/dispensaries") {
            if let data = NSData(contentsOfURL: urlToReq) {
                let arrOfDispensaries = parseJSON(data)
                for dispensary in arrOfDispensaries! {
                    let object = dispensary as! NSDictionary
                    let id = object["id"] as! Int
                    let name = object["name"] as! String
                    let address = "6429 S Orchard St"
                    let latitude = object["latitude"] as! Double
                    let longitude = object["longitude"] as! Double
                    var phone: String?
                    print(object["phone"])
                    if object["phone"] is NSNull {
                        phone = "123-123-1234"
                    } else {
                        phone = object["phone"] as? String
                        
                    }
                    let email = "test@test.com"
                    let online_reservation = 1
                    let phone_reservation = 1
                    dispensaries.append(Dispensary(id: id, name: name, address: address, latitude: latitude, longitude: longitude, phone: phone!, email: email, online_reservation: online_reservation, phone_reservation: phone_reservation))
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
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dispensaries.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DispensaryCell") as! DispensaryCell
        let dispensary = dispensaries[indexPath.row]
        print(dispensary)
        cell.dispensaryName!.text = dispensary.name
        return cell
    }
    
    

}