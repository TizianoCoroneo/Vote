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

    // MARK: - Properties
    
    var optionState: [QuestionOption] = [] {
        didSet {
            optionsView.optionState = optionState
        }
    }
    
    var optionsAreUserInteractionEnabled = false {
        didSet {
            updateOptionsInteraction(
                enabled: optionsAreUserInteractionEnabled)
        }
    }
    
    var questionText: String {
        get { return questionView.text }
        set { questionView.text = questionText }
    }
    
    var answers: [(String, Int?)] {
        set {  }
        get { return [] }
    }
    
    // MARK: - Utility functions
    
    private func createAnswerView() -> AnswerView {
        let view = AnswerView(
            frame: CGRect())
        
        
        
        return view
    }
    
    private func updateOptionsInteraction( enabled: Bool) {
        optionsView.optionsViews.forEach {
            $0.isUserInteractionEnabled = enabled
        }
    }
}
