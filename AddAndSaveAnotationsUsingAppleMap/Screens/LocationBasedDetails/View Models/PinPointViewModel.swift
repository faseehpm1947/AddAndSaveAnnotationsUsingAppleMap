//
//  PinPointViewModel.swift
//  AddAndSaveAnotationsUsingAppleMap
//
//  Created by Faseeh PM on 17/01/25.
//

import Foundation

class PinPointViewModel {
    
    private(set) var pinPoints: [PinPoint] = [] {
        didSet {
            onPinPointsUpdated?()
        }
    }
    var onPinPointsUpdated: (() -> Void)?
    
    init() {
        pinPoints = AppUserDefaults.loadPinPoints()
    }
    
    func addPinPoint(_ pinPoint: PinPoint) {
        pinPoints.append(pinPoint)
        AppUserDefaults.savePinPoints(pinPoints)
    }
    
    func deletePinPoint(at index: Int) {
        pinPoints.remove(at: index)
        AppUserDefaults.savePinPoints(pinPoints)
    }
}
