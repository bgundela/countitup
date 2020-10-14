//
//  ContentView.swift
//  CountItUp!
//
//  Created by Bhuvan Gundela on 10/7/20.
//

import SwiftUI

struct ContentView: View {
    @State var color = "Orange"
    
    var body: some View {
        TabView {
            HomeView()
            .tabItem {
                Image(systemName: "house.fill")
                
                Text("Home")
            }
            
            GroupView()
            .tabItem {
                Image(systemName: "person.3")
                
                Text("Group")
            }
            
            HistoryView()
            .tabItem {
                Image(systemName: "folder.circle.fill")
                
                Text("History")
            }
            
            SettingsView()
            .tabItem {
                Image(systemName: "gear")
                    
                Text("Settings")
            }
        }
        .accentColor(Color("\(color)"))
        .onAppear {
            guard let retrievedColor = UserDefaults.standard.value(forKey: "color") else {
                return
            }

            self.color = retrievedColor as! String
        }
    }
}
