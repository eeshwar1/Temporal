//
//  NSSegmentedControl+Extensions.swift
//  Temporal
//
//  Created by Venky Venkatakrishnan on 4/7/20.
//  Copyright © 2020 Venky UL. All rights reserved.
//

import Cocoa

extension NSSegmentedControl {
    
    func selectSegment(withLabel label: String)
    {
        guard self.segmentCount > 0 else {
            return
        }
        
        for seg in 0...self.segmentCount - 1 {
            if self.label(forSegment: seg) == label {
                self.setSelected(true, forSegment: seg)
                break
            }
        }
        return
    }
    
}


