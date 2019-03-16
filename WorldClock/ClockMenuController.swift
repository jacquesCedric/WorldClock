//
//  ClockMenuController.swift
//  WorldClock
//
//  Created by Jacob Gold on 25/2/19.
//  Copyright © 2019 Jacob Gold. All rights reserved.
//

import Cocoa

class ClockMenuController: NSObject {
    let systemCity = CityTime.init(timezoneID: TimeZone.current.identifier)
    var cities: [CityTime] = []
    var currentClocks: [NSMenuItem] = []
    var timer: Timer = Timer()

    // MARK: GUI stuff
    @IBOutlet weak var statusMenu: NSMenu!
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    
    // Preferences Window
    var preferencesWindow: PreferencesWindow!

    override func awakeFromNib() {
        setMenuTitle()
        statusItem.menu = statusMenu
        addClocksToMenu()
        preferencesWindow = PreferencesWindow()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.refresh), name: Notification.Name("WorldClockCitiesListUpdated"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.refresh), name: Notification.Name("WorldClockAccentColorUpdated"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.setMenuTitle), name: Notification.Name("WorldClockMenuTitleStyleUpdated"), object: nil)
    }
    
    @IBAction func preferencesClicked(_ sender: NSMenuItem) {
        preferencesWindow.showWindow(nil)
    }
    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
    
    func addClocksToMenu() {
        // Reverse the cities array so it matches preferences input order
        cities = retrieveSavedCities().reversed()
        _ = cities.map{ addClock(city: $0) }
    }
    
    func addClock(city: CityTime) {
        let seperator = NSMenuItem.separator()
        statusMenu.insertItem(seperator, at: 0)
        
        let clock = NSMenuItem(title: "Clock", action: nil, keyEquivalent: "")
        clock.view = ClockView.init(city: city)
        currentClocks.append(clock)
        statusMenu.insertItem(clock, at: 0)
    }
    
    @objc func refresh() {
        _ = currentClocks.map{ statusMenu.removeItem($0) }
        currentClocks = []
        addClocksToMenu()
    }
    
    @objc func setMenuTitle() {
        let menuStyle = Settings.loadMenuTitleDisplayType()
        
        if menuStyle != .systemTime {
            timer.invalidate()
            timer = Timer()
        }
        
        switch menuStyle {
        case .systemTime:
            statusItem.button?.title = "System Time"
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(testMenu), userInfo: nil, repeats: true)
        case .appName:
            statusItem.button?.title = "WorldClock"
        case .icon:
            statusItem.button?.title = "🕙"
        }
    }
    
    @objc func testMenu() {
        statusItem.button?.title = systemCity.time
    }
}
