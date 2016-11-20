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
    
    
    lazy var fm: FileManager = {
    
        return FileManager.default
    }()
    
    override init() {
        
        self.fileAry = []
        
        // ideamakePath
        //self.filePath = "/Users/keney/Desktop/翠湖鸟瞰打点"
        
        // keneyPath
        self.filePath = "/Users/liangkang/Documents/未命名文件夹/hotPointTool/hot"
        
        self.newfilePath = self.filePath + "/hotspots"
        
    }
    
    // 带后缀的 xml 文件名
    func foundItemInDirector() -> [String] {
        
        
        var fileAry : [String] = []
        
        do {
            
            // 根据xml文件 创建对应的文件夹
            try self.fm.createDirectory(atPath: self.newfilePath, withIntermediateDirectories: true, attributes: nil)
            
            for item in try self.fm.contentsOfDirectory(atPath: self.filePath) {
                
                if item.hasSuffix("xml"){
                
                    fileAry.append(item)
                }
            }
            
        } catch {}

        
       return fileAry
    
    }
    
    // 不带后缀的 xml 文件名
    func getFileNameAryInDirector(fileType: String) -> [String] {
        
        var ary : [String] = []
        
        let itemAry = self.foundItemInDirector()
        
        
        if fileType == "xml"{
        
            for item in itemAry {
                
                let charset = CharacterSet(charactersIn:".xml")
                let itemName = item.trimmingCharacters(in: charset)
                
                if(itemName == "camera" || itemName == "DS_Store" || itemName == "hotspots"){}else{
                    
                    ary.append(itemName)
                    
                }
            }
            
        
        }else if fileType == "png"{
        
            for item in itemAry {
                
            let charset = CharacterSet(charactersIn:".png")
            let itemName = item.trimmingCharacters(in: charset)
            
            if(itemName == "camera" || itemName == "DS_Store" || itemName == "hotspots"){}else{
                
                ary.append(itemName)
                
            }
        
        }

        
    }
    
        self.fileAry = ary
        
        return self.fileAry
    }
    
    
    // 根据文件名拼接的目标路径
    func getObjectUrlPath(fileType: String) -> [String] {
        
        var upAry : [String] = []
        
        // 查找xml文件
        let fileNameAry = self.getFileNameAryInDirector(fileType: "xml")
        
        if fileType == "xml"{
        
            for item in fileNameAry {
                
                let subXmlPath = self.newfilePath + "/\(item)/" + "hotspotdatafile.xml"
                
                if item.hasSuffix("png"){}else{
                    
                    upAry.append(subXmlPath)
                    
                }
                
                //print(subXmlPath)
            }
        
        }else if fileType == "png"{
        
            
            for item in fileNameAry {
                
                let subXmlPath = self.newfilePath + "/\(item)/" + "icon@2x.png"
                
                    
                    upAry.append(subXmlPath)
                    
                }
                
                //print(subXmlPath)
            }
        
        return upAry
        
        /*
         // 根据 newfilePath 获取目标路径
         let url : URL = URL.init(fileURLWithPath: self.newfilePath)
         
         do {
         
         let obAry = try self.fm.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: FileManager.DirectoryEnumerationOptions.skipsHiddenFiles)
         
         for item in obAry {
         
         upAry.append(item.path)
         }
         
         } catch { }
         */
    }
    
    // 获取待处理 xml, png 文件夹的路径
    func getItemUrlPath(fileType: String) -> [String] {
        
        var itemUrl : [String] = []
       
        
        let url : URL = URL.init(fileURLWithPath: self.filePath)
       
        do {
            
             let newUrls = try self.fm.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: FileManager.DirectoryEnumerationOptions.skipsHiddenFiles)
            
            if fileType == "xml"{
                
                for item in newUrls {
                    
                    if item.absoluteString.hasSuffix("xml") {
                        
                        itemUrl.append(item.path)
                        
                        print("获取待处理url： \(item.path)")
                    }
                    
                    
                }
                
            }else if fileType == "png"{
                
                for item in newUrls {
                    
                    if item.absoluteString.hasSuffix("png"){
                        
                        itemUrl.append(item.path)
                        
                        //print("获取待处理url： \(item.path)")
                    }
                    
                }
            }
            
        }catch{ }
        

        return itemUrl
        
    }
    
    // 创建对应的文件夹
    func creatFile(){
        
            self.fileAry = self.getFileNameAryInDirector(fileType:"xml")
        
            for fileName in self.fileAry {
                
                /* if 判断
                 if(fileName == "camera" || fileName == "DS_Store" || fileName == "hotspots" || fileName.hasSuffix("png")){}else{
                 
                 let subFilePath = newfilePath +  "/" + fileName
                 
                 do{
                 
                 try self.fm.createDirectory(atPath: subFilePath, withIntermediateDirectories: true, attributes: nil)
                 
                 }catch{}
                 
                 }
                 */
                    
                    let subFilePath = newfilePath +  "/" + fileName
                    
                    do{
                        
                        try self.fm.createDirectory(atPath: subFilePath, withIntermediateDirectories: true, attributes: nil)
                        
                    }catch{}

        }


    }
    
    func copyFileToObject(){
        
         // xml 拷贝
        let itemUrl = self.getItemUrlPath(fileType: "xml")
        let objUrl = self.getObjectUrlPath(fileType: "xml")
        
        // png 拷贝
        let pngUrl = self.getItemUrlPath(fileType: "png")
        let pngObUlr = self.getObjectUrlPath(fileType: "png")
        
         
         for (index, _) in itemUrl.enumerated(){
         
         let atPath = itemUrl[index]
         let toPath = objUrl[index]
            
         let atPng = pngUrl[index]
         let toPng = pngObUlr[index]
         
         
         do {
         
         try self.fm.copyItem(atPath: atPath, toPath: toPath)
            
         try self.fm.copyItem(atPath: atPng, toPath: toPng)
         
         }catch{}
         }

        
        
    
    }

}
