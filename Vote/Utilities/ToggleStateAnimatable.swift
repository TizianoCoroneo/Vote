//
//  ToggleStateAnimatable.swift
//  Vote
//
//  Created by Tiziano Coroneo on 31/12/2017.
//  Copyright © 2017 Tiziano Coroneo. All rights reserved.
//

import UIKit

enum ToggleState {
    case on
    case off
}

prefix func !(_ state: ToggleState) -> ToggleState {
    return state == .on ? .off : .on
}

protocol ToggleStateAnimatable: class {
    var view: UIView! { get set }
    var duration: TimeInterval { get }
    var state: ToggleState { get set }
    var runningAnimators: [UIViewPropertyAnimator] { get set }
    var progressWhenInterrupted: [UIViewPropertyAnimator : CGFloat] { get set }
    var initialAnimatedProperties: (() -> ()) { get }
    var targetAnimatedProperties: (() -> ()) { get }
    
    var processAnimationProgress: (CGFloat) -> (CGFloat) { get }
    
    func animateOrReverseRunningTransition(
        destinationState: ToggleState,
        duration: TimeInterval)
    
    func startInteractiveTransition(
        destinationState: ToggleState,
        duration: TimeInterval)
    
    func updateInteractiveTransition(
        distanceTraveled: CGFloat)
    
    func continueInteractiveTransition(
        cancel: Bool)
}

extension ToggleStateAnimatable {
    
    // Perform all animations with animators if not already running
    private func animateTransitionIfNeeded(
        destinationState: ToggleState,
        duration: TimeInterval) {
        if runningAnimators.isEmpty {
            self.state = destinationState
            
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1)
            addToRunningAnimators(frameAnimator) {
                [weak self] in
                guard let s = self else { return }
                
                s.updateFrame(for: s.state)
            }
        }
    }
    
    // Starts transition if necessary or reverses it on tap
    func animateOrReverseRunningTransition(
        destinationState: ToggleState,
        duration: TimeInterval) {
        if runningAnimators.isEmpty {
            animateTransitionIfNeeded(destinationState: destinationState, duration: duration)
        } else {
            reverseRunningAnimations()
        }
    }
    
    // Starts transition if necessary and pauses on pan .begin
    func startInteractiveTransition(
        destinationState: ToggleState,
        duration: TimeInterval) {
        animateTransitionIfNeeded(
            destinationState: destinationState,
            duration: duration)
        
        progressWhenInterrupted = [:]
        for animator in runningAnimators {
            animator.pauseAnimation()
            progressWhenInterrupted[animator] = animator.fractionComplete
        }
    }
    
    // Scrubs transition on pan .changed
    func updateInteractiveTransition(
        distanceTraveled: CGFloat) {
        let fractionComplete = processAnimationProgress(distanceTraveled)
        
        for animator in runningAnimators {
            if let progressWhenInterrupted = progressWhenInterrupted[animator] {
                let relativeFractionComplete = fractionComplete + progressWhenInterrupted
                
                if (state == .on && relativeFractionComplete > 0) ||
                    (state == .off && relativeFractionComplete < 0) {
                    animator.fractionComplete = 0
                } else if (state == .on && relativeFractionComplete < -1) ||
                    (state == .off && relativeFractionComplete > 1) {
                    animator.fractionComplete = 1
                } else {
                    animator.fractionComplete = abs(fractionComplete) + progressWhenInterrupted
                }
            }
        }
    }
    
    // Continues or reverse transition on pan .ended
    func continueInteractiveTransition(cancel: Bool) {
        if cancel {
            reverseRunningAnimations()
        }
        
        let timing = UICubicTimingParameters(animationCurve: .easeOut)
        for animator in runningAnimators {
            animator.continueAnimation(withTimingParameters: timing, durationFactor: 0)
        }
    }
    
    // MARK: - Appearance Animations
    
    private func updateFrame(for state: ToggleState) {
        switch state {
        case .on:
            targetAnimatedProperties()
        case .off:
            initialAnimatedProperties()
        }
        
        view?.layoutIfNeeded()
    }
    
    // MARK: - Running Animation Helpers
    
    private func addToRunningAnimators(
        _ animator: UIViewPropertyAnimator,
        animation: @escaping () -> Void) {
        
        animator.addAnimations { animation() }
        animator.addCompletion { _ in
            self.runningAnimators = self.runningAnimators
                .filter { $0 != animator }
            
            // Especially after reversing animations, make sure the UI has correct
            // appearance for it 'state'. We can achieve this by reapplying the "final animation".
            animation()
        }
        
        animator.startAnimation()
        runningAnimators.append(animator)
    }
    
    private func reverseRunningAnimations() {
        for animator in runningAnimators {
            animator.isReversed = !animator.isReversed
        }
        
        state = !state
    }
}


