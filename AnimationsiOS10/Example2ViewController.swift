//
//  Example2ViewController.swift
//  AnimationsiOS10
//
//  Created by Ellina Kuznecova on 04.12.16.
//  Copyright © 2016 Ellina Kuznetcova. All rights reserved.
//

import UIKit

class Example2ViewController: UIViewController {
    
    @IBOutlet weak var squareView: UIView!
    var squareAnimator: UIViewPropertyAnimator!
    var squareCenter: CGPoint!
    var originalSquareCenter: CGPoint!
    var maxSquareCenter: CGPoint!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.squareCenter = self.squareView.center
        self.originalSquareCenter = self.squareView.center
        self.maxSquareCenter = CGPoint(x: self.view.frame.size.width - 16 - self.squareView.frame.size.width/2, y: self.originalSquareCenter.y)
        self.addAnimation()
    }
    
    func addAnimation() {
        self.squareAnimator = UIViewPropertyAnimator(duration: 2.0, curve: .easeInOut, animations: { [weak self] in
            guard let sself = self else {return}
            self?.squareView.center = sself.maxSquareCenter
        })
    }
    
    @IBAction func start() {
        self.squareAnimator.startAnimation()
    }
    
    @IBAction func pause() {
        self.squareAnimator.pauseAnimation()
    }
    
    @IBAction func stop() {
        self.squareAnimator.stopAnimation(false)
    }
    
    @IBAction func refresh() {
        self.squareView.center = self.originalSquareCenter
        
        self.addAnimation()
    }
}
