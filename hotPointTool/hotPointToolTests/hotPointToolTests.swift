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

            var newStrPath =  "/Users/keney/Desktop/地块005.xml"
            var str = try String.init(contentsOfFile: newStrPath, encoding: String.Encoding.isoLatin2)
            
            str.removeSubrange(str.index(str.startIndex, offsetBy: 0)...str.index(str.startIndex, offsetBy: 39))
            let strFrame = str.data(using: String.Encoding.isoLatin2)!
            
  
            let modelPath =  "/Users/keney/Desktop/hotspotdatafile.xml"
            let modelStr = try  String.init(contentsOfFile: modelPath).data(using: String.Encoding.isoLatin2)!
            
            let newData = modelStr + strFrame

            let fm = FileHandle.init(forWritingAtPath: newStrPath)
            fm?.seek(toFileOffset: 0)
            fm?.write(newData)
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
