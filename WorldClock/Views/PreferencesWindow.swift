//
//  PreferencesWindow.swift
//  WorldClock
//
//  Created by Jacob Gold on 2/3/19.
//  Copyright © 2019 Jacob Gold. All rights reserved.
//

import Cocoa

class PreferencesWindow: NSWindowController {
    
    @IBOutlet var citiesTokenField: NSTokenField!
    
    override var windowNibName: NSNib.Name? {
        return "PreferencesWindow"
    }

    override func windowDidLoad() {
        super.windowDidLoad()

        self.window?.center()
        self.window?.makeKeyAndOrderFront(nil)
        NSApp.activate(ignoringOtherApps: true)
        
        citiesTokenField.convertToACBTokenField()
        populateAndConfigureCitiesList()
        
        loadPreferences()
    }
    
    func populateAndConfigureCitiesList() {
        let cities: [String] = allTimezones.map { $0.city }
        citiesTokenField.defaultTokenKeywords = cities
    }
    
    @IBAction func savePreferences(_ sender: Any) {
        // Cast the tags to NSArray, as otherwise __NSArrayI is returned
        let rawTags = citiesTokenField.objectValue as! NSArray

        // Pull the names from the custom ACBTokens
        let cleanTags: [String] = rawTags.map{ ($0 as! ACBToken).name }
        
        // Consider checking tags to see if they're valid before saving them?
        
        saveSettings(cities: cleanTags)
    }
    
    func loadPreferences() {
        let cities: [String] = loadSettings()
        
        _ = cities.map{ citiesTokenField.addToken(name: $0) }
    }
}
