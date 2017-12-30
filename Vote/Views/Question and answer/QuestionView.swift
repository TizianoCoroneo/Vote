//
//  QuestionView.swift
//  Vote
//
//  Created by Tiziano Coroneo on 05/12/2017.
//  Copyright © 2017 Tiziano Coroneo. All rights reserved.
//

import UIKit

@IBDesignable
class QuestionView: UIView {

    /// Big Q label.
    @IBOutlet weak var qLabel: UILabel!
    
    /// Main question text label.
    @IBOutlet weak var questionLabel: UILabel!
    
    /// The view instantiated from the NIB.
    private weak var view: UIView! = nil
    
    var xibFileName: String {
        return "QuestionView"
    }
    
    var text: String = "lol" {
        didSet { questionLabel?.text = text }
    }
    
    var preferredStyle: Style {
        return AppDelegate.style.questionView
    }
    
    func update(withStyle style: Style) {
        layer.cornerRadius = style.cornerRadius
        layer.borderColor = style.borderColor.cgColor
        layer.borderWidth = style.borderWidth
        
        guard view != nil else { return }
        
        view.layer.cornerRadius = style.cornerRadius
        view.layer.borderColor = style.borderColor.cgColor
        view.layer.borderWidth = style.borderWidth
        
        qLabel.textColor = style.symbolColor
        questionLabel.textColor = style.textColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadView()
    }
    
    func loadView() {
        loadView(
            withName: xibFileName,
            forSelf: self)
        update(withStyle: preferredStyle)
    }
    
    func loadView(
        withName name: String,
        forSelf s: QuestionView) {
        let bundle = Bundle.init(
            for: type(of: s))
        let nib = UINib(
            nibName: name,
            bundle: bundle)
        guard
            let newView = nib.instantiate(
                withOwner: s,
                options: nil).first as? UIView
            else { return }
        view = newView
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        s.addSubview(view)
        view.frame = s.bounds
    }
}

extension QuestionView {
    struct Style {
        let cornerRadius: CGFloat
        let backgroundColor: UIColor
        let borderWidth: CGFloat
        let borderColor: UIColor
        let textColor: UIColor
        let symbolColor: UIColor
        let countColor: UIColor
    }
}
