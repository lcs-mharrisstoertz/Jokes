//
//  JokesApp.swift
//  Jokes
//
//  Created by Morgan Harris-Stoertz on 2023-04-14.
//

import SwiftUI

@main
struct JokesApp: App {
    var body: some Scene {
        WindowGroup {
            TabView{
                JokeView()
                    .tabItem{
                        Label("Fresh", systemImage: "carrot")
                    }
                FavouritesView()
                    .tabItem{
                        Label("Favourites", systemImage: "face.smiling")
                    }
            }
            .environment(\.blackbirdDatabase, AppDatabase.instance)
        }
    }
}
