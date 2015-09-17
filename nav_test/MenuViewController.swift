//
//  MenuController.swift
//  nav_test
//
//  Created by mac on 9/16/15.
//  Copyright © 2015 mac. All rights reserved.
//

import UIKit
import GoogleMaps

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var allProducts = [AnyObject]()
    var productsFilter = [AnyObject]()
    var myMarker : GMSMarker!
    
    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var dispensaryName: UINavigationItem!
    
    
    @IBAction func filterButtonPressed(sender: UIButton) {
        productsFilter = [AnyObject]()
        if sender.tag == 1 {
            filter("Indica")
        } else if sender.tag == 2{
            filter("Hybrid")
        } else if sender.tag == 3{
            filter("Sativa")
        } else if sender.tag == 4{
            filter("Edibles")
        } else if sender.tag == 5 {
            filter("Other")
        }
        productTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dispensaryID = String(myMarker.userData)
        if let urlToReq = NSURL(string: "http://192.168.1.140:7000/getMenu/" + dispensaryID) {
            if let data = NSData(contentsOfURL: urlToReq) {
                let arrOfProducts = parseJSON(data)
                for product in arrOfProducts! {
                    let productDict = product as! NSDictionary
                    print(productDict["strain_name"])
                    allProducts.append(productDict)
                }
            }
        }
        productTableView.dataSource = self
        productTableView.delegate = self
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func parseJSON(inputData: NSData) -> NSArray? {
        do {
            let arrOfObjects = try NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers) as! NSArray
            return arrOfObjects
        } catch {
            print(error)
            return nil
        }
    }
    
   func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if productsFilter.count == 0 {
            return allProducts.count
        }else{
            return productsFilter.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = productTableView.dequeueReusableCellWithIdentifier("StrainCell") as? StrainCell
        print("after cell\(cell)")
        if productsFilter.count != 0 {
            cell!.nameLabel?.text = productsFilter[indexPath.row]["strain_name"] as? String
        } else {
            cell!.nameLabel?.text = allProducts[indexPath.row]["strain_name"] as? String
        }
        return cell!
    }
    
    func filter(filter: String){
        for product in allProducts {
            if product["category"] as! String == filter {
                productsFilter.append(product)
            }
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("ShowProduct", sender: tableView.cellForRowAtIndexPath(indexPath))
    }
}
