//
//  ClockMenuController.swift
//  WorldClock
//
//  Created by Jacob Gold on 25/2/19.
//  Copyright © 2019 Jacob Gold. All rights reserved.
//

import Cocoa

struct CityTime {
    let date: String
    let time: String
}

class ClockMenuController: NSObject {
    
    // MARK: GUI stuff
    @IBOutlet weak var statusMenu: NSMenu!
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

    override func awakeFromNib() {
        statusItem.button?.title = "WorldClock"
        statusItem.menu = statusMenu
        
        let tzs = returnTimeZoneIDcityNameDictionary()
        print(dateFromTimeZone(tzID: tzs[1].timezone))
    }
    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
    
    
    // MARK: Time related things
    /**
     Grab a list of timezone IDs
     - Returns: An array of TimeZones
     - Note: Timezone IDs have the format "America/Los_Angeles"
     */
    func returnListOfTimeZones() -> [String] {
        return TimeZone.knownTimeZoneIdentifiers
    }
    
    /**
     Grab a list of capital cities for finding timezones
     - Parameters:
        - timeZoneIdentifiers: An array of TimeZone IDs.
     - Returns: An array of cities
     - Note: See ```returnListOfTimezones()``` for more details on TimeZone IDs
     */
    func returnListOfCities(timeZoneIdentifiers: [String]) -> [String] {
        var allCities: [String] = []
        for identifier in timeZoneIdentifiers {
            if let cityName = identifier.split(separator: "/").last {
                let cleanName = cityName.replacingOccurrences(of: "_", with: " ")
                allCities.append("\(cleanName)")
            }
        }
        
        return allCities
    }
    
    /**
     Grab a Dictionary wherein keys are TimeZone IDs and city names are the value
     - Returns: A Dictionary where TimeZone IDs are Keys and city names are the Value
     */
    func returnTimeZoneIDcityNameDictionary() -> [(timezone: String, city: String)] {
        let timeZones = returnListOfTimeZones()
        let cities = returnListOfCities(timeZoneIdentifiers: timeZones)
        
        return Array(zip(timeZones, cities))
    }
    
    func dateFromTimeZone(tzID: String) -> CityTime {
        // Setup timezone
        let df = DateFormatter()
        df.timeZone = TimeZone(identifier: tzID)
        
        // Setup dates
        df.dateFormat = "EEE, MMMM d"
        let dateStr = df.string(from: Date())
        
        // Setup time
        df.dateFormat = "HH:MM"
        let timeStr = df.string(from: Date())
        
        return CityTime(date: dateStr, time: timeStr)
    }
    
}
