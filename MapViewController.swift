//
//  MapViewController.swift
//  nav_test
//
//  Created by mac on 9/15/15.
//  Copyright © 2015 mac. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, GMSMapViewDelegate {
    var dispensaries = [Dispensary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var camera = GMSCameraPosition.cameraWithLatitude(47.610377, longitude: -122.2006786, zoom: 15)
        var mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        mapView.myLocationEnabled = true
        self.view = mapView
        
        var marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(47.6098, -122.198)
        marker.title = "Green Theory"
        marker.snippet = "Monday-Saturday 10AM - 10PM | Sunday 10AM-7PM"
        marker.map = mapView
        marker.userData = 583
        
        mapView.delegate = self
        
    }
    
    func drawMarkerFor(dispensary: Dispensary) {
        for var i = 0; i < dispensaries.count; ++i {
            var marker = GMSMarker()
            marker.position = CLLocationCoordinate2DMake(dispensaries[i].latitude!, dispensaries[i].longitude!)
        }
    }
    
    func mapView(mapView: GMSMapView!, didTapInfoWindowOfMarker marker: GMSMarker!) {
        print("should segue")
        dispatch_async(dispatch_get_main_queue()) {
            self.performSegueWithIdentifier("ShowMenu", sender: marker)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowMenu"{
            let menuViewController = segue.destinationViewController as! MenuViewController
            let marker = sender as! GMSMarker
            menuViewController.myMarker = marker
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
