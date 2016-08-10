//
//  ImportBlurringWindow.swift
//  KPCImportSheetController
//
//  Created by Cédric Foellmi on 10/08/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Cocoa
import QuartzCore
import CoreImage

public extension NSWindow {
    
    public func blurWindowContentView(withBlankingView blankingView: NSView?, thenBeginSheet sheetWindow: NSWindow, completionHandler: ((returnCode: NSModalResponse) -> Void)) -> NSView
    {
        NSAnimationContext.currentContext().completionHandler = {
            self.beginSheet(sheetWindow, completionHandler: completionHandler)
        }
        
        self.contentView!.wantsLayer = true
        
        let animation = CATransition()
        animation.type = kCATransitionFade
        animation.duration = 0.5
        self.contentView!.layer?.addAnimation(animation, forKey: "layerAnimation")
        
        let saturationFilter = CIFilter(name: "CIColorControls")!
        saturationFilter.setDefaults()
        saturationFilter.setValue(2, forKey: "inputSaturation")
        
        let blurFilter = CIFilter(name: "CIGaussianBlur")!
        blurFilter.setDefaults()
        blurFilter.setValue(1.5, forKey:"inputRadius")
        
        let coverView = blankingView ?? NSView()
        coverView.frame = self.contentView!.bounds
        coverView.wantsLayer = true
        coverView.layerUsesCoreImageFilters = true
        coverView.autoresizingMask = [.ViewWidthSizable, .ViewHeightSizable]
        coverView.layer!.opaque = false
        
        self.contentView!.addSubview(coverView)
        coverView.layer!.backgroundFilters = [saturationFilter, blurFilter]
        coverView.layer!.backgroundColor = NSColor(white: 0.9, alpha: 0.5).CGColor
        
        return coverView
    }
    
    public func unblurWindowContentView(fromBlankingView blankingView: NSView, completionBlock:(() -> Void)?) {
        if completionBlock != nil {
            NSAnimationContext.currentContext().completionHandler = completionBlock
        }
        
        let animation = CATransition()
        animation.type = kCATransitionFade
        animation.duration = 0.5
        self.contentView!.layer?.addAnimation(animation, forKey: "layerAnimation")

        blankingView.layer?.backgroundFilters = nil
        blankingView.layer?.backgroundColor = NSColor.clearColor().CGColor
    }
}
