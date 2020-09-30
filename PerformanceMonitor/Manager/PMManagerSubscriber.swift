//
//  PMManagerSubscriber.swift
//  PerformanceMonitor
//
//  Created by Himanshu Namdeo on 18/09/20.
//  Copyright © 2020 8BitArcade. All rights reserved.
//

import Foundation

public protocol PMManagerSubscriber: class {
    func didRecieve(diagnosePayload: PMDiagnosticDataModel)
}
