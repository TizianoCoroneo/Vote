//
//  AnswerView.swift
//  Vote
//
//  Created by Tiziano Coroneo on 05/12/2017.
//  Copyright © 2017 Tiziano Coroneo. All rights reserved.
//

import UIKit

@IBDesignable
class AnswerView: QuestionView {

    @IBOutlet private weak var voteLabel: UILabel!
    
    var voteCount: Int = 0 {
        didSet { voteLabel?.text = "\(voteCount)" }
    }
    
    override var xibFileName: String {
        return "AnswerView"
    }
    
    override var preferredStyle: Style {
        return AppDelegate.style.answerView
    }
    
    override func update(withStyle style: Style) {
        super.update(withStyle: style)
        voteLabel?.textColor = style.symbolColor
    }
}
