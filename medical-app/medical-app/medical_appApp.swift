//
//  medical_appApp.swift
//  medical-app
//
//  Created by Letícia França on 23/03/25.
//

import SwiftUI

@main
struct medical_appApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                PacientesView()
                    .tabItem {
                        Label("Pacientes", systemImage: "person.3.fill")
                    }
                
                ConsultasView()
                    .tabItem {
                        Label("Consultas", systemImage: "calendar.badge.plus")
                    }
            }
        }
    }
}
