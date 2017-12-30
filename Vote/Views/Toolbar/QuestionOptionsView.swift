//
//  QuestionOptionsView.swift
//  Vote
//
//  Created by Tiziano Coroneo on 06/12/2017.
//  Copyright © 2017 Tiziano Coroneo. All rights reserved.
//

import UIKit

class QuestionOptionsView: UIStackView {
    
    @IBOutlet var optionsViews: [QuestionOptionToggle]!

    var optionState: [QuestionOption] {
        set { zip(optionsViews, newValue)
            .forEach { $0.0.toggleOption = $0.1 } }
        get { return optionsViews.map { $0.toggleOption } }
    }
    
    var optionActions: [QuestionOptionToggle.ToggleAction] {
        set {
            zip(optionsViews, newValue).forEach {
                $0.0.toggleInputClosure = $0.1
            }
        } get {
            return optionsViews.map { $0.toggleInputClosure }
        }
    }
    
    var timeLimit: TimeInterval? {
        guard let timeOption = optionsViews.first(where: {
            return $0.toggleOption == .timeLimit(nil) ||
                $0.toggleOption == .timeLimit(.some(1))
        })?.toggleOption else { return nil }
        
        switch timeOption {
        case .timeLimit(let value): return value
        default: return nil
        }
    }
}
