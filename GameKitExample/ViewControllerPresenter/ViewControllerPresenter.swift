//
//  ViewControllerPresenter.swift
//  GameKitExample
//
//  Created by Sebastian Buys on 3/30/20.
//  Copyright © 2020 Sebastian Buys. All rights reserved.
//

import Foundation
import UIKit

class ViewControllerPresenter: UIViewController {
    var viewControllerToPresent: UIViewController? {
        didSet {
            // Dismiss any view controllers that may already be presented modally
            // self.dismiss(animated: true)
            
            // If viewControllerToPresent is not nil, present it
            if let vc = viewControllerToPresent {
                self.present(vc, animated: true)
            }
        }
    }
}
