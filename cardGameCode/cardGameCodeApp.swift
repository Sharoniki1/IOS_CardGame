//
//  cardGameCodeApp.swift
//  cardGameCode
//
//  Created by Student7 on 18/06/2023.
//
import MapKit
import SwiftUI

@main
struct cardGameCodeApp: App {
    @StateObject var locationManager = LocationManager()
    @StateObject var gameManager = GameManager()
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                    .environmentObject(locationManager)
                    .environmentObject(gameManager)
            

        }
       
    }
}
