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
    
    var imagePath : [String]
    
    let hotspots = "hotspots"
    
    let imageFile = "images"
    
    let xmlName = "hotspotdatafile.xml"
    
    let pngName = "icon@2x.png"
    
    var imageWidth : Double!
    
    var imageheight : Double!
    
    lazy var fm: FileManager = {
    
        return FileManager.default
    }()
    
    
    override init() {
        
        
        
        self.fileAry = []
        
        self.imagePath = []
        
        // ideamakePath
        self.filePath = "/Users/keney/Desktop/20161129珊瑚宫殿/新加打点"
       
        // keneyPath
        //self.filePath = "/Users/liangkang/Documents/未命名文件夹/hotPointTool/hot"
        
        self.newfilePath = self.filePath + "/\(hotspots)"
        
    }
    
    // 带后缀的 xml 文件名
    func foundItemInDirector() -> [String] {
        
        
        var fileAry : [String] = []
        
        do {
            
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
                
                if(itemName == "camera" || itemName == "DS_Store" || itemName == "\(hotspots)"){}else{
                    
                    ary.append(itemName)
                    
                }
            }
            
        
        }else if fileType == "png"{
        
            for item in itemAry {
                
            let charset = CharacterSet(charactersIn:".png")
            let itemName = item.trimmingCharacters(in: charset)
            
            if(itemName == "camera" || itemName == "DS_Store" || itemName == "\(hotspots)"){}else{
                
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
                
                let subXmlPath = self.newfilePath + "/\(item)/" + "\(xmlName)"
                
                if item.hasSuffix("png"){}else{
                    
                    upAry.append(subXmlPath)
                    
                }
                
            }
        
        }else if fileType == "png"{
        
            
            for item in fileNameAry {
                
                let subXmlPath = self.newfilePath + "/\(item)/\(imageFile)/" + "\(pngName)"
                
                    upAry.append(subXmlPath)
                    
                }
            
            }
        
        return upAry
        
    }
    
    // 获取待处理 xml, png 文件夹的路径
    func getItemUrlPath(fileType: String) -> [String] {
        
        var itemUrl : [String] = []
       
        
        let url : URL = URL.init(fileURLWithPath: self.filePath)
       
        do {
            
             let newUrls = try self.fm.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: FileManager.DirectoryEnumerationOptions.skipsHiddenFiles)
            
            if fileType == "xml"{
                
                for item in newUrls {
                    
                    if item.absoluteString.hasSuffix("xml"){
                        
                        itemUrl.append(item.path)
                        
                    }
                    
                }
                
            }else if fileType == "png"{
                
                for item in newUrls {
                    
                    if item.absoluteString.hasSuffix("png"){
                        
                        itemUrl.append(item.path)
                    }
                    
                }
            }
            
        }catch{ }
        

        return itemUrl
        
    }
    
    // 创建热点对应的文件夹
    func creatFile(){
        
            self.fileAry = self.getFileNameAryInDirector(fileType:"xml")
        
            for fileName in self.fileAry {
                
                    let xmlFilePath = newfilePath +  "/" + fileName
                    let imageFilePath = xmlFilePath + "/\(imageFile)"
                
                    do{
                        
                        try self.fm.createDirectory(atPath: xmlFilePath, withIntermediateDirectories: true, attributes: nil)
                        
                        try self.fm.createDirectory(atPath: imageFilePath, withIntermediateDirectories: true, attributes: nil)
                        
                    }catch{}
        }

    }
    
    // copy文件到对应目录
    func copyFileToObject(){
        
         // xml 文件
        let itemUrl = self.getItemUrlPath(fileType: "xml")
        let objUrl = self.getObjectUrlPath(fileType: "xml")
        
        // png 文件
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

    // 获取 png 信息
    func getPngMessges(){
        
        let pngAry = self.getObjectUrlPath(fileType: "png")
        
        var data: Data?
        
        do {
        
            data = try Data.init(contentsOf: URL.init(fileURLWithPath: pngAry[0], isDirectory: false))
        
        } catch {}
        
        if #available(OSX 10.12, *) {
            
            let image = NSImageView.init(image: NSImage.init(data: data!)!)

            self.imageWidth = Double(image.image!.size.width * 0.5)
            
            self.imageheight = Double(image.image!.size.height * 0.5)
            
        } else {}
        
    }
    
    
    // xml 编辑
    func editXML(){
        
        let firtXml = self.getObjectUrlPath(fileType: "xml")
        
        let xmlStr = firtXml[0]
        
        let xmlUrl : URL = URL.init(fileURLWithPath: xmlStr, isDirectory: false)
        
        do {
            
            let xmlData = try Data.init(contentsOf: xmlUrl)
            
            
 
        
        } catch let error{
        
            print(error)
            
        
        }
        
        
        
        
        
    }
    
    
}
