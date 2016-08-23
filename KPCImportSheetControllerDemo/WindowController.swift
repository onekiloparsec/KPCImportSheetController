//
//  WindowController.swift
//  KPCImportSheetController
//
//  Created by Cédric Foellmi on 10/08/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Cocoa
import KPCImportSheetController

class WindowController: NSWindowController {
 
    var blankingView: NSView?
    var importSheetController: ImportSheetController?
    
    override func windowDidLoad() {
        super.windowDidLoad()
//        self.window?.contentView?.wantsLayer = true
//        self.window?.contentView?.layer?.display()
    }
    
    @IBAction func testImportSheet(sender: AnyObject?) {
        self.importSheetController = ImportSheetController(windowNibName: "NewStarSheet")
        
        self.blankingView = self.window?.blurWindowContentView(withBlankingView: nil, thenBeginSheet: self.importSheetController!.window!, completionHandler: { (returnCode) in
            print("\(returnCode)")
        })        
    }
}

