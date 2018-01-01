//
//  QuestionModel.swift
//  Vote
//
//  Created by Tiziano Coroneo on 05/12/2017.
//  Copyright © 2017 Tiziano Coroneo. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class QuestionModel: Object {
    @objc dynamic var question: String = ""
    @objc dynamic var timeStamp: Date = Date()
    @objc dynamic var totalNumberOfVotes: Int = 0
    
    let firstTenVotedOptions = List<VotedAnswer>()
}

class VotedAnswer: Object {
    @objc dynamic var answer: String = ""
    @objc dynamic var votes: Int = 0
}
