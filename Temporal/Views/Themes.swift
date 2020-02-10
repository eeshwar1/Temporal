//
//  Themes.swift
//  Temporal
//
//  Created by Venky Venkatakrishnan on 2/9/20.
//  Copyright © 2020 Venky UL. All rights reserved.
//

import Foundation
import Cocoa

enum Themes
{
    static let calendarThemeColors =
        
        ["Night":  ["backgroundColor":  NSColor.black,
                     "textColor": NSColor.white,
                     "titleTextColor": NSColor.white,
                     "highlightColor": NSColor.brown,
                     "textHighlightColor": NSColor.brown,
                     "secondaryTextColor": NSColor.lightGray],
        "Daylight": ["backgroundColor": NSColor.lightGray,
                     "textColor": NSColor.black,
                     "titleTextColor": NSColor.white,
                     "highlightColor": NSColor.red,
                     "textHighlightColor": NSColor.red,
                     "secondaryTextColor": NSColor.white],
        "Rainy":  ["backgroundColor": NSColor.lightGray,
                     "textColor": NSColor.black,
                     "titleTextColor": NSColor.white,
                     "highlightColor": NSColor.purple,
                     "textHighlightColor": NSColor.purple,
                     "secondaryTextColor": NSColor.darkGray],
        "System": ["backgroundColor" : NSColor.controlColor,
                   "textColor": NSColor.black,
                   "titleTextColor": NSColor.white,
                   "highlightColor": NSColor.headerColor,
                   "textHighlightColor": NSColor.systemBlue,
                   "secondaryTextColor": NSColor.lightGray]]


}
