//
//  TodayViewController.swift
//  TemporalToday
//
//  Created by Venky Venkatakrishnan on 10/9/18.
//  Copyright © 2018 Venky UL. All rights reserved.
//

import Cocoa
import NotificationCenter

let DEFAULT_THEME = "Night"

class TodayViewController: NSViewController, NCWidgetProviding {
    
    @IBOutlet weak var calendarView: CalendarView!

    override var nibName: NSNib.Name? {
        return NSNib.Name("TodayViewController")
    }

    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Update your data and prepare for a snapshot. Call completion handler when you are done
        // with NoData if nothing has changed or NewData if there is new data since the last
        // time we called you
        
    
        completionHandler(.noData)
    }

}
