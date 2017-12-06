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
    
    var voteCount: Int = 0 {
        didSet { voteLabel.text = "\(voteCount)" }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        guard let style = style else { return }
        voteLabel.textColor = style.symbolColor
    }
}
