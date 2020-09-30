//
//  MonitorHub.swift
//  PerformanceMonitor
//
//  Created by Himanshu Namdeo on 18/09/20.
//  Copyright © 2020 8BitArcade. All rights reserved.
//

import Foundation

protocol DataCollector {
    func didRecieve(data: Any, from monitor: Monitor)
}

enum MonitorType {
    case cpu
}

class MonitorHub: DataCollector {
    
    private var payload: PMDiagnosticDataModel = PMDiagnosticDataModel()
    public weak var delegate: PMManagerDataCollector?
    private var monitor: CPUMonitor?
    private var memMonitor: MemoryMonitor?
    
    init() {
        monitor = CPUMonitor()
        monitor?.delegate = self
        memMonitor = MemoryMonitor()
        memMonitor?.delegate = self
    }
    
    func startFetching() {
        monitor?.startFetching()
        memMonitor?.startFetching()
    }
    
    func stopFetching() {
        monitor?.stopFetching()
        memMonitor?.stopFetching()
    }
    
    func didRecieve(data: Any, from monitor: Monitor) {

        var key: String = ""
        var value: Any?
        
        if monitor is CPUMonitor {
            
            key = "CPUUsage"
            
            value = roundOf(upto: 2, number: data)
            
        } else if monitor is MemoryMonitor {
            key = "MemoryUsage"
            value = roundOf(upto: 2, number: data)
        }
        
        payload.monitorTypeKey = key
        payload.monitorTypeValue = value
        delegate?.didRecieve(payload: payload)
    }
}
