//
//  AppUserDefaults.swift
//  AddAndSaveAnotationsUsingAppleMap
//
//  Created by Faseeh PM on 17/01/25.
//

import Foundation

class AppUserDefaults {
    
    private enum Keys {
        static let pinPoints = "pinPoints"
    }
    
    static func savePinPoints(_ pinPoints: [PinPoint]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(pinPoints)
            UserDefaults.standard.set(data, forKey: Keys.pinPoints)
        } catch {
            print("Failed to save pin points: \(error.localizedDescription)")
        }
    }
    
    static func loadPinPoints() -> [PinPoint] {
        if let data = UserDefaults.standard.data(forKey: Keys.pinPoints) {
            do {
                let decoder = JSONDecoder()
                return try decoder.decode([PinPoint].self, from: data)
            } catch {
                print("Failed to load pin points: \(error.localizedDescription)")
            }
        }
        return []
    }
}
