//
//  Dispensary.swift
//  nav_test
//
//  Created by mac on 9/14/15.
//  Copyright © 2015 mac. All rights reserved.
//

import Foundation

class Dispensary {
    var id: Int
    var name: String
    var address: String
    var latitude: Double
    var longitude: Double
    var phone: String
    var email: String
    var online_reservation: Int
    var phone_reservation: Int
    
    init(id: Int, name: String, address: String, latitude: Double, longitude: Double, phone: String, email: String, online_reservation: Int, phone_reservation: Int) {
        self.id = id
        self.name = name
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.phone = phone
        self.email = email
        self.online_reservation = online_reservation
        self.phone_reservation = phone_reservation
    }
}