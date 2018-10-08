//
//  ClockView.swift
//  Temporal2
//
//  Created by Venky Venkatakrishnan on 6/9/18.
//  Copyright © 2018 Venky UL. All rights reserved.
//

import Cocoa



@IBDesignable

class ClockView: NSView {

    var hoursHandLength: CGFloat = 80.0
    var minutesHandLength: CGFloat = 110.0
    var secondsHandLength: CGFloat = 120.0
    
    var timeHours: CGFloat = 0
    var timeMinutes: CGFloat = 0
    var timeSeconds: CGFloat = 0
    
    
    var borderColor: NSColor = NSColor.yellow
    var backgroundColor: NSColor = NSColor.black
    var centerPinColor: NSColor = NSColor.gray
    var centerPinBorderColor: NSColor = NSColor.yellow
    var hoursHandColor: NSColor = NSColor.green
    var minutesHandColor: NSColor = NSColor.orange
    var secondsHandColor: NSColor = NSColor.red
 

    /*
    var borderColor: NSColor
    var backgroundColor: NSColor
    var centerPinColor: NSColor
    var centerPinBorderColor: NSColor
    var hoursHandColor: NSColor
    var minutesHandColor: NSColor
    var secondsHandColor: NSColor */
    
    var clockTheme: String = ""

    
    static fileprivate let clockThemeColors = ["Night": ["background":        NSColor.black,
                                                    "border": NSColor.yellow,
                                                    "hours": NSColor.green,
                                                    "minutes":NSColor.orange,
                                                    "seconds": NSColor.red,
                                                    "centerPin": NSColor.gray,
                                                    "centerPinBorder": NSColor.darkGray],
                                        "Rainy": ["background": NSColor.gray,
                                                    "border": NSColor.white,
                                                    "hours": NSColor.blue,
                                                    "minutes": NSColor.purple,
                                                    "seconds": NSColor.cyan,
                                                    "centerPin": NSColor.white,
                                                    "centerPinBorder": NSColor.white],
                                        "Daylight": ["background": NSColor.white,
                                                    "border": NSColor.gray,
                                                    "hours": NSColor.darkGray,
                                                    "minutes": NSColor.cyan,
                                                    "seconds": NSColor.purple,
                                                    "centerPin": NSColor.brown,
                                                    "centerPinBorder": NSColor.black]]
    
    
    class func getThemes() -> [String]
    {
        return Array(clockThemeColors.keys).sorted()
    }
    
    required init?(coder decoder: NSCoder)
    {
        super.init(coder: decoder)
        if self.clockTheme == ""
        {
            self.setTheme(theme: DEFAULT_THEME)
        }
        
    }
    override func draw(_ dirtyRect: NSRect) {
        
        super.draw(dirtyRect)

        // Drawing code here.
        
        // Clock Face is inset by 5
        let clockFaceRect = bounds.insetBy(dx: CGFloat(5.0), dy: CGFloat(5.0))
        
        drawClockFace(clockFaceRect: clockFaceRect)
        
    }
    
