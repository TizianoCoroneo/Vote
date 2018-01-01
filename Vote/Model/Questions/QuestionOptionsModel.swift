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

class QuestionOptionsModel: Object {
    
    let activeOptions = List<Bool>()
    
    @objc dynamic var timeLimit: Double = 0
    
    var options: [QuestionOption] {
        return QuestionOption.options(fromModel: self)
    }
}

extension QuestionOption {
    static func options(fromModel model: QuestionOptionsModel) -> [QuestionOption] {
        return zip(all, model.activeOptions)
            .flatMap { option, value in
            return option.new(
                withValue: value,
                orTimeLimit: model.timeLimit)
        }
    }
    
    static func model(fromOptions options: [QuestionOption]) -> QuestionOptionsModel {
        
        let model = QuestionOptionsModel()
        
        model.activeOptions.append(objectsIn: options.map { $0.active }) 
        model.timeLimit = options.first(where: {
            $0.id == QuestionOption.timeLimit(nil).id
        })?.timeLimit ?? 0
        
        return model
    }
}
