//
//  ClockView.swift
//  WorldClock
//
//  Created by Jacob Gold on 27/2/19.
//  Copyright © 2019 Jacob Gold. All rights reserved.
//

import Cocoa

class ClockView: NSView {
    var thisCity = allTimezones[0]
    var timer = Timer()
    
    var cityLabel: NSTextField = NSTextField(labelWithString: "")
    var dateLabel: NSTextField = NSTextField(labelWithString: "")
    var timeLabel: NSTextField = NSTextField(labelWithString: "")
    
    override init(frame frameRect: NSRect) {
        super.init(frame:frameRect);
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //or customized constructor/ init
    init(city: CityTime) {
        thisCity = city
        
        // Interface elements
        cityLabel.stringValue = city.city
        
        // Clock size
        let size = NSRect(x: 0, y: 0, width: 340, height: 60)
        
        // Styling
        cityLabel.font = NSFont.systemFont(ofSize: 23)
        dateLabel.font = NSFont.systemFont(ofSize: 13)
        timeLabel.font = NSFont.systemFont(ofSize: 51, weight: .light)
        timeLabel.alignment = .right
        
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
        clockStack.addView(leftStack, in: .leading)
        clockStack.addView(timeLabel, in: .trailing)
        clockStack.orientation = .horizontal
        clockStack.alignment = .centerY
        clockStack.distribution = .equalSpacing
        clockStack.spacing = 10
        clockStack.translatesAutoresizingMaskIntoConstraints = false
        
        // Pushing it out
        super.init(frame: size)
        
        // This timer keeps the time up to date.
        // Adding the timer to the Common Run Loop is necessary as this custom view exists in a menu
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateStrings), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .common)
        
        // Wrap up
        self.addSubview(clockStack)
        
        // Final constraints
        let views: [String: Any] = ["clockStack": clockStack]
        var allConstraints: [NSLayoutConstraint] = []
        
        let horizontalConstraint = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-[clockStack]-|",
            options: .alignAllCenterY,
            metrics: nil, views: views)
        
        allConstraints += horizontalConstraint
        NSLayoutConstraint.activate(allConstraints)
    }
    
    @objc func updateStrings() {
        let accentColor = loadAccentColorFromPreferences()
        let dateString = NSMutableAttributedString(attributedString: NSAttributedString(string: thisCity.date))
        dateString.addAttribute(NSAttributedString.Key.foregroundColor, value: accentColor, range: NSRange(location: 0, length: 3))
        
        timeLabel.stringValue = thisCity.time
        dateLabel.attributedStringValue = dateString
    }
}
