//
//  FavouritesView.swift
//  Jokes
//
//  Created by Morgan Harris-Stoertz on 2023-04-18.
//

import Blackbird
import SwiftUI

struct FavouritesView: View {
    
    //MARK: Stored Properties
    @BlackbirdLiveModels({ db in
        try await Joke.read(from: db)
    }) var favouriteJokes
    
    //MARK: Computed properties
    var body: some View {
        NavigationView{
            List(favouriteJokes.results){currentJoke in VStack(alignment: .leading){
                Text(currentJoke.setup)
                    .bold()
                Text(currentJoke.punchline)
            }
            }
            .navigationTitle("Favourites")
        }
    }
}

struct FavouritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavouritesView()
            .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}
