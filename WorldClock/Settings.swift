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
func saveCities(cities: [String]) {
    saveData(data: cities, key: "cities")
}

func loadCities() -> [String] {
    guard let data = loadData(key: "cities", type: [String].self) else {
        return []
    }
    
    return data
}


// Saving and loading accent color
func saveAccentColor(color: NSColor) {
    saveData(data: color, key: "accentColor")
}

func loadAccentColor() -> NSColor {
    guard let data = loadData(key: "accentColor", type: NSColor.self) else {
        return NSColor.red
    }
    
    return data
}


// Saving and loading timeFormat
func saveTimeFormat(enabled: Bool) {
    saveData(data: enabled, key: "twentyFourTimeFormat")
}

func loadTimeFormat() -> Bool {
    guard let data = loadData(key: "twentyFourTimeFormat", type: Bool.self) else {
        return true
    }
    
    return data
}



// Saving and loading master functions.
// Catch all load function
func loadData<T>(key: String, type: T.Type) -> T? {
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
func saveData(data: Any, key: String) {
    let savedData = NSKeyedArchiver.archivedData(withRootObject: data)
    UserDefaults.standard.set(savedData, forKey: key)
}
