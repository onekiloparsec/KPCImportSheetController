//
//  ImportSheetController.swift
//  KPCImportSheetController
//
//  Created by Cédric Foellmi on 10/08/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Cocoa

public class ImportSheetController: NSWindowController {
    @IBOutlet public var cancelButton: NSButton?
    @IBOutlet public var spinningIndicator: NSProgressIndicator?
    @IBOutlet public var importButton: NSButton?

    public var importInputIsValid: Bool = false

    override public func windowDidLoad() {
        super.windowDidLoad()
        self.spinningIndicator?.hidden = true
//        self.importButton?.bind("enabled", toObject: self, withKeyPath: "importInputIsValid", options: nil)
    }
    
    @IBAction public func startImport(_: AnyObject?) {
        
    }

    @IBAction public func cancelImport(_: AnyObject?) {
        self.window?.sheetParent?.endSheet(self.window!, returnCode:NSModalResponseCancel)
    }
    
    public func close(afterImportSuccess success: Bool) {
        self.window?.sheetParent?.endSheet(self.window!, returnCode:(success) ? NSModalResponseOK : NSModalResponseCancel)
    }
}