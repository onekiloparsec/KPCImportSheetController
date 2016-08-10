//
//  WhiteProgressIndicator.swift
//  KPCImportSheetController
//
//  Created by Cédric Foellmi on 10/08/16.
//  Copyright © 2016 onekiloparsec. All rights reserved.
//

import Cocoa

public class WhiteProgressIndicator: NSProgressIndicator {
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.setup()
    }
    
    private func setup() {
        let lighten = CIFilter(name: "CIColorControls")!
        lighten.setDefaults()
        lighten.setValue(1, forKey: "inputBrightness")
        self.contentFilters = [lighten]
    }
}