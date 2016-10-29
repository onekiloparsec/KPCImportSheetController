//
//  DarkBottomSheetView.swift
//  KPCImportSheetController
//
//  Created by Cédric Foellmi on 10/08/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Cocoa

open class DarkBottomSheetView: NSView {
    fileprivate let darkGradient = NSGradient(starting: NSColor(white: 0.26, alpha: 1.0),
                                          ending: NSColor(white: 0.22, alpha: 1.0))!
    
    override open func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        NSGraphicsContext.current()!.saveGraphicsState()
        let rect = self.bounds

        var lightLineRect = rect
        lightLineRect.origin.y += rect.size.height - 1;
        lightLineRect.size.height = 1;
        NSColor.lightGray.setFill()
        NSRectFill(lightLineRect);

        var darkLineRect = self.bounds
        darkLineRect.origin.y += rect.size.height - 2;
        darkLineRect.size.height = 1;
        NSColor.black.setFill()
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
        path.move(to: topLeft)
        path.line(to: topRight)
        path.line(to: bottomRightUp)
        path.appendArc(from: bottomRight, to:bottomRightDown, radius:radius)
        path.line(to: bottomLeftDown)
        path.appendArc(from: bottomLeft, to:bottomLeftUp, radius:radius)
        path.close()
        path.setClip()
        
        self.darkGradient.draw(in: path.bounds, angle:270.0)
        
        NSGraphicsContext.current()!.restoreGraphicsState()
    }
}
