//
//  JokeView.swift
//  Jokes
//
//  Created by Morgan Harris-Stoertz on 2023-04-14.
//
import Blackbird
import SwiftUI

struct JokeView: View {
    
    //MARK: stored properties
    @Environment(\.blackbirdDatabase)var db: Blackbird.Database?
    @State var punchlineOpacity = 0.0
    @State var currentJoke: Joke?
    
    //MARK: computed properties
    var body: some View {
        NavigationView{
            VStack{
                
                Spacer()
                
                if let currentJoke = currentJoke{
                    Text(currentJoke.setup)
                        .font(.title)
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
                        withAnimation(.easeIn(duration:1.0)){
                            punchlineOpacity = 1.0
                            
                        }
                        
                    }, label: {
                        Image(systemName: "arrow.down.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40)
                            .tint(.black)
                    })
                    
                    Text(currentJoke.punchline)
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .opacity(punchlineOpacity)
                } else{
                    ProgressView()
                }
                
              Spacer()
                
                Button (action: {
                    punchlineOpacity = 0.0
                    Task{
                        withAnimation{
                            currentJoke = nil
                        }
                        currentJoke = await NetworkService.fetch()
                    }
                }, label: {
                    Text("New Joke")
                })
                .disabled(punchlineOpacity == 0.0 ? true : false)
                .buttonStyle(.borderedProminent)
                
                Button(action: {
                    Task{
                        if let currentJoke = currentJoke{
                            try await db!.transaction { core in
                                try core.query("INSERT INTO Joke (id, type, setup, punchline) VAlUES (?,?,?,?)",
                                               currentJoke.id,
                                               currentJoke.type,
                                               currentJoke.setup,
                                               currentJoke.punchline)
                            }
                        }
                    }
                }, label: {
                   Text("Save Joke")
                })
                .disabled(punchlineOpacity == 0.0 ? true: false)
                .tint(.pink)
                .buttonStyle(.borderedProminent)
                
            }
            .navigationTitle("Random Jokes")
        }
        
        .task{
            currentJoke = await NetworkService.fetch()
        }
    }
}

struct JokeView_Previews: PreviewProvider {
    static var previews: some View {
        JokeView()
            .environment(\.blackbirdDatabase, AppDatabase.instance)
    }
}
