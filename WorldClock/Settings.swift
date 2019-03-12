//
//  Settings.swift
//  WorldClock
//
//  This class handles all the ins and outs of settings
//
//  Created by Jacob Gold on 5/3/19.
//  Copyright © 2019 Jacob Gold. All rights reserved.
//

import Foundation
import AppKit

class Settings {
    enum TimeHourFormat: String {
        case twelveHour = "hh:mma"
        case twentyFourHour = "HH:mm"
    }
    
    enum MenuTitleDisplayType: Int {
        case systemTime = 0
        case appName
        case icon
    }
    
    // Saving and loading cities list
    static func saveCitiesToPreferences(cities: [String]) {
        saveData(data: cities, key: "cities")
    }

    static func loadCitiesFromPreferences() -> [String] {
        guard let data = loadData(key: "cities", type: [String].self) else {
            return []
        }
        
        return data
    }
    
    
    // Saving and loading timeFormat
    static func saveTimeFormatToPreferences(hourformat: TimeHourFormat.RawValue) {
        saveData(data: hourformat, key: "twentyFourTimeFormat")
    }
    
    static func loadTimeFormatFromPreferences() -> TimeHourFormat {
        guard let data = loadData(key: "twentyFourTimeFormat", type: TimeHourFormat.RawValue.self) else {
            return TimeHourFormat.twentyFourHour
        }
        
        return Settings.TimeHourFormat(rawValue: data)!
    }


    // Saving and loading accent color
    static func saveAccentColorToPreferences(color: NSColor) {
        saveData(data: color, key: "accentColor")
    }

    static func loadAccentColorFromPreferences() -> NSColor {
        guard let data = loadData(key: "accentColor", type: NSColor.self) else {
            return NSColor.red
        }
        
        return data
    }
    
    // Sacving and loading Menu Title
    static func saveMenuTitleDisplayType(menuTitle: MenuTitleDisplayType.RawValue) {
        saveData(data: menuTitle, key: "menuTitleDisplayType")
    }
    
    static func loadMenuTitleDisplayType() -> MenuTitleDisplayType {
        guard let data = loadData(key: "menuTitleDisplayType", type: MenuTitleDisplayType.RawValue.self) else {
            return MenuTitleDisplayType.systemTime
        }
        
        return Settings.MenuTitleDisplayType(rawValue: data)!
    }

    

    // Saving and loading master functions.
    fileprivate static func loadData<T>(key: String, type: T.Type) -> T? {
        guard let savedData = UserDefaults.standard.object(forKey: key) as? NSData else {
            print("Could not retrieve saved data: \(key)")
            return nil
        }
        
        guard let retrievedData = NSKeyedUnarchiver.unarchiveObject(with: savedData as Data) as? T else {
            print("Could not unarachive: \(key) data!")
            return nil
        }
        
        return retrievedData
    }

    // Catch all save function
    fileprivate static func saveData(data: Any, key: String) {
        let savedData = NSKeyedArchiver.archivedData(withRootObject: data)
        UserDefaults.standard.set(savedData, forKey: key)
    }
}
