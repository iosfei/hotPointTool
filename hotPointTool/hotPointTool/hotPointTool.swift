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
        self.filePath = "/Users/keney/Documents/备份/demo/hotPointTool/hot"
        
        // keneyPath
        //self.filePath = "/Users/liangkang/Documents/未命名文件夹/hotPointTool/hot"
        
        self.newfilePath = self.filePath + "/hotspots"
        
    }
    
    // 带后缀的 xml 文件名
    func foundItemInDirector() -> [String] {
        
        
        var fileAry : [String] = []
        
        do {
            
            try self.fm.createDirectory(atPath: self.newfilePath, withIntermediateDirectories: true, attributes: nil)

            //fileAry = try fm.contentsOfDirectory(atPath: self.filePath)
            
            // 根据xml文件 创建对应的文件夹
            for item in try self.fm.contentsOfDirectory(atPath: self.filePath) {
                
              
                if item.hasSuffix("xml"){
                
                    fileAry.append(item)
                }
            }
            
        } catch {}

        //print("带后缀的 xml 文件名： \(fileAry)")
        
       return fileAry
    
    }
    
    // 不带后缀的 xml 文件名
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
        
        //print("不带后缀的 xml 文件名： \(ary)")
        
        self.fileAry = ary
        
        return self.fileAry
    }
    
    
    // 根据文件名拼接的目标路径
    func getObjectUrlPath() -> [String] {
        
        
        var upAry : [String] = []
        
        
         // 拼接的方法
         let fileNameAry = self.getItemAryNameInDirector()
         
         for item in fileNameAry {
         
         var subXmlPath = self.newfilePath
         
         subXmlPath = subXmlPath + "/\(item)/" + "hotspotdatafile.xml"
         
         if item.hasSuffix("png"){}else{
         
         upAry.append(subXmlPath)
         
         }
         
            print(subXmlPath)
        }
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
        
        return upAry
        
    }
    
    // 获取待处理 xml 文件夹的路径
    func getItemUrlPath() -> [String] {
        
        var itemUrl : [String] = []
       
        do {
            
            let url : URL = URL.init(fileURLWithPath: self.filePath)
            
            let newUrls = try self.fm.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: FileManager.DirectoryEnumerationOptions.skipsHiddenFiles)
            
            for item in newUrls {

                
                if item.absoluteString.hasSuffix("xml"){
                
                    itemUrl.append(item.path)
                    
                    //print("获取待处理url： \(item.path)")
                }
                
                
            }
        } catch  {
            
        }
        
       
        return itemUrl
        
    }
    
    // 创建对应的文件夹
    func creatFile(){
        
            self.fileAry = self.getItemAryNameInDirector()
        
            for fileName in self.fileAry {
                
                /* if
                 if(fileName == "camera" || fileName == "DS_Store" || fileName == "hotspots" || fileName.hasSuffix("png")){}else{
                 
                 let subFilePath = newfilePath +  "/" + fileName
                 
                 do{
                 
                 try self.fm.createDirectory(atPath: subFilePath, withIntermediateDirectories: true, attributes: nil)
                 
                 }catch{}
                 
                 }
                 */
                
                 // guard
                 guard fileName.hasSuffix("hotspots")  else {
                 
                 let subFilePath = newfilePath +  "/" + fileName
                 
                 do{
                 
                 try self.fm.createDirectory(atPath: subFilePath, withIntermediateDirectories: true, attributes: nil)
                 
                 }catch{}
                 
                 continue
                    
                 }
        }


    }
    
    func copyFileToObject(){
        
         // 获取待拷贝的文件路径集合
         let itemUrl = self.getItemUrlPath()
         
         // 获取目标文件夹路径集合
         let objUrl = self.getObjectUrlPath()
        
        
        for (index, _) in itemUrl.enumerated(){
        
            let atPath = itemUrl[index]
            let toPath = objUrl[index]
            
            
            do {
                
                try self.fm.copyItem(atPath: atPath, toPath: toPath)
            
            }catch{}
        }
        
    
    }

}
