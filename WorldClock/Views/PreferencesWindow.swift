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
    }
    
    func populateAndConfigureCitiesList() {
        let cities: [String] = allTimezones.map { $0.city() }
        citiesTokenField.defaultTokenKeywords = cities
    }
}
