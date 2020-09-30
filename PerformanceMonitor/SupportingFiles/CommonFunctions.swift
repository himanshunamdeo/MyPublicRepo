//
//  CommonFunctions.swift
//  PerformanceMonitor
//
//  Created by Himanshu Namdeo on 21/09/20.
//  Copyright © 2020 8BitArcade. All rights reserved.
//

import Foundation


func roundOf(upto decimalPosition: Int, number: Any) -> NSNumber {
    var num: NSNumber?
    if number is Double {
        num = NSNumber(value: number as! Double)
    } else if number is Int {
        num = NSNumber(value: number as! Int)
    } else if number is Float {
        num = NSNumber(value: number as! Float)
    }
    
    if let num = num {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = decimalPosition
        let formattedAmount = formatter.string(from: num)!
        return formatter.number(from: formattedAmount)!
    }
    
    return 0
}
