//
//  BatteryMonitoringService.swift
//  DeviceMonitor
//
//  Created by white4ocolate on 08.08.2025.
//

import Foundation

import UIKit

final class BatteryMonitoringService {
    static let shared = BatteryMonitoringService()
    
    private var timer: Timer?
    private var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    
    private init() {
        UIDevice.current.isBatteryMonitoringEnabled = true
    }
    
    func start() {
        beginBackgroundTask()
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { _ in
            self.sendBatteryStatus()
        }
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
        UIDevice.current.isBatteryMonitoringEnabled = false
        endBackgroundTask()
    }
    
    private func sendBatteryStatus() {
        let level = UIDevice.current.batteryLevel
        let status = BatteryStatus(level: level, timestamp: Date())
        NetworkService.shared.send(data: status)
    }
    
    private func beginBackgroundTask() {
        backgroundTask = UIApplication.shared.beginBackgroundTask(withName: "BatteryMonitor") {
            self.endBackgroundTask()
        }
    }
    
    private func endBackgroundTask() {
        if backgroundTask != .invalid {
            UIApplication.shared.endBackgroundTask(backgroundTask)
            backgroundTask = .invalid
        }
    }
}
