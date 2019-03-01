//
//  Timezones.swift
//  WorldClock
//
//  Created by Jacob Gold on 26/2/19.
//  Copyright © 2019 Jacob Gold. All rights reserved.
//

import Foundation

var allTimezones: [CityTime] {
    return TimeZone.knownTimeZoneIdentifiers.map { CityTime(timezoneID: $0 )}
}

struct CityTime {
    let timezoneID: String
    
    func city() -> String {
        if let cityName = timezoneID.split(separator: "/").last {
            return cityName.replacingOccurrences(of: "_", with: " ")
        }
        return "Invalid timezone"
    }
    
    func date() -> String {
        let df = DateFormatter()
        df.timeZone = TimeZone(identifier: timezoneID)
        
        // Setup dates string
        df.dateFormat = "EEE, MMMM d"
        return df.string(from: Date())
    }
    
    func time() -> String {
        // Setup timezone
        let df = DateFormatter()
        df.timeZone = TimeZone(identifier: timezoneID)
        
        // Setup time string
        df.dateFormat = "HH:mm"
        return df.string(from: Date())
    }
}
