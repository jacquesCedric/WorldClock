//
//  Settings.swift
//  WorldClock
//
//  Created by Jacob Gold on 5/3/19.
//  Copyright © 2019 Jacob Gold. All rights reserved.
//

import Foundation
import AppKit

// Saving and loading cities list
func saveCitiesToPreferences(cities: [String]) {
    saveData(data: cities, key: "cities")
}

func loadCitiesFromPreferences() -> [String] {
    guard let data = loadData(key: "cities", type: [String].self) else {
        return []
    }
    
    return data
}


// Saving and loading accent color
func saveAccentColorToPreferences(color: NSColor) {
    saveData(data: color, key: "accentColor")
}

func loadAccentColorFromPreferences() -> NSColor {
    guard let data = loadData(key: "accentColor", type: NSColor.self) else {
        return NSColor.red
    }
    
    return data
}


// Saving and loading timeFormat
func saveTimeFormatToPreferences(enabled: Bool) {
    saveData(data: enabled, key: "twentyFourTimeFormat")
}

func loadTimeFormatFromReferences() -> Bool {
    guard let data = loadData(key: "twentyFourTimeFormat", type: Bool.self) else {
        return true
    }
    
    return data
}



// Saving and loading master functions.
// Catch all load function
fileprivate func loadData<T>(key: String, type: T.Type) -> T? {
    guard let savedData = UserDefaults.standard.object(forKey: key) as? NSData else {
        print("Could not retrieve saved cities")
        return nil
    }
    
    guard let retrievedData = NSKeyedUnarchiver.unarchiveObject(with: savedData as Data) as? T else {
        print("Could not unarachive cities data!")
        return nil
    }
    
    return retrievedData
}


// Catch all save function
fileprivate func saveData(data: Any, key: String) {
    let savedData = NSKeyedArchiver.archivedData(withRootObject: data)
    UserDefaults.standard.set(savedData, forKey: key)
}
