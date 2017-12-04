//
//  StyleGlobals.swift
//  Vote
//
//  Created by Tiziano Coroneo on 03/12/2017.
//  Copyright © 2017 Tiziano Coroneo. All rights reserved.
//

import UIKit

struct StyleGuide {
    
    let statusBarColor: UIStatusBarStyle = .default
    
    let navBarBackgroungColor: UIColor = UIColor.voteLightGrey
    let navBarItemsTintColor: UIColor = UIColor.voteDarkGrey
    let navBarTitleColor: UIColor = UIColor.voteDarkGrey
    
    let navBarStyle = VoteNavigationBar.Style()
    
    let textTableViewCellStyle = QuestionTableViewCell.Style()
}

extension AppDelegate {
    static func setupSystemAppearance() {
        UIView.appearance().tintColor = UIColor.voteDarkGrey
        UITabBar.appearance().backgroundColor = UIColor.voteLightGrey
    }
}

extension QuestionTableViewCell {
    struct Style {
        let cornerRadius: CGFloat = 10
 
        let questionBackgroundColor: UIColor = UIColor.voteLightGrey
        let questionBorderWidth: CGFloat = 0
        let questionBorderColor: UIColor = UIColor.clear
        let questionTextColor: UIColor = UIColor.voteDarkGrey
        let questionSymbolColor: UIColor = UIColor.voteDarkGrey
        
        let answerBackgroundColor: UIColor = UIColor.voteDarkGrey
        let answerBorderWidth: CGFloat = 0
        let answerBorderColor: UIColor = UIColor.clear
        let answerTextColor: UIColor = UIColor.voteLightGrey
        let answerSymbolColor: UIColor = UIColor.voteLightGrey
    }
}
