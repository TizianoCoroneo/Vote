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
    
    /// Initial options state
    var optionState: [QuestionOption] = [] {
        didSet { optionsView.optionState = optionState }
    }
    
    var optionsAreUserInteractionEnabled = false {
        didSet {
            setOptionsInteraction(
                enabled: optionsAreUserInteractionEnabled)
        }
    }
    
    /// Question text
    var questionText: String = "" {
        didSet { questionView.text = questionText }
    }
    
    /// Preselected answers indeces
    var selectedAnswersIndex: [Int] = [] {
        didSet { setInitialAnswersSelection() }
    }
    
    /// Answers data source array.
    var answers: [(String, Int?)] = [] {
        didSet { updateAnswers() }
    }
    
    // MARK: - Private Properties
    
    /// All the current answers.
    private var answerViews: [AnswerView] {
        return answersContainer.subviews.flatMap {
            $0 as? AnswerView
        }
    }
    
    // MARK: - Utility functions
    
    /// Creates a new AnswerView with the specified data.
    ///
    /// - Parameters:
    ///   - text: answer text.
    ///   - voteCount: Vote count.
    /// - Returns: the new view.
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
    
    /// Removes all the AnswerViews.
    private func removeAnswers() {
        answersContainer.subviews
            .filter { $0 is AnswerView }
            .forEach { $0.removeFromSuperview() }
    }
    
    /// Update the values of all the answers and respawns the AnswerViews.
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
    
    /// Sets the initial preselection.
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
    
    /// Set the options interactable or not
    ///
    /// - Parameter enabled: Should the user be able to change the question options?
    private func setOptionsInteraction(enabled: Bool) {
        optionsView.optionsViews.forEach {
            $0.isUserInteractionEnabled = enabled
        }
    }
    
    /// Returns the index of an answer in the answer array.
    ///
    /// - Parameter answer: Answer to look for.
    /// - Returns: the index of the input answer.
    func index(ofAnswer answer: AnswerView) -> Int? {
        return answers.enumerated().first {
            $0.element.0 == answer.text
        }?.offset
    }
    
    /// Preselects a single answer, deselecting every other one.
    ///
    /// - Parameters:
    ///   - answer: The answer to select
    func selectSingle(answer: AnswerView) {
        answerViews.forEach { $0.setSelected(false) }
        answer.setSelected(true)
    }
}

protocol AnswerQuestionViewDelegate: class {
    /// Gets invoked when an AnswerView is selected.
    ///
    /// - Parameters:
    ///   - index: index of the selected view.
    ///   - text: Text of the selected answer.
    func answerSelected(
        withIndex index: Int,
        text: String)
}




