//
//  BatteryMonitorViewModel.swift
//  DeviceMonitor
//
//  Created by white4ocolate on 08.08.2025.
//

import Foundation

@available(iOS 13.0, *)
public final class BatteryMonitorViewModel: ObservableObject {
    public init() {}
    
    public func startMonitoring() {
        BatteryMonitoringService.shared.start()
    }
    
    public func stopMonitoring() {
        BatteryMonitoringService.shared.stop()
    }
}
