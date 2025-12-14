//
//  ViewController.swift
//  UniFix
//
//  Created by zahraa humaidan on 12/12/2025.
//

import UIKit
import FirebaseAuth

class WelcomeViewController: UIViewController {
   
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nextButton.animateGradient(colors: [UIColor.primaryDarkGrey,UIColor.primaryGrey])
    }
    
   
}
extension UIButton {
    func animateGradient(colors: [UIColor]) {
        self.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.cornerRadius = self.bounds.height / 2
        self.layer.insertSublayer(gradientLayer, at: 0)
        
        let animation = CABasicAnimation(keyPath: "startPoint")
        animation.fromValue = CGPoint(x: 0.0, y: 0.5)
        animation.toValue = CGPoint(x: 1.0, y: 0.5)
        animation.duration = 30
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.repeatCount = .infinity
        
        let endAnimation = CABasicAnimation(keyPath: "endPoint")
        endAnimation.fromValue = CGPoint(x: 1.0, y: 0.5)
        endAnimation.toValue = CGPoint(x: 0.0, y: 0.5)
        endAnimation.duration = 30
        endAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        endAnimation.repeatCount = .infinity
        
        gradientLayer.add(animation, forKey: "startPointAnimation")
        gradientLayer.add(endAnimation, forKey: "endPointAnimation")
        
        //
        gradientLayer.locations = [0.0,0.5, 1.0,0.5 ,0.0]
    }
}


