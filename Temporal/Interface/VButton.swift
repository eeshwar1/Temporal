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

    @IBInspectable var backColor: NSColor = NSColor.controlAccentColor
    
    @IBInspectable var buttonShape: Int = 1
    
    @IBInspectable var direction: Int = 1
    
    var inset: CGFloat = 2.0
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
        let shapeBounds = bounds.insetBy(dx: inset, dy: inset)
        
        switch self.buttonShape
        {
            case 0:
                self.buttonPath = NSBezierPath()
                self.buttonPath = NSBezierPath(ovalIn: shapeBounds)
            
            case 1:
                   
               self.buttonPath = NSBezierPath()
               
               if direction == 1 // forward
               {
                   self.buttonPath.move(to: NSPoint(x: shapeBounds.minX,y: shapeBounds.minY))
                   self.buttonPath.line(to: NSPoint(x: shapeBounds.maxX - shapeBounds.width *  0.4, y: shapeBounds.minY
                   + shapeBounds.height/2))
                   self.buttonPath.line(to: NSPoint(x: shapeBounds.minX, y: shapeBounds.maxY))
                   
               }
               else
               {
                   self.buttonPath.move(to: NSPoint(x: shapeBounds.maxX,y: shapeBounds.minY))
                   self.buttonPath.line(to: NSPoint(x: shapeBounds.minX + shapeBounds.width * 0.4, y: shapeBounds.minY + shapeBounds.height/2))
                   self.buttonPath.line(to: NSPoint(x: shapeBounds.maxX, y: shapeBounds.maxY))
                  
               }
           
                       
               case 2:
                   
                   self.buttonPath = NSBezierPath()
                   
                   if direction == 1 // forward
                   {
                   
                       self.buttonPath.move(to: NSPoint(x: shapeBounds.minX,y: shapeBounds.minY))
                       self.buttonPath.line(to: NSPoint(x: shapeBounds.minX + shapeBounds.width * 0.6, y: shapeBounds.minY + shapeBounds.height/2))
                       self.buttonPath.line(to: NSPoint(x: shapeBounds.minX, y: shapeBounds.maxY))
                      
                       
                   
                       let secondArrow = NSBezierPath()
                       secondArrow.move(to: NSPoint(x: shapeBounds.minX + shapeBounds.width * 0.4, y: shapeBounds.minY))
                       secondArrow.line(to: NSPoint(x: shapeBounds.minX + shapeBounds.width, y: shapeBounds.minY + shapeBounds.height/2))
                       secondArrow.line(to: NSPoint(x: shapeBounds.minX + shapeBounds.width * 0.4, y: shapeBounds.maxY))
                      
                       
               
                       self.buttonPath.append(secondArrow)
                       
                   }
                   else
                   {
                       self.buttonPath.move(to: NSPoint(x: shapeBounds.maxX,y: shapeBounds.minY))
                       self.buttonPath.line(to: NSPoint(x: shapeBounds.minX + shapeBounds.width * 0.4, y: shapeBounds.minY + shapeBounds.height/2))
                       self.buttonPath.line(to: NSPoint(x: shapeBounds.maxX, y: shapeBounds.maxY))
                       
                       
                       
                       let secondArrow = NSBezierPath()
                       secondArrow.move(to: NSPoint(x: shapeBounds.minX + shapeBounds.width * 0.6, y: shapeBounds.minY))
                       secondArrow.line(to: NSPoint(x: shapeBounds.minX, y: shapeBounds.minY +  shapeBounds.height/2))
                       secondArrow.line(to: NSPoint(x: shapeBounds.minX + shapeBounds.width * 0.6, y: shapeBounds.maxY))
                       
                       
                       self.buttonPath.append(secondArrow)
                       
                       
                   }
            case 3:
        
                self.buttonPath = NSBezierPath()
                
                if direction == 1 // forward
                {
                    self.buttonPath.move(to: NSPoint(x: shapeBounds.minX,y: shapeBounds.minY))
                    self.buttonPath.line(to: NSPoint(x: shapeBounds.minX, y: shapeBounds.maxY))
                    self.buttonPath.line(to: NSPoint(x: shapeBounds.maxX, y: shapeBounds.minY
                         + shapeBounds.height/2))
                    self.buttonPath.close()
                }
                else
                {
                    self.buttonPath.move(to: NSPoint(x: shapeBounds.maxX,y: shapeBounds.minY))
                    self.buttonPath.line(to: NSPoint(x: shapeBounds.maxX, y: shapeBounds.maxY))
                    self.buttonPath.line(to: NSPoint(x: shapeBounds.minX, y: shapeBounds.minY + shapeBounds.height/2))
                    self.buttonPath.close()
                }
            
            
            case 4:
                
                self.buttonPath = NSBezierPath()
                
                if direction == 1 // forward
                {
                
                    self.buttonPath.move(to: NSPoint(x: shapeBounds.minX,y: shapeBounds.minY))
                    self.buttonPath.line(to: NSPoint(x: shapeBounds.minX, y: shapeBounds.maxY))
                    self.buttonPath.line(to: NSPoint(x: shapeBounds.width * 0.6, y: shapeBounds.height/2))
                    self.buttonPath.close()
                
                    let secondArrow = NSBezierPath()
                    secondArrow.move(to: NSPoint(x: shapeBounds.width * 0.4, y: shapeBounds.minY))
                    secondArrow.line(to: NSPoint(x: shapeBounds.width * 0.4, y: shapeBounds.maxY))
                    secondArrow.line(to: NSPoint(x: shapeBounds.width, y: shapeBounds.minY +  shapeBounds.height/2))
                    secondArrow.close()
            
                    self.buttonPath.append(secondArrow)
                    
                }
                else
                {
                    self.buttonPath.move(to: NSPoint(x: shapeBounds.maxX,y: shapeBounds.minY))
                    self.buttonPath.line(to: NSPoint(x: shapeBounds.maxX, y: shapeBounds.maxY))
                    self.buttonPath.line(to: NSPoint(x: shapeBounds.width * 0.4, y: shapeBounds.height/2))
                    self.buttonPath.close()
                    
                    
                    let secondArrow = NSBezierPath()
                    secondArrow.move(to: NSPoint(x: shapeBounds.width * 0.6, y: shapeBounds.minY))
                    secondArrow.line(to: NSPoint(x: shapeBounds.width * 0.6, y: shapeBounds.maxY))
                    secondArrow.line(to: NSPoint(x: shapeBounds.minX, y: shapeBounds.minY +   shapeBounds.height/2))
                    secondArrow.close()
                    
                    self.buttonPath.append(secondArrow)
                    
                    
                }
            
            default:
                self.buttonPath = NSBezierPath()
                self.buttonPath = NSBezierPath(ovalIn: shapeBounds)

            
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
        
        if self.buttonShape == 1 ||
           self.buttonShape == 2 {
            
            buttonPath.lineWidth = 3.0
        }
        buttonPath.stroke()
        
        if self.buttonShape == 3 ||
           self.buttonShape == 4 {
            
            buttonPath.fill()
            
        }
        
    }
    

}
