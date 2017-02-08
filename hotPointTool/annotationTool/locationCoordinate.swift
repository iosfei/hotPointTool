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
            
            newDictAry.append(dict as AnyObject)
        }
        
        print("newDictAry==========================\(newDictAry)")
    
    }
    

    

}

