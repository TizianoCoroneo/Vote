//
//  QuestionOptionToggle.swift
//  Vote
//
//  Created by Tiziano Coroneo on 07/12/2017.
//  Copyright © 2017 Tiziano Coroneo. All rights reserved.
//

import UIKit

/// Toggle button that represents a single Question Option.
@IBDesignable
class QuestionOptionToggle: UIButton {
    typealias ToggleAction = ((QuestionOption) -> (QuestionOption))
    
    var toggleInputClosure: ToggleAction = QuestionOptionToggle.toggleOnOff
    
    var toggleOption: QuestionOption = .closedAnswers(true) {
        didSet { updateImage(forOption: toggleOption) }
    }
    
    private func updateImage(forOption option: QuestionOption) {
        let bundle = Bundle.init(for: type(of: self))
        setImage(
            option.image(fromBundle: bundle)
                .withRenderingMode(.alwaysOriginal),
            for: .normal)
        self.accessibilityLabel = option.name
    }
    
    private func setup() {
        updateImage(forOption: toggleOption)
        if self.allTargets.count == 0 {
            addTarget(
                self,
                action: #selector(optionPressed),
                for: .touchUpInside)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    @objc func optionPressed() {
        toggleOption = toggleInputClosure(toggleOption)
    }
}

extension QuestionOptionToggle {
    static var toggleOnOff: ToggleAction {
        return { old in
            return old.new(
                withValue: !old.active,
                orTimeLimit: 0) ?? old
        }
    }
}
