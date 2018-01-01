//
//  QuestionOption.swift
//  Vote
//
//  Created by Tiziano Coroneo on 07/12/2017.
//  Copyright © 2017 Tiziano Coroneo. All rights reserved.
//

import UIKit

enum QuestionOption: Hashable {
    
    case closedAnswers(Bool)
    case partialResults(Bool)
    case timeLimit(TimeInterval?)
    case privateQuestion(Bool)
    case lockedAnswers(Bool)
    case multipleAnswers(Bool)
    case secretAnswers(Bool)
    
    static var all: [QuestionOption] {
        return [
            .closedAnswers(true),
            .timeLimit(nil),
            .partialResults(true),
            .privateQuestion(true),
            .lockedAnswers(true),
            .multipleAnswers(true),
            .secretAnswers(true)
        ]
    }
    
    var active: Bool {
        switch self {
        case .closedAnswers(let value):
            return value
        case .partialResults(let value):
            return value
        case .timeLimit(let value):
            return value == nil
        case .privateQuestion(let value):
            return value
        case .lockedAnswers(let value):
            return value
        case .multipleAnswers(let value):
            return value
        case .secretAnswers(let value):
            return value
        }
    }
    
    func image(fromBundle bundle: Bundle) -> UIImage {
        
        func getName() -> String {
            switch self {
            case .closedAnswers(let value):
                return value ? "Icons/Closed answers" : "Icons/Open answers"
            case .partialResults(let value):
                return value ? "Icons/Partial results" : "Icons/No partial results"
            case .timeLimit(let value):
                return value == nil ? "Icons/No time limit" : "Icons/Time Limit"
            case .privateQuestion(let value):
                return value ? "Icons/Private question" : "Icons/Public question"
            case .lockedAnswers(let value):
                return value ? "Icons/Locked answers" : "Icons/Unlocked answers"
            case .multipleAnswers(let value):
                return value ? "Icons/Multiple answers" : "Icons/Single answer"
            case .secretAnswers(let value):
                return value ? "Icons/Secret answer" : "Icons/Public answer"
            }
        }
        let name = getName()
        
        return UIImage(
            named: name,
            in: bundle,
            compatibleWith: nil)!
    }
    
    var id: Int {
        switch self {
        case .closedAnswers(_):
            return 0
        case .timeLimit(_):
            return 1
        case .partialResults(_):
            return 2
        case .privateQuestion(_):
            return 3
        case .lockedAnswers(_):
            return 4
        case .multipleAnswers(_):
            return 5
        case .secretAnswers(_):
            return 6
        }
    }
    
    var timeLimit: TimeInterval? {
        switch self {
        case .timeLimit(let value):
            return value
        default: return nil
        }
    }
    
    var hashValue: Int {
        return id.hashValue
    }
    
    func new(withValue value: Bool, orTimeLimit time: TimeInterval) -> QuestionOption? {
        switch self {
        case .closedAnswers(_):
            return .closedAnswers(value)
        case .partialResults(_):
            return .partialResults(value)
        case .timeLimit(_):
            return .timeLimit(time)
        case .privateQuestion(_):
            return .privateQuestion(value)
        case .lockedAnswers(_):
            return .lockedAnswers(value)
        case .multipleAnswers(_):
            return .multipleAnswers(value)
        case .secretAnswers(_):
            return .secretAnswers(value)
        }
    }
    
    init?(fromName name: String) {
        switch name.uppercased() {
        case "Closed answers".uppercased(): self = .closedAnswers(true)
        case "Open answers".uppercased(): self = .closedAnswers(false)
        case "Partial results".uppercased(): self = .partialResults(true)
        case "No partial results".uppercased(): self = .partialResults(false)
        case "No time limit".uppercased(): self = .timeLimit(nil)
        case "Time limit".uppercased(): self = .timeLimit(1000)
        case "Private question".uppercased(): self = .privateQuestion(true)
        case "Public question".uppercased(): self = .privateQuestion(false)
        case "Locked answers".uppercased(): self = .lockedAnswers(true)
        case "Unlocked answers".uppercased(): self = .lockedAnswers(false)
        case "Multiple answers".uppercased(): self = .multipleAnswers(true)
        case "Single answer".uppercased(): self = .multipleAnswers(false)
        case "Secret answers".uppercased(): self = .secretAnswers(true)
        case "Public answers".uppercased(): self = .secretAnswers(false)
        default: return nil
        }
    }
    
    var name: String {
        switch self {
        case .closedAnswers(let value):
            return value ? "Closed answers" : "Open answers"
        case .partialResults(let value):
            return value ? "Partial results" : "No partial results"
        case .timeLimit(let value):
            return value == nil ? "No time limit" : "Time limit"
        case .privateQuestion(let value):
            return value ? "Private question" : "Public question"
        case .lockedAnswers(let value):
            return value ? "Locked answers" : "Unlocked answers"
        case .multipleAnswers(let value):
            return value ? "Multiple answers" : "Single answer"
        case .secretAnswers(let value):
            return value ? "Secret answers" : "Public answers"
        }
    }
    
    static func ==(lhs: QuestionOption, rhs: QuestionOption) -> Bool {
        return lhs.id == rhs.id && lhs.active == rhs.active
    }
}
