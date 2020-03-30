//
//  ContentView.swift
//  GameKitExample
//
//  Created by Sebastian Buys on 3/30/20.
//  Copyright © 2020 Sebastian Buys. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {
    @ObservedObject var gameManager = GameManager()
    
    @State var error: GameManager.GameError?


    func ErrorAlert(_ error: GameManager.GameError) -> Alert {
        return Alert(title: Text("Game Error"),
              message: Text(error.message),
              dismissButton: Alert.Button.default(Text("Okay"), action: {
                self.gameManager.removeError(error.id)
              }))
    }
    
    var body: some View {
        ZStack {
            // Wrapper view for presenting a UIKit ViewController
            // authenticationViewController and leaderboardViewController are UIViewControllers that GameCenter provides
            ViewControllerPresenterView(viewControllerToPresent:
                $gameManager.authenticationViewController)

            ViewControllerPresenterView(viewControllerToPresent:
            $gameManager.leaderboardViewController)
            
            // Render the "game" only if user is authenticated
            if gameManager.isAuthenticated == true {
                VStack {
                    Text("Score").font(Font.largeTitle)
                    
                    Text("\(gameManager.score)").font(Font.largeTitle).fontWeight(.regular)
                    
                    Spacer()
                    
                    Button(action: {
                        self.gameManager.incrementScore()
                    }) {
                        Text("+1").font(Font.largeTitle)
                    }
                    
                    Spacer()
                    
                    Text("You are playing as \(gameManager.displayName)")
                        .padding(.bottom)
                    
                    Button("View leaderboard") {
                        self.gameManager.showLeaderboard()
                    }
                }.padding()
            }
        }.onReceive(gameManager.$errors) {
            self.error = $0.first
        }.alert(item: $error) {
            ErrorAlert($0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
