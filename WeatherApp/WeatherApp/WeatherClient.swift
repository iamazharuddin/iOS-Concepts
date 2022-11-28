//
//  WeatherAPIClient.swift
//  WeatherApp
//
//  Created by Bahalek on 2021-12-25.
//

import Foundation
import CoreLocation
import SwiftUI
let API_KEY = "JyRla89QTGphnrZMiNFpeLQJTfuvRaX1"
final class WeatherAPIClient: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var currentWeather: Weather?
    
    private let locationManager = CLLocationManager()
    private let dateFormatter = ISO8601DateFormatter()
    
    override init() {
        super.init()
        locationManager.delegate = self
        requestLocation()
    }

    func fetchWeather() async {
        guard let location = locationManager.location else {
            requestLocation()
            return
        }
        

        guard let url = URL(string: "https://api.tomorrow.io/v4/timelines?location=\(location.coordinate.latitude),\(location.coordinate.longitude)&fields=temperature&fields=weatherCode&units=metric&timesteps=1h&startTime=\(dateFormatter.string(from: Date()))&endTime=\(dateFormatter.string(from: Date().addingTimeInterval(60 * 60)))&apikey=\(API_KEY)") else {
            return
        }
        
        do {
            let (data,_) = try await URLSession.shared.data(from: url)
            print(String(data: data, encoding: .ascii)!)
            if let weatherResponse = try? JSONDecoder().decode(WeatherModel.self, from: data),
               let weatherValue = weatherResponse.data.timelines.first?.intervals.first?.values,
               let weatherCode = WeatherCode(rawValue: "\(weatherValue.weatherCode)") {
                DispatchQueue.main.async { [weak self] in
                    self?.currentWeather = Weather(temperature: Int(weatherValue.temperature),
                                                   weatherCode: weatherCode)
                }
            }
        } catch {
            // handle the error
        }
    }
    
    private func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        Task {
            await fetchWeather()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // handle error
    }
}
