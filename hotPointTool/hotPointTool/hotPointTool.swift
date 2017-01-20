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
    
    var pngAry : [String]
    
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
        
        self.pngAry = []
        
        self.filePath = ""
        
        self.newfilePath = self.filePath + "/\(hotspots)"
        
    }
    
    // hasSuffix's file
    func foundItemInDirector(fileType:String) -> [String] {
        
        var fileAry : [String] = []
        
        do {

            for item in try self.fm.contentsOfDirectory(atPath: self.filePath) {
                
                
                if fileType == "xml"{
                    
                    if item.hasSuffix("xml"){
                        
                        fileAry.append(item)
                    }
                
                }else if fileType == "png" {
                
                if item.hasSuffix("png"){
                    
                    fileAry.append(item)
                }
            }
            
            }
            
        } catch {}
        
        
        return fileAry
        
    }
    
    // no Suffix's files
    func getFileNameAryInDirector(fileType: String) -> [String] {
        
        var ary : [String] = []
        
        
        
        if fileType == "xml"{
            
            let itemAry = self.foundItemInDirector(fileType:"xml")
            for item in itemAry {
                
                //print("xml原始文件：\(item)")
                let charset = CharacterSet(charactersIn:".xml")
                let itemName = item.trimmingCharacters(in: charset)
                
                if(itemName == "camera" || itemName == "DS_Store" || itemName == "\(hotspots)"){}else{
                    
                    ary.append(itemName)
                    
                }
            }

        }else if fileType == "png"{
            
            
            let itemAry = self.foundItemInDirector(fileType:"png")
            
            for item in itemAry {
                
                //print("png原始文件：\(item)")
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
        
        
        if fileType == "xml"{
            
            let fileNameAry = self.getFileNameAryInDirector(fileType: "xml")
            
            for item in fileNameAry {
                
                let subXmlPath = self.newfilePath + "/\(item)/" + "\(xmlName)"
                
                if item.hasSuffix("png"){}else{
                    
                    upAry.append(subXmlPath)
                    
                }
                
            }
            
        }else if fileType == "png"{
            
            let fileNameAry = self.getFileNameAryInDirector(fileType: "png")
            
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
    
   func checkFile()-> Bool{
        
        let xmlFiles = self.getFileNameAryInDirector(fileType:"xml")
        let pngFiles = self.getFileNameAryInDirector(fileType:"png")
        
            for (index, _) in xmlFiles.enumerated() {
        
                if xmlFiles[index] != pngFiles[index]{
                
                    print("xml文件\(xmlFiles[index]) \n")
                    print("png文件\(pngFiles[index]) \n")
                    
                     let alert = NSAlert.init()
                     alert.messageText.append("检查到有文件名称不一致")
                     alert.informativeText = "请保持\(xmlFiles[index]).xml与png名称的统一"
                     alert.showsSuppressionButton = true
                     alert.runModal()
                 
                    return false
                }
                
        }
    
        return true
    }
    
    func creatFile(){
        
        self.fileAry = self.getFileNameAryInDirector(fileType:"xml")
        
        for fileName in self.fileAry {
            
            let xmlFilePath = newfilePath +  "/" + fileName
            let imageFilePath = xmlFilePath + "/\(imageFile)"
            
            do{
               
                try self.fm.createDirectory(atPath: self.newfilePath, withIntermediateDirectories: true, attributes: nil)
                
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
            
            // 模版 头部 xml
            let newStr  =  "<hotspot bounds=\"{{0., 0.}, {\(self.imageWidth!), \(self.imageheight!)}}\"" + " anchorPoint=\"{.5, .928}\"" +  " originSize=\"{\(originSize)}\"" +  " center=\"{0., 0.}\">" + "\n" + "<backgroundImage state=\"0\" value=\"images/icon.png\" /> \n"
            
            for item in firtXml{
                
                 var str = try String.init(contentsOfFile: item, encoding: String.Encoding.isoLatin2)
                
                // 移除头部信息
                str.removeSubrange(str.index(str.startIndex, offsetBy: 0)...str.index(str.startIndex, offsetBy: 39))
                
                // 保存 frame 的数据
                let strFrame = str.data(using: String.Encoding.isoLatin2)!
                
                let newData = newStr.data(using: String.Encoding.utf8)! + strFrame
                
                // 写入 覆盖
                let fm = FileHandle.init(forWritingAtPath: item as String!)
                fm?.seek(toFileOffset: 0)
                fm?.write(newData as Data!)
                fm?.closeFile()
                
            }
            
        } catch let error{
            

            print(error)
            
        }
        
    }
    
    
}


