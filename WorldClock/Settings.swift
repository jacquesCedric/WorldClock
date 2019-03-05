//
//  Settings.swift
//  WorldClock
//
//  Created by Jacob Gold on 5/3/19.
//  Copyright © 2019 Jacob Gold. All rights reserved.
//

import Foundation

func saveSettings(cities: [String]) {
    // This function has been deprecated and should be replaced/updated
    let savedCities = NSKeyedArchiver.archivedData(withRootObject: cities)
    UserDefaults.standard.set(savedCities, forKey: "savedCities")
}


func loadSettings() -> [String] {
    guard let savedCities = UserDefaults.standard.object(forKey: "savedCities") as? NSData else {
        print("Could not retrieve saved cities")
        return []
    }
    
    // Deprecated method used below.
    guard let cities = NSKeyedUnarchiver.unarchiveObject(with: savedCities as Data) as? [String] else {
        print("Could not unarachive savedCities data!")
        return []
    }
    
    return cities
}
