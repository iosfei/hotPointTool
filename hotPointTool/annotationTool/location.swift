//
//  location.swift
//  hotPointTool
//
//  Created by keney on 2017/2/8.
//  Copyright © 2017年 keney. All rights reserved.
//

import Foundation


class location : NSObject{
    
    var address : String
    var createtime : String
    var id : String
    var lat : String
    var lon : String
    var name : String
    var updatetime : String
    
   override init() {

        self.address = ""
        self.createtime = ""
        self.id = ""
        self.lat = ""
        self.lon = ""
        self.name = ""
        self.updatetime = ""
    
    }


}
