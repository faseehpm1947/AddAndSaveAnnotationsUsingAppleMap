//
//  PinPoint.swift
//  AddAndSaveAnotationsUsingAppleMap
//
//  Created by Faseeh PM on 17/01/25.
//

import Foundation
import CoreLocation

struct PinPoint: Codable {
    let title: String
    let description: String
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
}

