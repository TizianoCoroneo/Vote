//
//  TextTableViewCell.swift
//  Vote
//
//  Created by Tiziano Coroneo on 03/12/2017.
//  Copyright © 2017 Tiziano Coroneo. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class QuestionTableViewCell: UITableViewCell {
    
    static let identifier: String = "QuestionTableViewCell"
    
    @IBOutlet private weak var hourLabel: UILabel!
    @IBOutlet private weak var votesLabel: UILabel!
    
    @IBOutlet private weak var qLabel: UILabel!
    @IBOutlet private weak var questionLabel: UILabel!
    @IBOutlet private weak var questionBackground: UIView!
    
    @IBOutlet private weak var aLabel: UILabel!
    @IBOutlet private weak var answerLabel: UILabel!
    @IBOutlet private weak var answerVotesLabel: UILabel!
    @IBOutlet private weak var answerBackground: UIView!
    
    var viewModel: ViewModel? = nil {
        didSet {
            guard let vm = viewModel else { return }
            update(viewModel: vm)
        }
    }
    
    struct ViewModel: IdentifiableType, Equatable {
        typealias Identity = Int
        
        let shouldDisplayAnswer: Bool
        
        let hour: String
        let answerVoteCount: Int
        let totalVoteCount: Int
        
        let question: String
        let answer: String
        
        var identity: Int { return question.hashValue }
        
        var rowHeight: CGFloat {
            return shouldDisplayAnswer ? 250 : 180
        }
        
        static func ==(_ lhs: ViewModel, _ rhs: ViewModel) -> Bool {
            return lhs.identity == rhs.identity
        }
    }
    
    func configure(
        withViewModel viewModel: ViewModel,
        withStyle style: QuestionTableViewCell.Style) {
        
        self.viewModel = viewModel
        setupAppearance(from: style)
    }
    
    private func update(viewModel: ViewModel) {
        questionLabel.text = viewModel.question
        answerLabel.text = viewModel.answer
        hourLabel.text = viewModel.hour
        votesLabel.text = "\(viewModel.totalVoteCount) votes"
        answerVotesLabel.text = "\(viewModel.answerVoteCount)"
        
        answerBackground.isHidden = viewModel.shouldDisplayAnswer
    }
    
    private func setupAppearance(from style: QuestionTableViewCell.Style) {
        questionBackground.backgroundColor = style.questionBackgroundColor
        questionBackground.layer.cornerRadius = style.cornerRadius
        questionBackground.layer.borderColor = style.questionBorderColor.cgColor
        questionBackground.layer.borderWidth = style.questionBorderWidth
        
        qLabel.textColor = style.questionSymbolColor
        questionLabel.textColor = style.questionTextColor
        
        answerBackground.backgroundColor = style.answerBackgroundColor
        answerBackground.layer.cornerRadius = style.cornerRadius
        answerBackground.layer.borderWidth = style.answerBorderWidth
        answerBackground.layer.borderColor = style.answerBorderColor.cgColor
        
        aLabel.textColor = style.answerSymbolColor
        answerLabel.textColor = style.answerTextColor
    }
}

