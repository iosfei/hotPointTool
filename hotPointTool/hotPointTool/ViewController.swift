//
//  ViewController.swift
//  hotPointTool
//
//  Created by keney on 2016/10/26.
//  Copyright © 2016年 keney. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
         let vc = hotPointTool.init()
        
             vc.creatFile()
        
             vc.copyFileToObject()
        
             vc.getPngMessges()
        
             vc.editXML()
        
    }
    
    
    

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}


