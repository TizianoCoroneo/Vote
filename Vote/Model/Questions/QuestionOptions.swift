//
//  QuestionOptions.swift
//  Vote
//
//  Created by Tiziano Coroneo on 05/12/2017.
//  Copyright © 2017 Tiziano Coroneo. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class QuestionOptionModel: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var active: Bool = true
    
    var option: QuestionOptions? {
        return QuestionOptions(fromString: name, active: active)
    }
}

enum QuestionOptions {
    case secretVote(Bool)
    case secretAnswers(Bool)
    case globalVote(Bool)
    case lockedVote(Bool)
    case openAnswer(Bool)
    case multiAnswer(Bool)
    case timeLimit(Bool, TimeInterval)
    
    var string: String {
        switch self {
        case .secretVote(_):
            return "Secret vote"
        case .secretAnswers(_):
            return "Secret answers"
        case .globalVote(_):
            return "Global vote"
        case .lockedVote(_):
            return "Locked state"
        case .openAnswer(_):
            return "Open answer"
        case .multiAnswer(_):
            return "Multiple answers"
        case .timeLimit(_, _):
            return "Time limit"
        }
    }
    
    init?(
        fromString string: String,
        active: Bool,
        timeLimit: TimeInterval? = nil) {
        
        switch string {
        case QuestionOptions.secretVote(true).string:
            self = .secretVote(active)
        case QuestionOptions.secretAnswers(true).string:
            self = .secretAnswers(active)
        case QuestionOptions.globalVote(true).string:
            self = .globalVote(active)
        case QuestionOptions.lockedVote(true).string:
            self = .lockedVote(active)
        case QuestionOptions.openAnswer(true).string:
            self = .openAnswer(active)
        case QuestionOptions.multiAnswer(true).string:
            self = .multiAnswer(active)
        case QuestionOptions.timeLimit(true, 0).string:
            self = .timeLimit(active, timeLimit ?? 0)
        default: return nil
        }
    }
}
