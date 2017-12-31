//
//  AnswerQuestionView.swift
//  Vote
//
//  Created by Tiziano Coroneo on 16/12/2017.
//  Copyright © 2017 Tiziano Coroneo. All rights reserved.
//

import UIKit

class AnswerQuestionView: UIView {

    // MARK: - Outlets
    
    @IBOutlet private weak var optionsView: QuestionOptionsView!
    
    @IBOutlet private weak var questionView: QuestionView!

    @IBOutlet private weak var answersContainer: UIStackView!
    
    // MARK: - Public fields
    
    weak var delegate: AnswerQuestionViewDelegate?
    
    // MARK: - Properties
    
    var optionState: [QuestionOption] = [] {
        didSet { optionsView.optionState = optionState }
    }
    
    var optionsAreUserInteractionEnabled = false {
        didSet {
            updateOptionsInteraction(
                enabled: optionsAreUserInteractionEnabled)
        }
    }
    
    var questionText: String = "" {
        didSet { questionView.text = questionText }
    }
    
    var selectedAnswersIndex: [Int] = [] {
        didSet { setInitialAnswersSelection() }
    }
    
    var answers: [(String, Int?)] = [] {
        didSet { updateAnswers() }
    }
    
    // MARK: - Private Properties
    
    private var answerViews: [AnswerView] {
        return answersContainer.subviews.flatMap {
            $0 as? AnswerView
        }
    }
    
    // MARK: - Utility functions
    
    private func createAnswerView(
        text: String,
        voteCount: Int) -> AnswerView {
        
        let view = AnswerView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.text = text
        view.voteCount = voteCount
        view.isUserInteractionEnabled = true
        view.initialAnimatedProperties()
        
        return view
    }
    
    private func removeAnswers() {
        answersContainer.subviews
            .filter { $0 is AnswerView }
            .forEach { $0.removeFromSuperview() }
    }
    
    private func updateAnswers() {
        removeAnswers()
        answers.forEach {
            [weak answersContainer] answer in
            let newView = createAnswerView(
                text: answer.0,
                voteCount: answer.1 ?? 0)
            
            answersContainer?.addArrangedSubview(newView)
        }
    }
    
    private func setInitialAnswersSelection() {
        selectedAnswersIndex.forEach {
            index in
            
            guard
                index < answerViews.count
                else { return }
            
            answerViews[index]
                .setSelected(true)
        }
    }
    
    private func updateOptionsInteraction(enabled: Bool) {
        optionsView.optionsViews.forEach {
            $0.isUserInteractionEnabled = enabled
        }
    }
    
    func index(ofAnswer answer: AnswerView) -> Int? {
        return answers.enumerated().first {
            $0.element.0 == answer.text
        }?.offset
    }
    
    private func select(answer: AnswerView, index: Int) {
        answerViews.forEach { $0.setSelected(false) }
        answer.setSelected(true)
    }
}

protocol AnswerQuestionViewDelegate: class {
    func answerSelected(
        withIndex index: Int,
        text: String)
}




