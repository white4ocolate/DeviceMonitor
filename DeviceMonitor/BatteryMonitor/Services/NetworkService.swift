//
//  NetworkService.swift
//  DeviceMonitor
//
//  Created by white4ocolate on 08.08.2025.
//

import Foundation

final class NetworkService {
    static let shared = NetworkService()
    
    private init() {}
    
    func send(data: BatteryStatus) {
        guard let jsonData = try? JSONEncoder().encode(data) else { return }
        
        let base64String = jsonData.base64EncodedString()
        let body: [String: Any] = ["data": base64String]
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Network error:", error.localizedDescription)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response format")
                return
            }
            
            if (200...299).contains(httpResponse.statusCode) {
                print("Successfully sent battery data. Status code: \(httpResponse.statusCode)")
            } else {
                print("Server responded with error. Status code: \(httpResponse.statusCode)")
                if let data = data, let message = String(data: data, encoding: .utf8) {
                    print("Response body: \(message)")
                }
            }
        }
        
        task.resume()

    }
}
