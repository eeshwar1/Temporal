//
//  TemporalView.swift
//  Temporal2
//
//  Created by Venky Venkatakrishnan on 7/22/18.
//  Copyright © 2018 Venky UL. All rights reserved.
//

import Cocoa



class TemporalView: NSView {

    @IBOutlet weak var clockLabel: NSTextField!
    
    // @IBOutlet weak var clockView: ClockView!
    
    @IBOutlet var calendarViewItem: CalendarView!
    
    
    
    
    required init?(coder decoder: NSCoder) {
        
        super.init(coder: decoder)
     
        self.calendarViewItem = CalendarView()

    
    }
    
    required override init(frame frameRect: NSRect) {
       
        super.init(frame: frameRect)
       
        
        self.calendarViewItem = CalendarView()
        
        
    }
    
    func setTime(time: Time)
    {
        self.clockLabel.stringValue = time.timeString
        
        // self.clockView.setTime(hours: time.hours, minutes: time.minutes, seconds: time.seconds)
        
        self.calendarViewItem.setToday()
        
        self.setNeedsDisplay(bounds)
      
    }
    
    func setTheme(theme: String)
    {
        // self.clockView.setTheme(theme: theme)
        self.calendarViewItem.setTheme(theme: theme)
    }
    
}
