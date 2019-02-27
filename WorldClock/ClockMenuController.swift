//
//  ClockMenuController.swift
//  WorldClock
//
//  Created by Jacob Gold on 25/2/19.
//  Copyright © 2019 Jacob Gold. All rights reserved.
//

import Cocoa

class ClockMenuController: NSObject {
    
    // MARK: GUI stuff
    @IBOutlet weak var statusMenu: NSMenu!
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

    override func awakeFromNib() {
        statusItem.button?.title = "WorldClock"
        statusItem.menu = statusMenu
        addClocksToMenu()
    }
    
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
    
    func addClocksToMenu() {
        let clock = NSMenuItem(title: "Clock", action: nil, keyEquivalent: "")
        clock.view = ClockView.init(city: allTimezones[0])
        
        statusMenu.insertItem(clock, at: 0)
    }
}
