//
//  PMManager.swift
//  PerformanceMonitor
//
//  Created by Himanshu Namdeo on 18/09/20.
//  Copyright © 2020 8BitArcade. All rights reserved.
//

import Foundation

protocol PMManagerDataCollector: class {
    func didRecieve(payload: PMDiagnosticDataModel?)
}

public class PMManager: PMManagerDataCollector {
    
    public static let shared = PMManager()
    weak var delegate: PMManagerSubscriber?
    
    private init() {
        
    }
    
    public func addObserver(subscriber: PMManagerSubscriber?) {
        guard let subscriber = subscriber else { assert(true, ""); return }
        delegate = subscriber
        let hub = MonitorHub()
        hub.delegate = self
        hub.startFetching()
    }
    
    public func removeObserver(subscriber: PMManagerSubscriber?) {
        delegate = nil
    }
    
    func didRecieve(payload: PMDiagnosticDataModel?) {
        if let payload = payload {
            delegate?.didRecieve(diagnosePayload: payload)
        }
    }
}