    func drawClockFace(clockFaceRect: CGRect)
    {
        let circle = NSBezierPath(ovalIn: clockFaceRect)
        borderColor.setStroke()
        backgroundColor.setFill()
        circle.stroke()
        circle.fill()
        
     
        self.hoursHandLength = 0.3 * clockFaceRect.height
        self.minutesHandLength = 0.4 * clockFaceRect.height
        self.secondsHandLength = 0.45 * clockFaceRect.height
        
        let centerPoint = CGPoint(x: clockFaceRect.midX,
                                  y: clockFaceRect.midY)
        
        let faceRadius = clockFaceRect.width / 2
     
        
        let points = circleCircumferencePoints(sides: 60,
                                               x: centerPoint.x,
                                               y: centerPoint.y,
                                               radius: faceRadius)
        
        
        
        borderColor.setStroke()
        
        var angle: CGFloat = 0
        var divider: CGFloat = 1/16
        for (index, point) in points.enumerated()
        {
            let marker = NSBezierPath()
            
            if index % 5 == 0
            {
                divider = 1/8
                
            }
            else
            {
                divider = 1/16
            }
            
            marker.move(to: CGPoint(x: point.x + (faceRadius) * divider * cos(toRadians(degrees: angle)),
                                    y: point.y - (faceRadius) * divider * sin(toRadians(degrees: angle))))
            
            marker.line(to: CGPoint(x: point.x , y: point.y))
            
            marker.stroke()
            
            angle = angle + 6
            
     
            
        }
        
        /*
         
         let textPoints = circleCircumferencePoints(sides: 60,
         x: centerPoint.x,
         y: centerPoint.y,
         radius: faceRadius * 0.8,
         adjustment: 270)
         
        let ctx = NSGraphicsContext.current?.cgContext
        
        ctx?.translateBy(x: 0.0, y: clockFaceRect.height)
        
        ctx?.scaleBy(x: 1.0, y: -1.0)
        
        for (index, textPoint) in textPoints.enumerated()
        {
            let aFont = NSFont(name: "Optima", size: 2)
            
            let attr: CFDictionary =
                [NSAttributedString.Key.font: aFont!, NSAttributedString.Key.foregroundColor: NSColor.white] as CFDictionary
            
            if index % 5 == 0
                
            {
                let timeText = index / 5 + 1
                
                let text = CFAttributedStringCreate(nil, timeText.description as CFString, attr)
                
                print("timeText: \(timeText.description)")
                
                let line = CTLineCreateWithAttributedString(text!)
                
                let lineBounds = CTLineGetBoundsWithOptions(line, CTLineBoundsOptions.useOpticalBounds)
                
                ctx?.setLineWidth(2)
                
                ctx?.setTextDrawingMode(.stroke)
                
                let xn = textPoint.x - lineBounds.width / 2
                let yn = textPoint.y - lineBounds.midY
                
                ctx?.textPosition = CGPoint(x: xn, y: yn)
                
                CTLineDraw(line, ctx!)
            }
        }
        
        */
        let hoursHand = NSBezierPath()
        let hoursAngle: CGFloat =  ((self.timeHours - 3)/12) * 360 + self.timeMinutes * 0.5
        let hoursHandEndPoint = CGPoint(x: clockFaceRect.midX + hoursHandLength *  cos(toRadians(degrees: hoursAngle)),
                                        y: clockFaceRect.midY -  hoursHandLength * sin(toRadians(degrees: hoursAngle)))
        hoursHand.move(to: centerPoint)
        hoursHand.line(to: hoursHandEndPoint)
        hoursHandColor.setStroke()
        hoursHand.lineWidth = 3
        hoursHand.stroke()
        
        let minutesHand = NSBezierPath()
        let minutesAngle: CGFloat = ((self.timeMinutes - 15)/60) * 360
        let minutesHandEndPoint =  CGPoint(x: clockFaceRect.midX + minutesHandLength * cos(toRadians(degrees: minutesAngle)),
                                           y: clockFaceRect.midY -  minutesHandLength * sin(toRadians(degrees: minutesAngle)))
        minutesHand.move(to: centerPoint)
        minutesHand.line(to: minutesHandEndPoint)
        minutesHandColor.setStroke()
        minutesHand.lineWidth = 2
        minutesHand.stroke()
        
        let secondsHand = NSBezierPath()
        let secondsAngle: CGFloat = ((self.timeSeconds - 15)/60) * 360
        let secondsHandEndPoint =  CGPoint(x: clockFaceRect.midX + secondsHandLength * cos(toRadians(degrees: secondsAngle)),
                                           y: clockFaceRect.midY -  secondsHandLength * sin(toRadians(degrees: secondsAngle)))
        secondsHand.move(to: centerPoint)
        secondsHand.line(to: secondsHandEndPoint)
        secondsHandColor.setStroke()
        secondsHand.stroke()
        
        
        
        let centerRect = CGRect(origin: CGPoint(x: centerPoint.x - 5, y: centerPoint.y - 5), size: CGSize(width: 10, height: 10))
        let centerCircle = NSBezierPath(ovalIn: centerRect)
        centerPinBorderColor.setStroke()
        centerPinColor.setFill()
        centerCircle.stroke()
        centerCircle.fill()
        
    }
       
    func setTime(hours: Int, minutes: Int, seconds: Int)
    {
        self.timeHours = CGFloat(hours)
        self.timeMinutes = CGFloat(minutes)
        self.timeSeconds = CGFloat(seconds)
        
        self.setNeedsDisplay(bounds)

    }
    
    func setTheme(theme: String)
    {
        
        if let themeColors = ClockView.clockThemeColors[theme]
        {
            self.clockTheme = theme
            self.backgroundColor = themeColors["background"]!
            self.borderColor = themeColors["border"]!
            self.hoursHandColor = themeColors["hours"]!
            self.minutesHandColor = themeColors["minutes"]!
            self.secondsHandColor = themeColors["seconds"]!
            self.centerPinColor = themeColors["centerPin"]!
            self.centerPinBorderColor = themeColors["centerPinBorder"]!
            self.setNeedsDisplay(bounds)
        
        }
        
        
    }
    
}


func circleCircumferencePoints(sides: Int, x: CGFloat, y: CGFloat,radius: CGFloat,adjustment: CGFloat = 0) -> [CGPoint]
{
    let angle = toRadians(degrees: 360/CGFloat(sides))
    let cx = x // x origin
    let cy = y // y origin
    let r  = radius // radius of circle
    var i = sides
    var points = [CGPoint]()
    while points.count <= sides {
        let xpo = cx - r * cos(angle * CGFloat(i) + toRadians(degrees: adjustment))
        let ypo = cy - r * sin(angle * CGFloat(i) + toRadians(degrees: adjustment))
        points.append(CGPoint(x: xpo, y: ypo))
        i = i - 1
    }
    return points
}

func toRadians(degrees: CGFloat) -> CGFloat {
    
    return CGFloat.pi * degrees / 180
    
}


