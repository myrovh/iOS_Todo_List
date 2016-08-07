//
//  LocationAnnotation.swift
//  Reminder List
//
//  Created by Dyson Talbot Sunderland Hamilton on 8/08/2016.
//  Copyright © 2016 myrovh. All rights reserved.
//

import UIKit
import MapKit

class LocationAnnotation: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title:String?
    var subtitle:String?
    
    init(inputTitle: String, inputSubtitle: String, inputLat: Double, inputLon: Double) {
        title = inputTitle
        subtitle = inputSubtitle
        coordinate = CLLocationCoordinate2D()
        coordinate.latitude = inputLat
        coordinate.longitude = inputLon
    }
}
