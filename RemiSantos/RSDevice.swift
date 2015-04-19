//
//  RSDevice.swift
//  RSDevice
//
//  Created by Remi Santos on 23/09/2014.
//  Copyright (c) 2014 Remi Santos. All rights reserved.
//

import UIKit

let kAppInfoFirstLaunch = "kAppInfoFirstLaunch"

class RSDevice: NSObject {
   
    //Sizes
    class func is5Point5inches() -> Bool {
        return UIScreen.mainScreen().bounds.size.height == 736
    }
    class func is4Point7inches() -> Bool {
        return UIScreen.mainScreen().bounds.size.height == 667
    }
    class func isWideiPhone() -> Bool {
        return UIScreen.mainScreen().bounds.size.height > 568
    }
    class func is4inches() -> Bool {
        return UIScreen.mainScreen().bounds.size.height == 568
    }
    class func is3Point5inches() -> Bool {
        return UIScreen.mainScreen().bounds.size.height == 480
    }
    
    //Versions
    class func iOSVersion() -> Float {
        return (UIDevice .currentDevice().systemVersion as NSString).floatValue
    }
    class func isIOSGreaterThan(than:Float) -> Bool {
        return RSDevice.iOSVersion() > than
    }
    class func isIOSGreaterThanOrEqualTo(to:Float) -> Bool {
        return RSDevice.iOSVersion() > to
    }
    class func isIOS7() -> Bool {
        return RSDevice.iOSVersion() > 7.0 && RSDevice.iOSVersion() < 8.0
    }
    class func isIOS8() -> Bool {
        return RSDevice.iOSVersion() > 8.0 && RSDevice.iOSVersion() < 9.0
    }
    
    class func isFirstLaunch() -> Bool {
        let firstLaunch = NSUserDefaults.standardUserDefaults().boolForKey(kAppInfoFirstLaunch)
        if firstLaunch != true {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: kAppInfoFirstLaunch)
            return true
        }
        return false
    }
}
