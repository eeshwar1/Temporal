//
//  StatusMenuController.swift
//  Temporal2
//
//  Created by Venky Venkatakrishnan on 7/22/18.
//  Copyright © 2018 Venky UL. All rights reserved.
//

import Cocoa



struct DateTimeFormat {
    static let longDateTime = "E d MMM yyy h:mm:ss a"
    static let shortDateTime = "E d MMM hh:mm a"
    static let shortTime = "hh:mm a"
    static let shortDate =  "MM/dd/yyyy"
}

enum TimeFormat: Int {
    case h12 = 0
    case h24 = 1
}

struct Time {
    var hours: Int
    var minutes: Int
    var seconds: Int
    var timeString: String
}

let DEFAULT_THEME = "Night"
let DEFAULT_TIME_FORMAT: TimeFormat = .h12 // 12h
let DEFAULT_DISPLAY_FORMAT = "Icon"

let MENU_SIZE_ICON: CGFloat = 40
let MENU_SIZE_TIME: CGFloat = 225

class StatusMenuController: NSObject {
    
    
    @IBOutlet weak var statusMenu: NSMenu!
    @IBOutlet weak var temporalView: TemporalView!
    @IBOutlet weak var showAsIconMenu: NSMenuItem!
  
    @IBOutlet weak var themeMenu: NSMenuItem!

    @IBOutlet weak var timeFormatControl: NSSegmentedControl!
    @IBOutlet weak var themeControl: NSSegmentedControl!
    
    var showAsIcon: Bool = true
    
    let kVersion: String = "CFBundleShortVersionString"
    let kBuildNumber: String = "CFBundleVersion"
    
    
    
    let statusItem = NSStatusBar.system.statusItem(withLength: MENU_SIZE_TIME)
    
    let icon = NSImage(named: "Temporal-Icon")
    
    
    var timer = Timer()
 
    let timeFormatter = DateFormatter()
    let dateFormatter = DateFormatter()
    let dateTimeFormatter = DateFormatter()
    
    var temporalMenuItem: NSMenuItem!
    
    var timeFormat: TimeFormat = .h12
    
    @IBAction func quitClicked(_ sender: Any) {
        
        NSApplication.shared.terminate(self)
    }
    
    func getVersion() -> String
    {
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary[kVersion] as! String
        let build = dictionary[kBuildNumber] as! String
        
        return "\(version)(\(build))"
    }
    
