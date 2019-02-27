//
//  ClockView.swift
//  WorldClock
//
//  Created by Jacob Gold on 27/2/19.
//  Copyright © 2019 Jacob Gold. All rights reserved.
//

import Cocoa

class ClockView: NSView {
    
    override init(frame frameRect: NSRect) {
        super.init(frame:frameRect);
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //or customized constructor/ init
    init(city: CityTime) {
        // Interface elements
        let cityLabel: NSTextField = NSTextField(labelWithString: city.city())
        let dateLabel: NSTextField = NSTextField(labelWithString: city.date())
        let timeLabel: NSTextField = NSTextField(labelWithString: city.time())
        // Clock size
        let size = NSRect(x: 0, y: 0, width: 340, height: 70)
        
        
        // Styling
        for label in [dateLabel, timeLabel, cityLabel] {
            label.isEditable = false
            label.isSelectable = false
            label.drawsBackground = false
            label.isBordered = false
        }
        
        cityLabel.font = NSFont.systemFont(ofSize: 23)
        dateLabel.font = NSFont.systemFont(ofSize: 13)
        timeLabel.font = NSFont.systemFont(ofSize: 51, weight: .light)
        
        // Grouping UI elements
        let leftStack = NSStackView()
        leftStack.addView(cityLabel, in: .top)
        leftStack.addView(dateLabel, in: .bottom)
        leftStack.orientation = .vertical
        leftStack.distribution = .fill
        leftStack.spacing = 4
        leftStack.alignment = .leading
        leftStack.translatesAutoresizingMaskIntoConstraints = false
        
        let clockStack = NSStackView()
        clockStack.edgeInsets = NSEdgeInsets(top: 12, left: 10, bottom: 10, right: 10)
        clockStack.addView(leftStack, in: .leading)
        clockStack.addView(timeLabel, in: .trailing)
        clockStack.orientation = .horizontal
        clockStack.alignment = .centerY
        clockStack.distribution = .equalSpacing
        clockStack.spacing = 59
        clockStack.translatesAutoresizingMaskIntoConstraints = false
        
        // Pushing it out
        super.init(frame: size)
        self.addSubview(clockStack)
    }
}
