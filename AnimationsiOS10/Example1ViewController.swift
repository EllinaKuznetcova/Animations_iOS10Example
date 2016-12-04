//
//  ViewController.swift
//  AnimationsiOS10
//
//  Created by Ellina Kuznetcova on 21/11/2016.
//  Copyright © 2016 Ellina Kuznetcova. All rights reserved.
//

import UIKit

class Example1ViewController: UIViewController {
    
    @IBOutlet weak var squareView: UIView!
    var squareCenter: CGPoint!
    var squareAnimator: UIViewPropertyAnimator!
    var comeBackAnimator: UIViewPropertyAnimator!
    let animationDuration = 1.0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.squareView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.dragSquare)))
        
        self.squareAnimator = UIViewPropertyAnimator(duration: animationDuration, curve: .easeInOut, animations: { [weak self] in
            self?.squareView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        })
    }
    
    func dragSquare(gesture: UIPanGestureRecognizer) {
        let target = gesture.view!
        
        switch gesture.state {
        case .began:
            squareCenter = target.center
            
            if self.squareAnimator.state == .active {
                self.squareAnimator.stopAnimation(true)
            }
            
            self.squareAnimator.addAnimations({
                target.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            })
            self.squareAnimator.startAnimation()
        case .changed:
            let translation = gesture.translation(in: self.view)
            target.center = CGPoint(x: squareCenter!.x + translation.x, y: squareCenter!.y + translation.y)
        case .ended:
            let v = gesture.velocity(in: target)
            let velocity = CGVector(dx: v.x / 100, dy: v.y / 100)
            let springParameters = UISpringTimingParameters(mass: 100, stiffness: 70, damping: 2, initialVelocity: velocity)
            self.comeBackAnimator = UIViewPropertyAnimator(duration: 0.0, timingParameters: springParameters)
            self.comeBackAnimator.addAnimations { [unowned self] in
                target.center = self.view.center
            }
            self.squareAnimator.addAnimations({
                target.transform = CGAffineTransform.identity
            })
            self.squareAnimator.startAnimation()
            self.comeBackAnimator.startAnimation()
        default: break
        }
    }
}

