//
//  AppDelegate.swift
//  PerformanceMonitorDemo
//
//  Created by Himanshu Namdeo on 18/09/20.
//  Copyright © 2020 8BitArcade. All rights reserved.
//

import UIKit
import PerformanceMonitor
import MetricKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, PMManagerSubscriber, MXMetricManagerSubscriber {
    func didReceive(_ payloads: [MXMetricPayload]) {
        for payload in payloads {
            print("=====================Metric Kit====================")
            print("CPU = \(String(describing: payload.cpuMetrics?.cumulativeCPUTime))")
            print("Memory USage = \(String(describing: payload.memoryMetrics?.peakMemoryUsage))")
            print("Disk Wright = \(String(describing: payload.diskIOMetrics?.cumulativeLogicalWrites))")
            print("Downloaded Data = \(String(describing: payload.networkTransferMetrics?.cumulativeWifiDownload))")
            print("====================================================")
        }
    }
    
    
    func didRecieve(diagnosePayload: PMDiagnosticDataModel) {
        print(diagnosePayload.jsonRepresentation())
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        PMManager.shared.addObserver(subscriber: self)
        MXMetricManager.shared.add(self)
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        PMManager.shared.removeObserver(subscriber: self)
        MXMetricManager.shared.remove(self)
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

