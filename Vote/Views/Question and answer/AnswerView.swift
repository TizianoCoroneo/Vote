//
//  AnswerView.swift
//  Vote
//
//  Created by Tiziano Coroneo on 05/12/2017.
//  Copyright © 2017 Tiziano Coroneo. All rights reserved.
//

import UIKit

@IBDesignable
class AnswerView: QuestionView {

    @IBOutlet private weak var voteLabel: UILabel!
    
    /// Not weak on purpose
    @IBOutlet private var selectedMarkView: UIView!
    
    var voteCount: Int = 0 {
        didSet { voteLabel?.text = "\(voteCount)" }
    }
    
    override var xibFileName: String {
        return "AnswerView"
    }
    
    override var preferredStyle: Style {
        return AppDelegate.style.answerView
    }
    
    var markInitialPosition: CGFloat {
        return preferredSlideDirection == .left
            ? bounds.width
            : -slideDistance
    }
    
    var markTargetPosition: CGFloat {
        return preferredSlideDirection == .left
            ? bounds.width - slideDistance
            : 0
    }
    
    private func addMarkIfNeeded() {
        if self
            .subviews
            .filter ({ $0 == selectedMarkView })
            .count == 0 {
            selectedMarkView.translatesAutoresizingMaskIntoConstraints = true
            self.addSubview(self.selectedMarkView)
            initialAnimatedProperties()
        }
    }
    
    override var initialAnimatedProperties: (() -> ()) {
        defer { layoutIfNeeded() }
        return {
            [weak selectedMarkView,
            markInitialPosition,
            slideDistance,
            bounds] in
            
            super.initialAnimatedProperties()
            guard let markView = selectedMarkView else { return }
            
            markView.frame = CGRect.init(
                x: markInitialPosition,
                y: 0,
                width: slideDistance,
                height: bounds.height)
            
        }
    }
    
    override var targetAnimatedProperties: (() -> ()) {
        return {
            [weak selectedMarkView,
            markTargetPosition,
            slideDistance,
            bounds] in
            super.targetAnimatedProperties()
            
            guard let markView = selectedMarkView else { return }
            
            markView.frame = CGRect(
                x: markTargetPosition,
                y: 0,
                width: slideDistance,
                height: bounds.height)
        }
    }
    
    override func update(withStyle style: Style) {
        super.update(withStyle: style)
        voteLabel?.textColor = style.symbolColor
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addMarkIfNeeded()
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        addMarkIfNeeded()
    }
    
    func setSelected(_ selected: Bool) {
        let sel: ToggleState = selected ? .on : .off

        guard
            state != sel
            else { return }
        
        state = sel
        
        selected
            ? targetAnimatedProperties()
            : initialAnimatedProperties()
        layoutIfNeeded()
    }
}










