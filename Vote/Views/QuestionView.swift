//
//  QuestionView.swift
//  Vote
//
//  Created by Tiziano Coroneo on 05/12/2017.
//  Copyright © 2017 Tiziano Coroneo. All rights reserved.
//

import UIKit

class QuestionView: UIView {

    @IBOutlet weak var qLabel: UILabel!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    var text: String = "" {
        didSet { questionLabel.text = text }
    }
    
    var style: Style = AppDelegate.style.questionView {
        didSet { update(withStyle: style) }
    }
    
    func update(withStyle style: Style) {
        self.layer.cornerRadius = style.cornerRadius
        self.layer.borderColor = style.borderColor.cgColor
        self.layer.borderWidth = style.borderWidth
        self.qLabel.textColor = style.symbolColor
        self.questionLabel.textColor = style.textColor
    }
}

extension QuestionView {
    struct Style {
        let cornerRadius: CGFloat
        let backgroundColor: UIColor
        let borderWidth: CGFloat
        let borderColor: UIColor
        let textColor: UIColor
        let symbolColor: UIColor
    }
}
