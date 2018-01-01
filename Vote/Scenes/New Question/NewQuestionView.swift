//
//  NewQuestionView.swift
//  Vote
//
//  Created by Tiziano Coroneo on 01/01/2018.
//  Copyright © 2018 Tiziano Coroneo. All rights reserved.
//

import UIKit

class NewQuestionView: UIView, ToggleStateAnimatable {

    @IBOutlet private weak var questionView: QuestionView!
    @IBOutlet private weak var addAnswerView: UIView!
    @IBOutlet private weak var answersContainer: UIStackView!
    
    @IBOutlet private weak var optionsHeaderView: UIView!
    
    @IBOutlet private weak var optionsContainer: UIStackView!
    @IBOutlet private weak var optionsStackPositionConstraint: NSLayoutConstraint!
    
    var duration: TimeInterval {
        return 0.4
    }
    
    var totalDistance: CGFloat {
        return targetPosition - initialPosition
    }
    
    var state: ToggleState = .off
    
    var runningAnimators: [UIViewPropertyAnimator] = []
    
    var progressWhenInterrupted: [UIViewPropertyAnimator : CGFloat] = [:]
    
    private var initialPosition: CGFloat {
        return (optionsHeaderView?.frame.height ?? 60) + 10
    }
    
    private var targetPosition: CGFloat {
        return (optionsContainer?.frame.height ?? 60) + 10
    }
    
    var initialAnimatedProperties: (() -> ()) {
        return {
            [weak self,
            initialPosition] in
            self?.optionsStackPositionConstraint?.constant = initialPosition
            self?.layoutIfNeeded()
        }
    }
    
    var targetAnimatedProperties: (() -> ()) {
        return {
            [weak self,
            targetPosition] in
            self?.optionsStackPositionConstraint?.constant = targetPosition
            self?.layoutIfNeeded()
        }
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        state == .on
//            ? targetAnimatedProperties()
//            : initialAnimatedProperties()
//    }
    
    var processAnimationProgress: (CGFloat) -> (CGFloat) {
        return { [totalDistance] x in
            return x / (totalDistance)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupGestures()
    }
    
    private func setupGestures() {
        let tapRecognizer = UITapGestureRecognizer.init(
            target: self,
            action: #selector(handleTap(_:)))
        optionsHeaderView?.addGestureRecognizer(tapRecognizer)
        
        let panGestureRecognizer = UIPanGestureRecognizer.init(
            target: self,
            action: #selector(handlePan(_:)))
        optionsHeaderView?.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        animateOrReverseRunningTransition(
            destinationState: !state,
            duration: duration)
    }
    
    @objc func handlePan(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startInteractiveTransition(
                destinationState: !state,
                duration: duration)
        case .changed:
            let translation = recognizer.translation(in: self)
            updateInteractiveTransition(
                distanceTraveled: translation.y)
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
        
        let velocityY = recognizer.velocity(in: self).y
        
        if velocityY != 0 {
            let isPanningOn = velocityY < 0
            isCancelled = (state == .on && !isPanningOn) ||
                (state == .off && isPanningOn)
        } else {
            isCancelled = false
        }
        
        return isCancelled
    }
}