    override func awakeFromNib()
    {
    
        // print("awakeFromNib")
        
        let defaults = UserDefaults.standard
        
        statusItem.menu = statusMenu
        statusItem.button?.font = NSFont.monospacedDigitSystemFont(ofSize: 14, weight: .regular)
        let appMenuItem = statusMenu.item(withTitle: "Temporal")
        appMenuItem?.title = "Temporal v\(getVersion())"
        
        temporalMenuItem = statusMenu.item(withTitle: "TemporalView")
        temporalMenuItem.view = temporalView
        
        // Set timer format
        
        let timeFormat = TimeFormat(rawValue: defaults.integer(forKey: "Time Format")) ?? DEFAULT_TIME_FORMAT
        
        timeFormatter.dateFormat = timeFormat == .h12 ? "hh:mm:ss a": "HH:mm:ss"
        
        timeFormatControl.selectSegment(withTag: timeFormat.rawValue)
        
        let displayFormat = defaults.string(forKey: "Display Format") ?? DEFAULT_DISPLAY_FORMAT
        
        self.showAsIcon = displayFormat == "Icon" ? true : false
        
        self.showAsIcon = true
        
        showAsIconMenu.state = self.showAsIcon ? .on : .off
        
        self.icon?.isTemplate = true
        
        if self.showAsIcon {
            
           statusItem.button?.image = icon
           self.statusItem.length = MENU_SIZE_ICON
        }
        else
        {
            self.statusItem.length = MENU_SIZE_TIME
        }
        
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        dateTimeFormatter.dateFormat = DateTimeFormat.shortDateTime
        
        showTime()
        
        // Negative value of timeIntervalcauses the timer to default to 0.1 ms
        timer = Timer.scheduledTimer(timeInterval: 0.5,
                                     target: self,
                                     selector: #selector(showTime),
                                     userInfo: nil,
                                     repeats: true)
        
        
        // add timer to RunLoop for handling during event loops
        RunLoop.current.add(timer, forMode: RunLoop.Mode.eventTracking)
        
       
        
        self.themeControl.segmentCount = Themes.calendarThemeColors.keys.count
        
        var themeIndex = 0
        let themeNames = Themes.calendarThemeColors.keys.sorted()
        for themeName in themeNames
        {
            self.themeControl.setLabel(themeName, forSegment: themeIndex)
            themeIndex = themeIndex + 1
      
        }
        
    
        let theme = defaults.string(forKey: "Theme") ?? DEFAULT_THEME
        self.temporalView.setTheme(theme: theme)
               
        self.themeControl.selectSegment(withLabel: theme)
        
        self.temporalView.calendarViewItem.showToday(self)
        
        updateWindow()
        
    }

    
    @objc func showTime()
    {
        
        let date = Date()
        
        let calendar = Calendar.current
        
        let currentTime = timeFormatter.string(from: date)
      
        
        let hours = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        
        let seconds = calendar.component(.second, from: date)
        
        temporalView.setTime(time: Time(hours: hours, minutes: minutes, seconds: seconds, timeString: currentTime))
        
        // statusItem.title = dateTimeFormatter.string(from: date)
        
        if self.showAsIcon == false {
            statusItem.button?.title = dateTimeFormatter.string(from: date)
        }
        
        
    }
    
    func updateWindow()
    {
    
        let defaults = UserDefaults.standard
        let theme = defaults.string(forKey: "Theme") ?? DEFAULT_THEME
        self.temporalView.setTheme(theme: theme)
        
        let timeFormat = TimeFormat(rawValue: defaults.integer(forKey: "Time Format")) ?? DEFAULT_TIME_FORMAT
            
        timeFormatter.dateFormat = timeFormat == .h12 ? "hh:mm:ss a": "HH:mm:ss"
        
        
    }
    
    // Actions
    
    @IBAction func themeChanged(_ sender: AnyObject)
    {
        
        let themeName = themeControl.label(forSegment: themeControl.selectedSegment)
        
        let defaults = UserDefaults.standard
        defaults.setValue(themeName, forKey: "Theme")
 
        updateWindow()
    }

    
    @IBAction func selectTimeFormat(_ sender: AnyObject) {
        
        let timeFormat = timeFormatControl.selectedSegment
        
        let defaults = UserDefaults.standard
        defaults.setValue(timeFormat, forKey: "Time Format")
        
        updateWindow()
        
        
    }
    
    @IBAction func showAbout(_ sender: AnyObject) {
        
        let aboutWindowController = NSWindowController(windowNibName: "About", owner: self)
        
        aboutWindowController.showWindow(self)
        NSApp.activate(ignoringOtherApps: true)
        
    }
    @IBAction func showAsIconClicked (_ sender: AnyObject)
    {
        
        self.showAsIcon = !self.showAsIcon
        
        self.showAsIconMenu!.state = self.showAsIcon ? .on : .off

        let defaults = UserDefaults.standard

        let displayFormat = self.showAsIcon ? "Icon" : "Text"
        defaults.setValue(displayFormat, forKey: "Display Format")
        
        self.icon?.isTemplate = true
        
        if self.showAsIcon {
            
            statusItem.button?.title = ""
            statusItem.button?.image = icon
            self.statusItem.length = MENU_SIZE_ICON
        }
        else
        {
            statusItem.button?.image = nil
            self.statusItem.length = MENU_SIZE_TIME
        }
        
        
    }

}


