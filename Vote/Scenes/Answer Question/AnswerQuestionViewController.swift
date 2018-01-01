//
//  AnswerQuestionViewController.swift
//  Vote
//
//  Created by Tiziano Coroneo on 06/12/2017.
//  Copyright © 2017 Tiziano Coroneo. All rights reserved.
//

import UIKit

class AnswerQuestionViewController: UIViewController {
    
    /// Corresponding `AnswerQuestionView`.
    @IBOutlet private weak var answerView: AnswerQuestionView!
    
    /// Does the current user own this question?
    var ownQuestion: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Set up view's data
        answerView.delegate = self
        answerView.optionsAreUserInteractionEnabled = false
        
        answerView.questionText = "What's the best episode of Black Mirror?"
        
        answerView.answers = [
            ("Nosedive", 20),
            ("Black Museum", 30),
            ("Hang the DJ", 27),
        ]
        
        answerView.selectedAnswersIndex = [0, 1]
        
        answerView.optionState = [
            .closedAnswers(true),
            .timeLimit(nil),
            .partialResults(false),
            .privateQuestion(false),
            .lockedAnswers(false),
            .multipleAnswers(true),
            .secretAnswers(true),
        ]
        
        if ownQuestion { configureEditButton() }
    }
    
    /// Configure the navigation item with an edit button if the user owns the question.
    func configureEditButton() {
        guard ownQuestion else { return }
        
        navigationItem.rightBarButtonItem = nil
        navigationItem.rightBarButtonItems = nil
        
        let editButton = UIBarButtonItem.init(
            barButtonSystemItem: .edit,
            target: self,
            action: #selector(editPressed))
        
        navigationItem.rightBarButtonItem = editButton
    }
    
    /// Gets called whenever the edit button is pressed
    @objc func editPressed() {
        
    }
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension AnswerQuestionViewController: AnswerQuestionViewDelegate {
    
    /// It is invoked when an answer view is pressed.
    ///
    /// - Parameters:
    ///   - index: Index of the pressed answer view in the answers array.
    ///   - text: Text of the pressed answer.
    func answerSelected(
        withIndex index: Int,
        text: String) {
        
        print("answer selected index: \(index), text: \(text)")
    }
}

