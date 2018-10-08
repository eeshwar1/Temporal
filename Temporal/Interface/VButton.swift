//
//  VButton.swift
//  CustomControls
//
//  Created by Venky Venkatakrishnan on 8/6/18.
//  Copyright © 2018 Venky UL. All rights reserved.
//

import Cocoa

@IBDesignable

class VButton: NSButton {

    @IBInspectable var backColor: NSColor = NSColor.black
    
    @IBInspectable var buttonShape: Int = 1
    
    @IBInspectable var direction: Int = 1
    
    var isDown: Bool = false
    
    var buttonPath: NSBezierPath = NSBezierPath()
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        
        setPath()
        
    }
    
    required override init(frame frameRect: NSRect) {
        
        super.init(frame: frameRect)
    
        setPath()
    }
    
    func setPath()
    {
        switch self.buttonShape
        {
            case 0:
                self.buttonPath = NSBezierPath()
                self.buttonPath = NSBezierPath(ovalIn: bounds)
            
            case 1:
        
                self.buttonPath = NSBezierPath()
                
                if direction == 1 // forward
                {
                    self.buttonPath.move(to: NSPoint(x: bounds.minX,y: bounds.minY))
                    self.buttonPath.line(to: NSPoint(x: bounds.minX, y: bounds.maxY))
                    self.buttonPath.line(to: NSPoint(x: bounds.maxX, y: bounds.height/2))
                    self.buttonPath.close()
                }
                else
                {
                    self.buttonPath.move(to: NSPoint(x: bounds.maxX,y: bounds.minY))
                    self.buttonPath.line(to: NSPoint(x: bounds.maxX, y: bounds.maxY))
                    self.buttonPath.line(to: NSPoint(x: bounds.minX, y: bounds.height/2))
                    self.buttonPath.close()
                }
            
            
            case 2:
                
                self.buttonPath = NSBezierPath()
                if direction == 1 // forward
                {
                
                    self.buttonPath.move(to: NSPoint(x: bounds.minX,y: bounds.minY))
                    self.buttonPath.line(to: NSPoint(x: bounds.minX, y: bounds.maxY))
                    self.buttonPath.line(to: NSPoint(x: bounds.width * 0.6, y: bounds.height/2))
                    self.buttonPath.close()
                    
                
                    let secondArrow = NSBezierPath()
                    secondArrow.move(to: NSPoint(x: bounds.width * 0.4, y: bounds.minY))
                    secondArrow.line(to: NSPoint(x: bounds.width * 0.4, y: bounds.maxY))
                    secondArrow.line(to: NSPoint(x: bounds.width, y: bounds.height/2))
                    secondArrow.close()
            
                    self.buttonPath.append(secondArrow)
                    
                }
                else
                {
                    self.buttonPath.move(to: NSPoint(x: bounds.maxX,y: bounds.minY))
                    self.buttonPath.line(to: NSPoint(x: bounds.maxX, y: bounds.maxY))
                    self.buttonPath.line(to: NSPoint(x: bounds.width * 0.4, y: bounds.height/2))
                    self.buttonPath.close()
                    
                    
                    let secondArrow = NSBezierPath()
                    secondArrow.move(to: NSPoint(x: bounds.width * 0.6, y: bounds.minY))
                    secondArrow.line(to: NSPoint(x: bounds.width * 0.6, y: bounds.maxY))
                    secondArrow.line(to: NSPoint(x: bounds.minX, y: bounds.height/2))
                    secondArrow.close()
                    
                    self.buttonPath.append(secondArrow)
                    
                    
                }
            
            default:
                self.buttonPath = NSBezierPath()
                self.buttonPath = NSBezierPath(ovalIn: bounds)

            
        }
        
    }
    override func draw(_ dirtyRect: NSRect) {
    
        setPath()
        if isDown == true
        {
            NSColor.darkGray.setFill()
            NSColor.darkGray.setStroke()
        }
        else
        {
            self.backColor.setFill()
            self.backColor.setStroke()
        }
        
        buttonPath.stroke()
        buttonPath.fill()
    }
    

}
