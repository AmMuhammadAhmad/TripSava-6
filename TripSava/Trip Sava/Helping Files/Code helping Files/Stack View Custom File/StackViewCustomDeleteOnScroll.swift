//
//  StackViewCustomDeleteOnScroll.swift
//  TripSava
//
//  Created by Muhammad Ahmad on 31/08/2023.
//

import UIKit

///SwipeToDeleteGestureRecognizer..
class SwipeToDeleteGestureRecognizer: UIPanGestureRecognizer {
    
    //MARK: - Variables...
    var onSwiped: (() -> Void)?
    
    //MARK: - Functions...
    
    ///reset..
    override func reset() { super.reset(); state = .possible  }
}

//MARK: - Extension...
extension UIView {
    
    //MARK: - Functions...
    
    ///addSwipeToDeleteGesture...
    func addSwipeToDeleteGesture<T>(item: T, onSwiped: @escaping (T) -> Void) {
        let swipeToDeleteGesture = SwipeToDeleteGestureRecognizer(target: self, action: #selector(handleSwipeToDelete(_:)))
        self.tag = 123
        swipeToDeleteGesture.onSwiped = { [weak self] in
            guard let self = self else { return } // Swipe direction check...
            if self.transform.tx < 0 { onSwiped(item) }
        }
        addGestureRecognizer(swipeToDeleteGesture); isUserInteractionEnabled = true
    }
    
    ///handleSwipeToDelete...
    @objc private func handleSwipeToDelete(_ gesture: SwipeToDeleteGestureRecognizer) {
        let translation = gesture.translation(in: self)
        switch gesture.state {
        case .changed: didChanged(translation: translation)
        case .ended: OnEnded(translation: translation, gesture: gesture)
        default: handleDefaultBehaviourOfView()
        }
    }
    
    ///didChanged...
    func didChanged(translation: CGPoint){
        if translation.x < 0 { transform = CGAffineTransform(translationX: translation.x, y: 0) }
    }
    
    ///OnEnded..
    func OnEnded(translation: CGPoint, gesture: SwipeToDeleteGestureRecognizer){
        if translation.x < 0, abs(translation.x) > bounds.width * 0.4 { gesture.onSwiped?(); UIView.animate(withDuration: 0.3) { self.transform = .identity } }
        else { UIView.animate(withDuration: 0.3) { self.transform = .identity } }
    }
    
    ///handleDefaultBehaviourOfView...
    func handleDefaultBehaviourOfView(){ UIView.animate(withDuration: 0.3) { self.transform = .identity } }
    
}
