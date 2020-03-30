//
//  GameManager.swift
//  GameKitExample
//
//  Created by Sebastian Buys on 3/30/20.
//  Copyright © 2020 Sebastian Buys. All rights reserved.
//

import Foundation
import Combine
import GameKit

class GameManager: NSObject, ObservableObject {
    // Constant used as key for saving and loading the user's score locally to UserDefaults
    let UserDefaultsScoreKey = "score"
    
    // ID for GameCenter Leaderboard
    // Make sure this matches the value you set on AppStore Connect
    let GameCenterLeaderboardId = "scores"
    
    // Custom error type that conforms to the Identifiable protocol
    struct GameError: Identifiable {
        var id = UUID()
        var message: String
    }
    
    // ViewControllers provided by GameKit / GameCenter
    // These are UIKit classes, so we'll present them from SwiftUI
    // using the ViewControllerPresenter helper class
    
    @Published var authenticationViewController: UIViewController?
    @Published var leaderboardViewController: UIViewController?
    
    @Published var errors: [GameManager.GameError] = []
    
    // GKLocalPlayer is the current player authenticated on the device
    var player: GKLocalPlayer {
        return GKLocalPlayer.local
    }
    
    @Published var isAuthenticated: Bool = false
    @Published var displayName: String = ""
    @Published var score: Int = 0
    
    override init() {
        super.init()
        
        // Grab score from user defaults
        self.score = UserDefaults.standard.integer(forKey: UserDefaultsScoreKey)
        
        // GKLocalPlayer.local is a singleton (shared instance)
        // We set the authenticateHandle to catch any authentication related events
        GKLocalPlayer.local.authenticateHandler = { [weak self] (viewController, error) in
            guard let self = self else { return }
            
            // Anytime this handler is called, we should update any states we need related to the player
            self.isAuthenticated = self.player.isAuthenticated
            self.displayName = self.player.displayName
            
            // viewController is an optional (possibly nil) UIViewController instance.
            // If it is nil, the authentication process is complete.
            // Otherwise it contains a UIViewController instance to display to the user
            self.authenticationViewController = viewController
            
            // Don't set error if we receive a viewController in the authenticate handler
            // guard viewController == nil else { return }
            
            // error is an optional (possibly nil) error object that describes any error that occured.
            // Common errors include:
            // - GKError.Code.gameUnrecognized (You have not enabled Game Center for your app in App Store Connect. Sign in to your App Store Connect account and verify that your app has Game Center enabled)
            // - GKError.Code.notSupported error means that the device your game is running on does not support Game Center.
            // See https://developer.apple.com/documentation/gamekit/gklocalplayer/1515399-authenticatehandler
            if let error = error {
                self.logError(error)
            }
        }
    }
    
    // MARK: - Scoring
    private func getScoreFromUserDefaults() -> Int {
        return UserDefaults.standard.integer(forKey: UserDefaultsScoreKey)
    }
    
    func incrementScore() {
        // Update our local score
        self.score = self.score + 1
        
        // Save score to UserDefaults
        saveScore(self.score)
        
        // Update score via GameCenter
        let score = GKScore(leaderboardIdentifier: GameCenterLeaderboardId)
        score.value = Int64(self.score)
        
        GKScore.report([score]) { error in
            if let error = error {
                self.logError(error)
            } else {
                print("Score \(score.value) received by GameCenter!")
            }
        }
    }
    
    // Save score to UserDefaults
    private func saveScore(_ score: Int) {
        UserDefaults.standard.set(score, forKey: UserDefaultsScoreKey)
    }
    
    // MARK: - Leaderboard
    func showLeaderboard() {
        let controller = GKGameCenterViewController()
        controller.viewState = .leaderboards
        controller.leaderboardTimeScope = .allTime
        controller.leaderboardIdentifier = GameCenterLeaderboardId
        controller.gameCenterDelegate = self
        self.leaderboardViewController = controller
    }
    
    // MARK: - Error handling
    func logError(_ error: Error) {
        self.errors.append(GameError(message: error.localizedDescription))
    }
    
    func removeError(_ id: UUID) {
        self.errors.removeAll {
            $0.id == id
        }
    }
}

extension GameManager: GKGameCenterControllerDelegate {
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true) { [weak self] in
            self?.leaderboardViewController = nil
        }
    }
}

