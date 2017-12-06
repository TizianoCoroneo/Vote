//
//  PrimarySplitViewController.swift
//  Vote
//
//  Created by Tiziano Coroneo on 05/12/2017.
//  Copyright © 2017 Tiziano Coroneo. All rights reserved.
//

import UIKit

class PrimarySplitViewController: UISplitViewController,
UISplitViewControllerDelegate {
    
    override func viewDidLoad() {
        self.delegate = self
        self.preferredDisplayMode = .allVisible
    }
    
    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController) -> Bool {
        // Return true to prevent UIKit from applying its default behavior
        return true
    }
}
