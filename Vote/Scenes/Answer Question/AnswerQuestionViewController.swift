//
//  AnswerQuestionViewController.swift
//  Vote
//
//  Created by Tiziano Coroneo on 06/12/2017.
//  Copyright © 2017 Tiziano Coroneo. All rights reserved.
//

import UIKit

class AnswerQuestionViewController: UIViewController {
    
    @IBOutlet private weak var answerView: AnswerQuestionView!
    
    var ownQuestion: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        answerView.delegate = self
        answerView.optionsAreUserInteractionEnabled = false
        
        answerView.questionText = "What's the best episode of Black Mirror?"
        
        answerView.answers = [
            ("Nosedive", 20),
            ("Black Museum", 30),
            ("Hang the DJ", 27),
        ]
        
        answerView.selectedAnswerIndex = 1
        
        answerView.optionState = [
            .closedAnswers(true),
            .timeLimit(nil),
            .partialResults(false),
            .privateVote(false),
            .lockedAnswers(false),
            .multipleAnswers(true),
            .secretAnswers(true),
        ]
        
        configureNavigationItem(navigationItem)
    }
    
    func configureNavigationItem(_ item: UINavigationItem) {
        guard ownQuestion else { return }
        
        navigationItem.rightBarButtonItem = nil
        navigationItem.rightBarButtonItems = nil
        
        let newButton = UIBarButtonItem.init(
            barButtonSystemItem: .edit,
            target: self,
            action: #selector(editPressed))
        
        navigationItem.rightBarButtonItem = newButton
    }
    
    @objc func editPressed() {
        
    }
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension AnswerQuestionViewController: AnswerQuestionViewDelegate {
    
    func answerSelected(
        withIndex index: Int,
        text: String) {
        
        print("answer selected index: \(index), text: \(text)")
        
    }
}

