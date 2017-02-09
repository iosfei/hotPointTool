//
//  locationCoordinate.swift
//  hotPointTool
//
//  Created by keney on 2016/12/12.
//  Copyright © 2016年 keney. All rights reserved.
//

import Cocoa

class locationCoordinate: NSObject {
    
   
    override init() {

        super.init()
        
        let stream = InputStream(fileAtPath: "/Users/keney/Downloads/地图_20170117135705.csv")!
        
        var rowAry: [CSV.Element] = []
        
        for row in try! CSV(stream: stream) {
            
            rowAry.append(row)
            
        }
        
        // 分离列数据和行数据
        var idAry : [String] = []
        var newRowAry : [CSV.Element] = []
        for (index, _) in rowAry.enumerated(){
            
            if index == 0{
                
                idAry = rowAry[0]
                
            }else{
                
                newRowAry.append(rowAry[index])
            }
            
        }
        
        // 组合行数据成字典数组
        var newDictAry : [AnyObject] = []
        
        for (index, _) in newRowAry.enumerated() {
            
            var dict  =  [String: String]()
            
            for (idIndex, _) in idAry.enumerated() {
                
                dict.updateValue(newRowAry[index][idIndex], forKey: idAry[idIndex])
            }
            
            newDictAry.append(dict as [String: String] as AnyObject)
        }
        
        
        var loAry : [location] = []
        
        // 字典数组转对象数组
        for (index, _) in newDictAry.enumerated() {
            
            let lo = location()
            lo.address = newDictAry[index].value(forKey: "address")! as! String
            lo.createtime = newDictAry[index].value(forKey: "createtime")! as! String
            lo.id = newDictAry[index].value(forKey: "id")! as! String
            lo.lat = newDictAry[index].value(forKey: "lat")! as! String
            lo.lon = newDictAry[index].value(forKey: "lon")! as! String
            lo.name = newDictAry[index].value(forKey: "name")! as! String
            lo.updatetime = newDictAry[index].value(forKey: "updatetime")! as! String
            
            loAry.append(lo)
        }
        
        for (index, _) in loAry.enumerated() {
            
            print(loAry[index].name, loAry[index].lat, loAry[index].lon, loAry[index].address, loAry[index].createtime, loAry[index].id, loAry[index].createtime)
            
        }
            print("loAry==========================\(loAry)")

    }

}

