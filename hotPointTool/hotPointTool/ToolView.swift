//
//  ToolView.swift
//  hotPointTool
//
//  Created by keney on 2016/12/28.
//  Copyright © 2016年 keney. All rights reserved.
//

import Cocoa

class ToolView: NSView, NSTextFieldDelegate, NSTextDelegate {
    
    var ToolfilePath: String?
    let expectedExt = ["kext"]  //file extensions allowed for Drag&Drop
    
    
    @IBOutlet weak var filePathLabel: NSTextField!
    
    @IBAction func createHotFile(_ sender: Any) {
        
        guard self.ToolfilePath?.isEmpty == nil else {
            
            let vc = hotPointTool.init()
            
            vc.filePath = self.ToolfilePath!
            
            vc.newfilePath = vc.filePath + "/\(vc.hotspots)"
            
            guard  !vc.checkFile() else{
            
                vc.creatFile()
                
                vc.copyFileToObject()
                
                vc.getPngMessges()
                
                vc.getXMLOriginSize()
            
                return
            }
            
            
            return
        }
        
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.gray.cgColor

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
        
        
        var isDir: ObjCBool = false
        
        let fm = FileManager.default
        if fm.fileExists(atPath: path, isDirectory: &isDir){
        
            if isDir.boolValue {
            
                self.ToolfilePath = URL(fileURLWithPath: path).path
                
                self.filePathLabel.stringValue = self.ToolfilePath!
                
                self.filePathLabel.lineBreakMode = NSLineBreakMode.byTruncatingMiddle
                
            }else{
            
            }
         
            
        }
        
        
        if path.hasSuffix("csv") || path.hasSuffix("swfit") || path.hasSuffix("excel") || path.hasSuffix("word"){
        
        }else{
            
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
        
        self.ToolfilePath = path
        
        return true
    }

}


