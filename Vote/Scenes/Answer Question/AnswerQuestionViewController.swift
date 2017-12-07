//
//  AnswerQuestionViewController.swift
//  Vote
//
//  Created by Tiziano Coroneo on 06/12/2017.
//  Copyright © 2017 Tiziano Coroneo. All rights reserved.
//

import UIKit

class AnswerQuestionViewController: UIViewController {
    
    @IBOutlet weak var optionsView: QuestionOptionsView!
    
    @IBOutlet weak var questionView: QuestionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        questionView.style = AppDelegate.style.questionView
        
        optionsView.optionsViews.forEach {
            $0.isUserInteractionEnabled = false
        }
        
        optionsView.optionState = [
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

