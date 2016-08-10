//
//  DarkBottomSheetView.swift
//  KPCImportSheetController
//
//  Created by Cédric Foellmi on 10/08/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Cocoa

public class DarkBottomSheetView: NSView {
    private let darkGradient = NSGradient(startingColor: NSColor(white: 0.26, alpha: 1.0),
                                          endingColor: NSColor(white: 0.22, alpha: 1.0))!
    
    override public func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        
        NSGraphicsContext.currentContext()!.saveGraphicsState()
        let rect = self.bounds

        var lightLineRect = rect
        lightLineRect.origin.y += rect.size.height - 1;
        lightLineRect.size.height = 1;
        NSColor.lightGrayColor().setFill()
        NSRectFill(lightLineRect);

        var darkLineRect = self.bounds
        darkLineRect.origin.y += rect.size.height - 2;
        darkLineRect.size.height = 1;
        NSColor.blackColor().setFill()
        NSRectFill(darkLineRect);

        let radius: CGFloat = 3.0

        let topLeft  = NSMakePoint(rect.origin.x, rect.origin.y + rect.size.height)
        let topRight = NSMakePoint(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height)
        
        let bottomLeft  = NSMakePoint(rect.origin.x, rect.origin.y)
        let bottomRight = NSMakePoint(rect.origin.x + rect.size.width, rect.origin.y)
        
        let bottomRightUp   = NSMakePoint(rect.origin.x + rect.size.width, rect.origin.y + radius)
        let bottomRightDown = NSMakePoint(rect.origin.x + rect.size.width - radius, rect.origin.y)
        
        let bottomLeftDown  = NSMakePoint(rect.origin.x + radius, rect.origin.y)
        let bottomLeftUp    = NSMakePoint(rect.origin.x, rect.origin.y + radius)
        
        let path = NSBezierPath()
        path.moveToPoint(topLeft)
        path.lineToPoint(topRight)
        path.lineToPoint(bottomRightUp)
        path.appendBezierPathWithArcFromPoint(bottomRight, toPoint:bottomRightDown, radius:radius)
        path.lineToPoint(bottomLeftDown)
        path.appendBezierPathWithArcFromPoint(bottomLeft, toPoint:bottomLeftUp, radius:radius)
        path.closePath()
        path.setClip()
        
        self.darkGradient.drawInRect(path.bounds, angle:270.0)
        
        NSGraphicsContext.currentContext()!.restoreGraphicsState()
    }
}
