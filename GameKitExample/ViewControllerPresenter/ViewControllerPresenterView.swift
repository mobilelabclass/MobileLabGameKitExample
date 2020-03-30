//
//  ViewControllerPresenterView.swift
//  GameKitExample
//
//  Created by Sebastian Buys on 3/30/20.
//  Copyright © 2020 Sebastian Buys. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

struct ViewControllerPresenterView: UIViewControllerRepresentable {
    @Binding var viewControllerToPresent: UIViewController?
    
    func makeUIViewController(context: Context) -> ViewControllerPresenter {
        let viewController = ViewControllerPresenter()
        viewController.viewControllerToPresent = viewControllerToPresent
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: ViewControllerPresenter, context: Context) {
        uiViewController.viewControllerToPresent = viewControllerToPresent
    }
    
    typealias UIViewControllerType = ViewControllerPresenter
}
