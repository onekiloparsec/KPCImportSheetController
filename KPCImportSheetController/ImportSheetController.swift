//
//  ImportSheetController.swift
//  KPCImportSheetController
//
//  Created by Cédric Foellmi on 10/08/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Cocoa

open class ImportSheetController: NSWindowController {
    @IBOutlet open var cancelButton: NSButton?
    @IBOutlet open var spinningIndicator: NSProgressIndicator?
    @IBOutlet open var importButton: NSButton?

    open var importInputIsValid: Bool = false

    override open func windowDidLoad() {
        super.windowDidLoad()
        self.spinningIndicator?.isHidden = true
//        self.importButton?.bind("enabled", toObject: self, withKeyPath: "importInputIsValid", options: nil)
    }
    
    @IBAction open func startImport(_: AnyObject?) {
        
    }

    @IBAction open func cancelImport(_: AnyObject?) {
        self.window?.sheetParent?.endSheet(self.window!, returnCode:NSModalResponseCancel)
    }
    
    open func close(afterImportSuccess success: Bool) {
        self.window?.sheetParent?.endSheet(self.window!, returnCode:(success) ? NSModalResponseOK : NSModalResponseCancel)
    }
}
