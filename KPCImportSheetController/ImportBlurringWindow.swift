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
    
    public func blurWindowContentView(withBlankingView blankingView: NSView?, thenBeginSheet sheetWindow: NSWindow, completionHandler: @escaping ((_ returnCode: NSModalResponse) -> Void)) -> NSView
    {
        NSAnimationContext.current().completionHandler = {
            self.beginSheet(sheetWindow, completionHandler: completionHandler)
        }
        
        if self.contentView!.wantsLayer == false {
            Swift.print("Warning: contentView has property wantsLayer set to false. Set it to true to avoid 1st-animation glitch.")
            self.contentView!.wantsLayer = true
            self.contentView!.display()
        }
        
        let animation = CATransition()
        animation.type = kCATransitionFade
        animation.duration = 0.5
        
        self.contentView!.layer?.add(animation, forKey: "layerAnimation")

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
        coverView.autoresizingMask = [.viewWidthSizable, .viewHeightSizable]
        coverView.layer!.isOpaque = false
        
        coverView.layer!.backgroundColor = NSColor(white: 0.9, alpha: 0.5).cgColor
        coverView.layer!.backgroundFilters = [saturationFilter, blurFilter]
        
        self.contentView!.addSubview(coverView)

        return coverView
    }
    
    public func unblurWindowContentView(fromBlankingView blankingView: NSView, completionBlock:(() -> Void)?) {
        if completionBlock != nil {
            NSAnimationContext.current().completionHandler = completionBlock
        }
        
        let animation = CATransition()
        animation.type = kCATransitionFade
        animation.duration = 0.5
        self.contentView!.layer?.add(animation, forKey: "layerAnimation")

        blankingView.layer?.backgroundFilters = nil
        blankingView.layer?.backgroundColor = NSColor.clear.cgColor
    }
}
