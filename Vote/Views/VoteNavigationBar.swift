//
//  VoteNavigationBar.swift
//  Vote
//
//  Created by Tiziano Coroneo on 03/12/2017.
//  Copyright © 2017 Tiziano Coroneo. All rights reserved.
//

import UIKit

class VoteNavigationBar: UINavigationBar {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupColor(AppDelegate.style.navBarStyle)
    }

    private func setupColor(_ style: Style) {
        UIApplication.shared.statusBarStyle = style.statusBarColor
        self.barTintColor = style.backgroundColor
        self.tintColor = style.itemsTintColor
        self.titleTextAttributes = [NSAttributedStringKey.foregroundColor : style.titleColor]
    }

}

extension VoteNavigationBar {
    struct Style {
        let statusBarColor: UIStatusBarStyle = .default
        let backgroundColor: UIColor = UIColor.voteLightGrey
        let itemsTintColor: UIColor = UIColor.voteDarkGrey
        let titleColor: UIColor = UIColor.voteDarkGrey
    }
}
