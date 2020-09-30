//
//  Monitor.swift
//  PerformanceMonitor
//
//  Created by Himanshu Namdeo on 18/09/20.
//  Copyright © 2020 8BitArcade. All rights reserved.
//

import Foundation

protocol Monitor {
    var delegate: DataCollector? { get set }
    func startFetching()
    func stopFetching()
}
