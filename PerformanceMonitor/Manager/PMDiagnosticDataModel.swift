//
//  PMDiagnosticDataModel.swift
//  PerformanceMonitor
//
//  Created by Himanshu Namdeo on 18/09/20.
//  Copyright © 2020 8BitArcade. All rights reserved.
//

import Foundation

public class PMDiagnosticDataModel {
    
    var monitorTypeKey: String = ""
    var monitorTypeValue: Any?
    
    public func jsonRepresentation() -> String {
        return """
        {
            \(monitorTypeKey): \(monitorTypeValue)
        }
        """
    }
    init() {
        
    }
}
