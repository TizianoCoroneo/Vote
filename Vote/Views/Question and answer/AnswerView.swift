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
    
    override var xibFileName: String {
        return "AnswerView"
    }
    
    override func loadView() {
        super.loadView(
            withName: xibFileName,
            forSelf: self)
        update(withStyle: preferredStyle)
    }
    
    var voteCount: Int = 0 {
        didSet { updateVoteCount(voteCount) }
    }
    
    override var preferredStyle: QuestionView.Style {
        return AppDelegate.style.answerView
    }
  
    override func awakeFromNib() {
        super.awakeFromNib()
        updateVoteCount(voteCount)
    }
    
    override func update(withStyle style: QuestionView.Style) {
        super.update(withStyle: style)
        voteLabel?.textColor = style.symbolColor
    }
    
    private func updateVoteCount(_ count: Int) {
        voteLabel?.text = "\(count)"
    }
}
