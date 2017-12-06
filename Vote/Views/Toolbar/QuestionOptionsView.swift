//
//  QuestionOptionsView.swift
//  Vote
//
//  Created by Tiziano Coroneo on 06/12/2017.
//  Copyright © 2017 Tiziano Coroneo. All rights reserved.
//

import UIKit

enum QuestionOption: Hashable {
    
    case closedAnswers(Bool)
    case partialResults(Bool)
    case timeLimit(TimeInterval?)
    case privateVote(Bool)
    case lockedAnswers(Bool)
    case multipleAnswers(Bool)
    case secretAnswers(Bool)
    
    static var actionDictionary: [QuestionOption : (QuestionOption) -> ()] = [:]
    
    var action: ((QuestionOption) -> ())? {
        return QuestionOption.actionDictionary[self]
    }
    
    var active: Bool {
        switch self {
        case .closedAnswers(let value):
            return value
        case .partialResults(let value):
            return value
        case .timeLimit(let value):
            return value == nil
        case .privateVote(let value):
            return value
        case .lockedAnswers(let value):
            return value
        case .multipleAnswers(let value):
            return value
        case .secretAnswers(let value):
            return value
        }
    }
    
    var image: UIImage {
        switch self {
        case .closedAnswers(let value):
            return value ? #imageLiteral(resourceName: "Icons/Closed answers") : #imageLiteral(resourceName: "Icons/Open answers")
        case .partialResults(let value):
            return value ? #imageLiteral(resourceName: "Icons/Partial results") : #imageLiteral(resourceName: "Icons/No partial results")
        case .timeLimit(let value):
            return value == nil ? #imageLiteral(resourceName: "Icons/No time limit") : #imageLiteral(resourceName: "Icons/Time Limit")
        case .privateVote(let value):
            return value ? #imageLiteral(resourceName: "Icons/Private votation") : #imageLiteral(resourceName: "Icons/Public votation")
        case .lockedAnswers(let value):
            return value ? #imageLiteral(resourceName: "Icons/Locked answers") : #imageLiteral(resourceName: "Icons/Unlocked answers")
        case .multipleAnswers(let value):
            return value ? #imageLiteral(resourceName: "Icons/Multiple answers") : #imageLiteral(resourceName: "Icons/Single answer")
        case .secretAnswers(let value):
            return value ? #imageLiteral(resourceName: "Icons/Secret answer") : #imageLiteral(resourceName: "Icons/Public answer")
        }
    }
    
    private var id: Int {
        switch self {
        case .closedAnswers(false):
            return 0
        case .closedAnswers(true):
            return 1
        case .timeLimit(nil):
            return 2
        case .timeLimit(let value):
            return value != nil ? 3 : 2
        case .partialResults(false):
            return 4
        case .partialResults(true):
            return 5
        case .privateVote(false):
            return 6
        case .privateVote(true):
            return 7
        case .lockedAnswers(false):
            return 8
        case .lockedAnswers(true):
            return 9
        case .multipleAnswers(false):
            return 10
        case .multipleAnswers(true):
            return 11
        case .secretAnswers(false):
            return 12
        case .secretAnswers(true):
            return 13
        }
    }
    
    var hashValue: Int {
        return id.hashValue
    }
    
    static func ==(lhs: QuestionOption, rhs: QuestionOption) -> Bool {
        return lhs.id == rhs.id
    }
}

class QuestionOptionsView: UIStackView {
    
    @IBOutlet var optionsViews: [UIImageView]!
    
    private var optionState: [QuestionOption: Bool] = [
        QuestionOption.closedAnswers(true) : true,
        QuestionOption.timeLimit(nil) : true,
        QuestionOption.partialResults(true) : true,
        QuestionOption.privateVote(true) : true,
        QuestionOption.lockedAnswers(true) : true,
        QuestionOption.multipleAnswers(true) : true,
        QuestionOption.secretAnswers(true) : true
    ]
    
    private var timeLimitAmount: TimeInterval? = nil
    
    func update(options: [QuestionOption]) {
        
        optionState = Dictionary.init(uniqueKeysWithValues:
            zip(options,
                optionsViews)
                .map {
                    let (data, view) = $0
                    view.image = data.image
                    
                    switch data {
                    case .timeLimit(let time):
                        timeLimitAmount = time
                    default: break
                    }
                    
                    let gesture = UITapGestureRecognizer(
                        target: self,
                        action: selector(forOption: data))
                    
                    view.addGestureRecognizer(gesture)
                    
                    return (key: data, value: data.active)
        })
    }
    
    private func executeAction(forOption option: QuestionOption) {
        QuestionOption.actionDictionary[option]?(option)
    }
    
    private func selector(forOption option: QuestionOption) -> Selector {
        switch option {
        case .closedAnswers(_):
            return #selector(closedAnswers)
        case .timeLimit(_):
            return #selector(timeLimit)
        case .partialResults(_):
            return #selector(closedAnswers)
        case .privateVote(_):
            return #selector(timeLimit)
        case .lockedAnswers(_):
            return #selector(closedAnswers)
        case .multipleAnswers(_):
            return #selector(timeLimit)
        case .secretAnswers(_):
            return #selector(closedAnswers)
        }
    }
    
    @objc func closedAnswers() {
        executeAction(forOption: .closedAnswers(optionState[.closedAnswers(true)]!)) }
    @objc func timeLimit() {
        executeAction(forOption: .timeLimit(timeLimitAmount)) }
    @objc func partialResults(_ value: Bool) {
        executeAction(forOption: .partialResults(optionState[.partialResults(true)]!)) }
    @objc func privateVote(_ value: Bool) {
        executeAction(forOption: .privateVote(optionState[.privateVote(true)]!)) }
    @objc func lockedAnswers(_ value: Bool) {
        executeAction(forOption: .lockedAnswers(optionState[.lockedAnswers(true)]!)) }
    @objc func multipleAnswers(_ value: Bool) {
        executeAction(forOption: .multipleAnswers(optionState[.multipleAnswers(true)]!)) }
    @objc func secretAnswers(_ value: Bool) {
        executeAction(forOption: .secretAnswers(optionState[.secretAnswers(true)]!)) }
}
