//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Azharuddin 1 on 27/11/22.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
