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
    
    let navBarStyle: VoteNavigationBar.Style = navigationBar
    
    var questionView: QuestionView.Style = questionStyle
    var answerView: QuestionView.Style = answerStyle
}

extension AppDelegate {
    static func setupSystemAppearance() {
        UIView.appearance().tintColor = UIColor.voteDarkGrey
        UITabBar.appearance().backgroundColor = UIColor.voteLightGrey
    }
}

fileprivate var questionStyle: QuestionView.Style {
    return QuestionView.Style.init(
        cornerRadius: 10,
        backgroundColor: UIColor.voteLightGrey,
        borderWidth: 0,
        borderColor: UIColor.clear,
        textColor: UIColor.voteDarkGrey,
        symbolColor: UIColor.voteDarkGrey,
        countColor: UIColor.clear
    )
}

fileprivate var answerStyle: QuestionView.Style {
    return QuestionView.Style
        .init(
        cornerRadius: 10,
        backgroundColor: UIColor.voteDarkGrey,
        borderWidth: 0,
        borderColor: UIColor.clear,
        textColor: UIColor.voteLightGrey,
        symbolColor: UIColor.voteLightGrey,
        countColor: UIColor.voteLightGrey
    )
}

fileprivate var navigationBar: VoteNavigationBar.Style {
    return VoteNavigationBar.Style.init(
        statusBarColor: .default,
        backgroundColor: UIColor.voteLightGrey,
        itemsTintColor: UIColor.voteDarkGrey,
        titleColor: UIColor.voteDarkGrey)
}

