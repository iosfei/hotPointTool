//
//  locationView.swift
//  hotPointTool
//
//  Created by keney on 2017/2/14.
//  Copyright © 2017年 keney. All rights reserved.
//

import Cocoa

class locationView: NSView, NSTextFieldDelegate, NSTextDelegate {

    
    var filePath : String = ""
    
    
    @IBOutlet weak var filePathLabel: NSTextField!
    

    
    @IBAction func buildLcationFiles(_ sender: NSButton) {
        
        
        if self.filePath.hasSuffix("csv"){
            
            let lo = locationCoordinate.init()
            lo.creatLocationFile(filePath: self.filePath)
            
        }
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.wantsLayer = true
        //self.layer?.backgroundColor = NSColor.gray.cgColor
        
        register(forDraggedTypes: [NSFilenamesPboardType, NSURLPboardType])
        
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        // Drawing code here.
        
    }
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        if checkExtension(sender) == true {
            self.layer?.backgroundColor = NSColor.blue.cgColor
            
            return .copy
        } else {
            return NSDragOperation()
        }
    }
    
    fileprivate func checkExtension(_ drag: NSDraggingInfo) -> Bool {
        
        guard let board = drag.draggingPasteboard().propertyList(forType:
            "NSFilenamesPboardType") as? NSArray,
            let path = board[0] as? String
            else { return false }
        
        /*
         let suffix = URL(fileURLWithPath: path).pathExtension
         for ext in self.expectedExt {
         if ext.lowercased() == suffix {
         return true
         }
         }
         */
        
        if path.hasSuffix("csv"){
            
            self.filePath = URL(fileURLWithPath: path).path
            
            self.filePathLabel.stringValue = self.filePath
            
            self.filePathLabel.lineBreakMode = NSLineBreakMode.byTruncatingMiddle
        
        }
        return false
    }
    
    override func draggingExited(_ sender: NSDraggingInfo?) {
        //self.layer?.backgroundColor = NSColor.gray.cgColor
    }
    
    override func draggingEnded(_ sender: NSDraggingInfo?) {
        //self.layer?.backgroundColor = NSColor.gray.cgColor
        
        
    }
    
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        guard let pasteboard = sender.draggingPasteboard().propertyList(forType: "NSFilenamesPboardType") as? NSArray,
            let path = pasteboard[0] as? String
            else { return false }
        
        self.filePath = path
        
        
        
        return true
    }

}
