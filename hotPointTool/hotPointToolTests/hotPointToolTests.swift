//
//  hotPointToolTests.swift
//  hotPointToolTests
//
//  Created by keney on 2016/10/26.
//  Copyright © 2016年 keney. All rights reserved.
//

import XCTest
@testable import hotPointTool

class hotPointToolTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        do{

            // 获取待处理xml 路径和文本
            let newStrPath =  "/Users/keney/Desktop/地块005.xml"
            var str = try String.init(contentsOfFile: newStrPath, encoding: String.Encoding.isoLatin2)
            
            // 移除头部信息
            str.removeSubrange(str.index(str.startIndex, offsetBy: 0)...str.index(str.startIndex, offsetBy: 39))
            
            // 保存 frame 的数据
            let strFrame = str.data(using: String.Encoding.isoLatin2)!
            
            // 模版头部信息
            let modelPath =  "/Users/keney/Desktop/hotspotdatafile.xml"
            let modelStr = try  String.init(contentsOfFile: modelPath).data(using: String.Encoding.isoLatin2)!
            
            
            //print(try  String.init(contentsOfFile: modelPath))
            // 拼接 模版头部 和 frame 的数据
            //let newData = modelStr + strFrame
            
            
            
            let newStr =   "<hotspot bounds=\"{{0., 0.}, {50.0, 50.0}}\"" + " anchorPoint=\"{.5, .928}\"" +  " originSize=\"{2048.0, 1536.0}\"" +  " center=\"{0., 0.}\">" + "\n" +
            
                            "<backgroundImage state=\"0\" value=\"images/icon.png\" />"
        

            let strData = newStr.data(using: String.Encoding.isoLatin2)
            
            // 写入 覆盖
            let fm = FileHandle.init(forWritingAtPath: newStrPath)
            fm?.seekToEndOfFile()
            fm?.write(strData!)
            fm?.closeFile()
            
            
        } catch let error {
            
            print(error)
        }
        
        
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
