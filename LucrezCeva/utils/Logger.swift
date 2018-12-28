//
//  Logger.swift
//  LucrezCeva
//
//  Created by Suciu Radu on 26/11/2018.
//  Copyright © 2018 LucrezCeva. All rights reserved.
//

import Foundation
import Crashlytics

class Logger {
    
    public static func log(_ items: Any...) {
        print("------\n", items, "\n------")
        Crashlytics.sharedInstance().recordError(NSError.init(domain: "\(items)", code: 0, userInfo: nil))
    }
    
    public static func localLog(_ items: Any...) {
        print("------\n", items, "\n------")
    }
    
    public static func testCrash() {
        Crashlytics.sharedInstance().crash()
    }
}
