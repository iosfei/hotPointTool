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
    
    var fileAry : [String]
    
    override init() {
        
        self.fileAry = []
        
        // ideamakePath
        self.filePath = "/Users/keney/Documents/备份/demo/hotPointTool/hot"
        
        // keneyPath
        //self.filePath = "/Users/liangkang/Documents/未命名文件夹/hotPointTool/hot"
        
        self.newfilePath = self.filePath + "/hotspots"
        
    }
    
    func foundItemInDirector() -> [String] {
        
        let fm = FileManager.default
        
        var fileAry : [String] = []
        
        do {
            
            try fm.createDirectory(atPath: self.newfilePath, withIntermediateDirectories: true, attributes: nil)

            fileAry = try fm.contentsOfDirectory(atPath: self.filePath)
            
        } catch {}

        //print("文件全名ary： \(fileAry)")
        
       return fileAry
    
    }
    
    func getItemAryNameInDirector() -> [String] {
        
        var ary : [String] = []
        
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
    
    func getObjectUrlPath() -> [String] {
        
        var upAry : [String] = []
        
        let fileNameAry = self.getItemAryNameInDirector()
        
        for item in fileNameAry {
            
            var subXmlPath = self.newfilePath
            
            subXmlPath += "/\(item)/"
            
            if item.hasSuffix("png"){}else{
            
                upAry.append(subXmlPath)
            
            }

        }
        
        return upAry
        
    }
    
    
    func getItemUrlPath() -> [String] {
        
        var itemUrl : [String] = []
        
        let fm = FileManager.default
       
        do {
            
            let url : URL = URL.init(fileURLWithPath: self.filePath)
            
            let newUrls = try fm.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: FileManager.DirectoryEnumerationOptions.skipsHiddenFiles)
            
            for item in newUrls {

                //print("获取待处理url： \(item.path)")
                
                itemUrl.append(item.path)
                
            }
        } catch  {
            
        }
        
       
        return itemUrl
        
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
        
        // 获取待拷贝的文件路径集合
         self.getItemUrlPath()

        // 获取目标文件夹路径集合
        //let urlAry = self.getObjectUrlPath()
        
        // 把当前的文件 cope 到新的路径？
        

        
    }

}
