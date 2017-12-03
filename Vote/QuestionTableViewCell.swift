//
//  QuestionTableViewCell.swift
//  Vote
//
//  Created by Tiziano Coroneo on 03/12/2017.
//  Copyright © 2017 Tiziano Coroneo. All rights reserved.
//

import UIKit

@IBDesignable
class QuestionTableViewCell: UITableViewCell {
    
    static let identifier: String = "QuestionTableViewCell"
    
    @IBOutlet private weak var questionLabel: UILabel!
    @IBOutlet private weak var background: UIView!
    
    private var question: String = "" { didSet { questionLabel.text = question } }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(withQuestion question: String) {
        self.question = question
        
        background.layer.cornerRadius = Style.cornerRadius
        background.layer.backgroundColor = UIColor.voteLightGrey.cgColor
        background.layer.borderWidth = 0
        background.layer.borderColor = nil
    }
    
    func setupAppearance() {
        
    }
}
