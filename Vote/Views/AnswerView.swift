//
//  AnswerView.swift
//  Vote
//
//  Created by Tiziano Coroneo on 05/12/2017.
//  Copyright © 2017 Tiziano Coroneo. All rights reserved.
//

import UIKit

class AnswerView: QuestionView {

    @IBOutlet weak var voteLabel: UILabel!
    
    private var utilityStyle = AppDelegate.style.answerView
    override var style: QuestionView.Style {
        get { return utilityStyle }
        set {
            utilityStyle = newValue
            super.update(withStyle: newValue)
        }
    }
    
    var voteCount: Int = 0 {
        didSet { voteLabel.text = "\(voteCount)" }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        voteLabel.textColor = style.symbolColor
    }
}
