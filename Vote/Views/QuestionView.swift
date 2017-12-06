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
    
    var style: Style? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        guard let style = style else { return }
        
        self.layer.cornerRadius = style.cornerRadius
        self.layer.borderColor = style.borderColor.cgColor
        self.layer.borderWidth = style.borderWidth
        self.qLabel.textColor = style.symbolColor
        self.questionLabel.textColor = style.textColor
    }
}
