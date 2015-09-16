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
        marker.userData = 63348
        
        mapView.delegate = self
        
    }
    
    func mapView(mapView: GMSMapView!, didTapInfoWindowOfMarker marker: GMSMarker!) {
        performSegueWithIdentifier("ShowMenu", sender: marker)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
