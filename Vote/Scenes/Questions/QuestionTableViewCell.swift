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
    @IBOutlet private weak var question: QuestionView!
    @IBOutlet private weak var answer: AnswerView!
   
    var viewModel: ViewModel? = nil {
        didSet {
            guard let viewModel = viewModel else { return }
            update(viewModel: viewModel)
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
        withViewModel viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    private func update(viewModel: ViewModel) {
        hourLabel.text = viewModel.hour
        votesLabel.text = "\(viewModel.totalVoteCount) votes"
        
        question.text = viewModel.question
        answer.text = viewModel.answer
        answer.voteCount = viewModel.answerVoteCount
        
        answer.isHidden = viewModel.shouldDisplayAnswer
    }
    
}

extension QuestionTableViewCell {
    struct Style {
        let questionStyle: QuestionView.Style
        let answerStyle: QuestionView.Style
    }
}

extension StyleGuide {
    var questionTableViewCell: QuestionTableViewCell.Style {
        return QuestionTableViewCell.Style.init(
            questionStyle: AppDelegate.style.questionView,
            answerStyle: AppDelegate.style.answerView)
    }
}
