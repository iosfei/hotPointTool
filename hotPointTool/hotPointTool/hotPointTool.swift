//
//  hotPointTool.swift
//  hotPointTool
//
//  Created by keney on 2016/10/27.
//  Copyright © 2016年 keney. All rights reserved.
//

import Cocoa

class hotPointTool: NSObject {

    var filePath: String
    
    var newfilePath : String
    
    var fileAry : Array<String>
    
    override init() {
        
        self.fileAry = []
        
        // ideamakePath
        self.filePath = "/Users/keney/Documents/备份/demo/hot"
        
        self.newfilePath = self.filePath + "/hotspots"
        
        //print("newfilePath: \(self.newfilePath)" )
        
        
    }
    
    func foundItemInDirector() -> Array<String> {
        
        let fm = FileManager.default
        
        var fileAry : Array<String> = []
        
        do {
            
            try fm.createDirectory(atPath: self.newfilePath, withIntermediateDirectories: true, attributes: nil)

            fileAry = try fm.contentsOfDirectory(atPath: self.filePath)
            
        } catch {}

        //print("文件全名ary： \(fileAry)")
        
       return fileAry
    
    }
    
    func getItemAryNameInDirector() -> Array<String> {
        
        var ary : Array<String> = []
        
        let itemAry = self.foundItemInDirector()
        
        for item in itemAry {
            
            let charset = CharacterSet(charactersIn:".xml")
            let itemName = item.trimmingCharacters(in: charset)
            
            if(itemName == "camera" || itemName == "DS_Store" || itemName == "hotspots"){}else{
            
            ary.append(itemName)
                
            }
        }
        
        self.fileAry = ary
        //print("文件名ary： \(self.fileAry )")
        return self.fileAry
    }
    
    func getItemUrlPath() -> Array<String> {
        
        var upAry : Array<String> = []
        
        let fileNameAry = self.getItemAryNameInDirector()
        
        for item in fileNameAry {
            
            var subXmlPath = self.newfilePath
            
            subXmlPath += "/\(item)"
            
            if item.hasSuffix("png"){}else{
            
                upAry.append(subXmlPath)
            
            }

        }
        
        return upAry
        
    }
    
    
    func creatFile(){
        
            let fm = FileManager.default
        
            self.fileAry = self.getItemAryNameInDirector()
        
            for fileName in self.fileAry {
                
                if(fileName == "camera" || fileName == "DS_Store" || fileName == "hotspots" || fileName.hasSuffix("png")){}else{
                    
                    let subFilePath = newfilePath +  "/" + fileName
                    
                    do{
                        
                        try fm.createDirectory(atPath: subFilePath, withIntermediateDirectories: true, attributes: nil)
                        
                    }catch{}
                    
                }

            }
    }
        
    func copyFileToObject(){
        
        let fm = FileManager.default
        
        let urlAry = self.getItemUrlPath()
        
        print(urlAry)
        
        do{

            let xmlUrl = URL.init(fileURLWithPath: self.filePath)
            
            let ary = try fm.contentsOfDirectory(at: xmlUrl, includingPropertiesForKeys: nil, options: FileManager.DirectoryEnumerationOptions.skipsHiddenFiles)
            

            

            
        }catch{
            
            
        
        }
        
        
        
        
        
        
    }

}
