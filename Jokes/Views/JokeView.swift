//
//  JokeView.swift
//  Jokes
//
//  Created by Morgan Harris-Stoertz on 2023-04-14.
//

import SwiftUI

struct JokeView: View {
    
    //MARK: stored properties
    @State var punchlineOpacity = 0.0
    @State var currentJoke = exampleJoke
    
    //MARK: computed properties
    var body: some View {
        NavigationView{
            VStack{
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
                
            }
            .navigationTitle("Random Jokes")
        }
    }
}

struct JokeView_Previews: PreviewProvider {
    static var previews: some View {
        JokeView()
    }
}
