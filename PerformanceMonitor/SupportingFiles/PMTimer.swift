//
//  PMTimer.swift
//  PerformanceMonitor
//
//  Created by Himanshu Namdeo on 18/09/20.
//  Copyright © 2020 8BitArcade. All rights reserved.
//

import Foundation

typealias PMTask = (Timer) -> ()
struct PMTimer {
    
    private var task: PMTask = {(timer) in }
    private lazy var timer: Timer = Timer()
    
    init() {
    }
    init(with task: PMTask?) {
        if let task = task  {
            self.task = task
        } else {
            assert(true, "Must have the task")
        }
        
    }
    
    public mutating func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: task)
    }
    
    public mutating func stop() {
        timer.invalidate()
    }
}
