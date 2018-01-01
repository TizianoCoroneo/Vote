//
//  QuestionOptionRowView.swift
//  Vote
//
//  Created by Tiziano Coroneo on 01/01/2018.
//  Copyright © 2018 Tiziano Coroneo. All rights reserved.
//

import UIKit

class QuestionOptionRowView: UIView {
    
    @IBOutlet private weak var optionImageView: UIImageView!
    
    @IBOutlet private weak var optionNameLabel: UILabel!
    
    @IBInspectable
    var optionName: String = ""
    
    var option: QuestionOption? {
        return QuestionOption(fromName: optionName)
    }
    
    /// The view instantiated from the NIB.
    weak var view: UIView! = nil
    
    var xibFileName: String {
        return "QuestionOptionRowView"
    }
    
    convenience init() {
        self.init(frame: CGRect())
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadView()
    }
    
    private func loadView() {
        loadView(
            withName: xibFileName,
            forSelf: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        optionImageView?.image = option?.image(fromBundle: Bundle(for: type(of: self)))
        optionNameLabel?.text = option?.name ?? ""
    }
    
    private func loadView(
        withName name: String,
        forSelf s: QuestionOptionRowView) {
        let bundle = Bundle.init(
            for: type(of: s))
        let nib = UINib(
            nibName: name,
            bundle: bundle)
        guard
            view == nil, 
            let newView = nib.instantiate(
                withOwner: s,
                options: nil).first as? UIView
            else { return }
        view = newView
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        s.addSubview(view)
        
        view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        view.accessibilityIdentifier = "\(self.option?.name ?? "")"
        
        view.frame = s.bounds
        self.isUserInteractionEnabled = false
    }
}
