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
    @IBOutlet var accentColorWell: NSColorWell!
    
    override var windowNibName: NSNib.Name? {
        return "PreferencesWindow"
    }

    override func windowDidLoad() {
        super.windowDidLoad()
        
        citiesTokenField.convertToACBTokenField()
        populateTokensWithCitiesListForACBTokenField()
        
        loadCities()
        loadAccentColor()
    }
    
    override func showWindow(_ sender: Any?) {
        super.showWindow(sender)
        self.window?.center()
        self.window?.makeKeyAndOrderFront(nil)
        self.window?.orderedIndex = 0
        NSApp.activate(ignoringOtherApps: true)
    }
    
    
    
    func populateTokensWithCitiesListForACBTokenField() {
        let cities: [String] = allTimezones.map { $0.city }
        citiesTokenField.defaultTokenKeywords = cities
    }
    
    @IBAction func savePreferences(_ sender: Any) {
        saveCities()
        saveAccentColor()
        self.close()
    }
    
    
    // MARK: Cities Preferences
    // Save city list to
    func saveCities() {
        // Cast the tags to NSArray, as otherwise __NSArrayI is returned
        let rawTags = citiesTokenField.objectValue as! NSArray
        
        // Pull the names from the custom ACBTokens
        let cleanTags: [String] = rawTags.map{ ($0 as! ACBToken).name }
        
        // Consider checking tags to see if they're valid before saving them?
        saveCitiesToPreferences(cities: cleanTags)
        NotificationCenter.default.post(name: Notification.Name("WorldClockCitiesListUpdated"), object: nil)
    }
    
    func loadCities() {
        let cities: [String] = loadCitiesFromPreferences()
        _ = cities.map{ citiesTokenField.addToken(name: $0) }
    }
    
    // MARK: Accent Preferences
    func saveAccentColor() {
        saveAccentColorToPreferences(color: accentColorWell.color)
        NotificationCenter.default.post(name: Notification.Name("WorldClockAccentColorUpdated"), object: nil)
    }
    
    func loadAccentColor() {
        accentColorWell.color = loadAccentColorFromPreferences()
    }
    
}
