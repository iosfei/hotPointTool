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
        self.filePath = ""
        
        self.newfilePath = self.filePath + "/\(hotspots)"
        
    }
    
    // hasSuffix's file
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
    
    // no Suffix's files
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
    
    
    // Stitching path
    func getObjectUrlPath(fileType: String) -> [String] {
        
        var upAry : [String] = []
        
        // search xml files
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
    
    // get filePath
    func getItemUrlPath(fileType: String) -> [String] {
        
        var itemUrl : [String] = []
        
        if fileType == "xml"{
            
            do {
                
                let url : URL = URL.init(fileURLWithPath: self.filePath)
                
                let newUrls = try self.fm.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: FileManager.DirectoryEnumerationOptions.skipsHiddenFiles)
                
                for item in newUrls {
                    
                    if item.absoluteString.hasSuffix("xml"){
                        
                        itemUrl.append(item.path)
                        
                    }
                    
                }
            } catch {}
            
            
        }else if fileType == "png"{
            
            do {
                
                let url : URL = URL.init(fileURLWithPath: self.filePath)
                
                let newUrls = try self.fm.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: FileManager.DirectoryEnumerationOptions.skipsHiddenFiles)
                
                for item in newUrls {
                    
                    if item.absoluteString.hasSuffix("png"){
                        
                        itemUrl.append(item.path)
                    }
                    
                }
            } catch {}
            
            
        }
        
        
        return itemUrl
        
    }
    
    
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
    
    
    func copyFileToObject(){
        
        
        let itemUrl = self.getItemUrlPath(fileType: "xml")
        
        let objUrl = self.getObjectUrlPath(fileType: "xml")
        
        
        // get png files
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
    
    // get png's messges
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
            
        }else{
            
            let image = NSImage.init(data:data!)
            self.imageWidth = Double(image!.size.width * 0.5)
            self.imageheight = Double(image!.size.height * 0.5)
            
        }
    }
    
    func getXMLOriginSize(){
        
        let firtXml = self.getObjectUrlPath(fileType: "xml")
        
        let xmlStr = firtXml[0]
        
        do {
            
            let str = try String.init(contentsOfFile: xmlStr, encoding: String.Encoding.isoLatin2)
            
            let originSize = str.substring(with: str.index(str.startIndex, offsetBy: 22)..<str.index(str.startIndex, offsetBy: 36))
            
            let bounds = "\(self.imageWidth!), \(self.imageheight!)"
            
            //  change xml
            let xmlUrl = Bundle.main.url(forResource: "hotspotdatafile", withExtension: "xml")
            
            var xmlNewStr = try String.init(contentsOf: xmlUrl!)
            
            print("这是旧拼接的参数\(xmlNewStr)")
            
            
            // get bounds
            xmlNewStr.replaceSubrange(xmlNewStr.index(xmlNewStr.startIndex, offsetBy: 29)...xmlNewStr.index(xmlNewStr.startIndex, offsetBy: 38), with: bounds)
            
            // get originSize
            xmlNewStr.replaceSubrange(xmlNewStr.index(xmlNewStr.startIndex, offsetBy: 81)...xmlNewStr.index(xmlNewStr.startIndex, offsetBy: 94), with: originSize)
            
            print("这是新拼接的参数\(xmlNewStr)")
            
            
            let fm = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            
            let path = try fm?.appendingPathComponent(String.init(contentsOf: xmlUrl!, encoding: String.Encoding.utf8))
            
            try xmlNewStr.write(toFile: String.init(contentsOf: path!, encoding: String.Encoding.utf8), atomically: false, encoding: String.Encoding.utf8)
            
            
            
            /*
             
             //FileHandle mode  will next work 
             let fh = try FileHandle.init(forWritingTo: xmlUrl!)
             
             let data = xmlNewStr.data(using: String.Encoding.isoLatin2)
             
             fh.write(data!)
             
             fh.closeFile()
             
             */
            
            
        } catch let error{
            
            print("getXMLOriginSize writing error!!!!!!!!!")
            
            //print(error)
            
        }
        
    }
    
    
}

