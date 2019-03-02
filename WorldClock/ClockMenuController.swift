//
//  ClockMenuController.swift
//  WorldClock
//
//  Created by Jacob Gold on 25/2/19.
//  Copyright © 2019 Jacob Gold. All rights reserved.
//

import Cocoa

let cities = [allTimezones[0], allTimezones[3], allTimezones[100], allTimezones[40]]

class ClockMenuController: NSObject {

    // MARK: GUI stuff
    @IBOutlet weak var statusMenu: NSMenu!
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    // Preferences Window
    var preferencesWindow: PreferencesWindow!

    override func awakeFromNib() {
        statusItem.button?.title = "WorldClock"
        statusItem.menu = statusMenu
        addClocksToMenu()
        
        preferencesWindow = PreferencesWindow()
    }
    
    @IBAction func preferencesClicked(_ sender: NSMenuItem) {
        preferencesWindow.showWindow(nil)
    }
    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
    
    func addClocksToMenu() {
        _ = cities.map{ addClock(city: $0) }
    }
    
    func addClock(city: CityTime) {
        let seperator = NSMenuItem.separator()
        statusMenu.insertItem(seperator, at: 0)
        
        let clock = NSMenuItem(title: "Clock", action: nil, keyEquivalent: "")
        clock.view = ClockView.init(city: city)
        statusMenu.insertItem(clock, at: 0)
    }
}
