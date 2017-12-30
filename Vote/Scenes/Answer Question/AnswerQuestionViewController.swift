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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        answerView.optionsAreUserInteractionEnabled = false
        
        answerView.optionState = [
            .closedAnswers(true),
            .timeLimit(nil),
            .partialResults(false),
            .privateVote(false),
            .lockedAnswers(false),
            .multipleAnswers(true),
            .secretAnswers(true),
        ]
    }
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

