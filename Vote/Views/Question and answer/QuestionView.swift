//
//  QuestionView.swift
//  Vote
//
//  Created by Tiziano Coroneo on 05/12/2017.
//  Copyright © 2017 Tiziano Coroneo. All rights reserved.
//

import UIKit

@IBDesignable
class QuestionView: UIView, ToggleStateAnimatable {

    /// Big Q label.
    @IBOutlet weak var qLabel: UILabel?
    
    /// Main question text label.
    @IBOutlet weak var questionLabel: UILabel?
    
    /// The view instantiated from the NIB.
    weak var view: UIView? = nil
    
    var xibFileName: String {
        return "QuestionView"
    }
    
    var text: String = "lol" {
        didSet { questionLabel?.text = text }
    }
    
    var preferredStyle: Style {
        return AppDelegate.style.questionView
    }
    
    var slideDistance: CGFloat {
        return qLabel?.frame.width ?? 60
    }
    
    enum Direction {
        case left
        case right
    }
    
    var preferredSlideDirection: Direction {
        
        let locale = Locale.current
        let language = locale.languageCode!
        let languageDirection = Locale
            .characterDirection(
                forLanguage: language)
        
        return languageDirection == .leftToRight ?
            .left : .right
    }
    
    //----------------
    //----------------
    //----------------
    
    func update(withStyle style: Style) {
        layer.cornerRadius = style.cornerRadius
        layer.borderColor = style.borderColor.cgColor
        layer.borderWidth = style.borderWidth
        
        guard view != nil else { return }
        
        view?.layer.cornerRadius = style.cornerRadius
        view?.layer.borderColor = style.borderColor.cgColor
        view?.layer.borderWidth = style.borderWidth
        
        qLabel?.textColor = style.symbolColor
        questionLabel?.textColor = style.textColor
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
    }
    
    private func loadView() {
        loadView(
            withName: xibFileName,
            forSelf: self)
        update(withStyle: preferredStyle)
        setupGestures()
    }

    private func loadView(
        withName name: String,
        forSelf s: QuestionView) {
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
        
        guard let view = view else { return }
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        s.addSubview(view)
        
        view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        view.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        view.accessibilityIdentifier = "\(self.text)"
        
        view.frame = s.bounds
        self.isUserInteractionEnabled = false
    }
    
    // ______________________
    // Interactive & Interruptible animation
    // ______________________
    
    var state: ToggleState = .off
    
    var runningAnimators =  [UIViewPropertyAnimator]()
    
    // Tracks progress when interrupted for all Animators
    var progressWhenInterrupted = [UIViewPropertyAnimator : CGFloat]()
    
    var duration: TimeInterval {
        return 0.2
    }
    
    var processAnimationProgress: (CGFloat) -> (CGFloat) {
        return { [weak self] x in
            return (x) / (self?.slideDistance ?? 100)
        }
    }
    
    var initialAnimatedProperties: (() -> ()) {
        return {
            [weak view, viewFrameInitialPosition] in
            
            view?.frame.origin.x = viewFrameInitialPosition
        }
    }
    
    var targetAnimatedProperties: (() -> ()) {
        return {
            [weak view, viewFrameTargetPosition] in
            view?.frame.origin.x = viewFrameTargetPosition
        }
    }
    
    func setSelected(_ selected: Bool) {
        let sel: ToggleState = selected ? .on : .off
        
        guard
            state != sel
            else { return }
        
        state = sel
        
        state == .on
            ? targetAnimatedProperties()
            : initialAnimatedProperties()
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    private let viewFrameInitialPosition: CGFloat = 0
    private var viewFrameTargetPosition: CGFloat {
        return preferredSlideDirection == .left
            ? -slideDistance
            : slideDistance
    }
    
    private func setupGestures() {
        let tapRecognizer = UITapGestureRecognizer.init(
            target: self,
            action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tapRecognizer)
        
        let panGestureRecognizer = UIPanGestureRecognizer.init(
            target: self,
            action: #selector(handlePan(_:)))
        self.addGestureRecognizer(panGestureRecognizer)
    }
    
    @IBAction func handleTap(_ recognizer: UITapGestureRecognizer?) {
        animateOrReverseRunningTransition(
            destinationState: !state,
            duration: duration)
    }
    
    @IBAction func handlePan(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startInteractiveTransition(
                destinationState: !state,
                duration: duration)
        case .changed:
            let translation = recognizer.translation(in: self)
            updateInteractiveTransition(
                distanceTraveled: translation.x)
        case .cancelled, .failed:
            continueInteractiveTransition(cancel: true)
        case .ended:
            let isCancelled = isGestureCancelled(recognizer)
            continueInteractiveTransition(cancel: isCancelled)
        default:
            break
        }
    }
    
    private func isGestureCancelled(_ recognizer: UIPanGestureRecognizer) -> Bool {
        let isCancelled: Bool
        
        let velocityX = recognizer.velocity(in: self).x
        
        if velocityX != 0 {
            let isPanningOn = preferredSlideDirection == .left ? velocityX < 0 : velocityX > 0
            isCancelled = (state == .on && !isPanningOn) ||
                (state == .off && isPanningOn)
        } else {
            isCancelled = false
        }
        
        return isCancelled
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
