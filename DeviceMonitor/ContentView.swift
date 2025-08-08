//
//  ContentView.swift
//  DeviceMonitor
//
//  Created by white4ocolate on 08.08.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = BatteryMonitorViewModel()

    var body: some View {
        VStack(spacing: 20) {
            Text("Battery Monitoring")
                .bold()
            Text("Data is sent every 2 minutes.")
                .foregroundColor(.gray)
        }
        .padding()
        .onAppear {
            viewModel.startMonitoring()
        }
        .onDisappear {
            viewModel.stopMonitoring()
        }
    }
}

#Preview {
    ContentView()
}
