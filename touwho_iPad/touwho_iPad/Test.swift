//
//  Test.swift
//  touwho_iPad
//
//  Created by apple on 15/12/4.
//  Copyright © 2015年 touhu.com. All rights reserved.
//

import UIKit


class Test: NSObject {
    let mgr = BTNetWorking.isTheStringContainedHttpWithString("www.baidu.com")
    func pint() {
       
        print((mgr))
    }
    
    
    
}

var instance = Test()

