//
//  StyleGlobals.swift
//  Vote
//
//  Created by Tiziano Coroneo on 03/12/2017.
//  Copyright © 2017 Tiziano Coroneo. All rights reserved.
//

import UIKit

struct StyleGuide {
    
    let cornerRadius: CGFloat = 10
    
    let statusBarColor: UIStatusBarStyle = .default
    
    let navBarBackgroungColor: UIColor = UIColor.voteLightGrey
    let navBarItemsTintColor: UIColor = UIColor.voteDarkGrey
    let navBarTitleColor: UIColor = UIColor.voteDarkGrey
    
    let navBarStyle = VoteNavigationBar.Style()
    
    var questionStyle: QuestionView.Style = QuestionView.Style.questionStyle
    let answerStyle: QuestionView.Style = QuestionView.Style.answerStyle
}

extension AppDelegate {
    static func setupSystemAppearance() {
        UIView.appearance().tintColor = UIColor.voteDarkGrey
        UITabBar.appearance().backgroundColor = UIColor.voteLightGrey
    }
}

extension QuestionView {
    struct Style {
        var cornerRadius: CGFloat { return AppDelegate.style.cornerRadius }
        
        let backgroundColor: UIColor
        let borderWidth: CGFloat
        let borderColor: UIColor
        let textColor: UIColor
        let symbolColor: UIColor
        
        static var questionStyle: Style {
            return Style.init(
                backgroundColor: UIColor.voteLightGrey,
                borderWidth: 0,
                borderColor: UIColor.clear,
                textColor: UIColor.voteDarkGrey,
                symbolColor: UIColor.voteDarkGrey
            )
        }
        
        static var answerStyle: Style {
            return Style.init(
                backgroundColor: UIColor.voteDarkGrey,
                borderWidth: 0,
                borderColor: UIColor.clear,
                textColor: UIColor.voteLightGrey,
                symbolColor: UIColor.voteLightGrey
            )
        }
    }
}
