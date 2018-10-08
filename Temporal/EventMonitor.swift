//
//  EventMonitor.swift
//  Temporal2
//
//  Created by Venky Venkatakrishnan on 9/22/18.
//  Copyright © 2018 Venky UL. All rights reserved.
//

import Cocoa

class EventMonitor {
    
    private var monitor: Any?
    private let mask: NSEvent.EventTypeMask
    
    private let handler: (NSEvent?) -> Void
    
    public init(mask: NSEvent.EventTypeMask, handler: @escaping (NSEvent?) -> Void)
    {
        self.mask = mask
        self.handler = handler
        print("Event Monitor initialized")
    }
    
    deinit {
        stop()
    }
    
    public func start() {
        monitor = NSEvent.addGlobalMonitorForEvents(matching: mask, handler: handler)
    }
    
    public func stop() {
        
        if monitor != nil {
            NSEvent.removeMonitor(monitor!)
            monitor = nil   
        }
    }
    

}
