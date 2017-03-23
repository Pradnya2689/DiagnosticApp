//
//  ViewController.swift
//  DiagnosticDemo
//
//  Created by pradnya on 22/03/17.
//  Copyright © 2017 pradnya. All rights reserved.
//

import UIKit
let screenSize: CGRect = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height
class ViewController: UIViewController {
    @IBOutlet var circleVc:UIView!
    @IBOutlet var buttonVc:UIView!
    @IBOutlet var innerVc:UIView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
        self.fillCircle {
           self.annimateView()
        }
       
    }

    func fillCircle(finished: @escaping () -> Void){
        let circle = self.circleVc!
        
        var progressCircle = CAShapeLayer()
        
        let circlePath = UIBezierPath(ovalIn: circle.bounds)
        
        progressCircle = CAShapeLayer ()
        progressCircle.path = circlePath.cgPath
        progressCircle.strokeColor = UIColor.green.cgColor
        progressCircle.fillColor = UIColor.clear.cgColor
        progressCircle.lineWidth = 7.0
        
        circle.layer.addSublayer(progressCircle)
        
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 3
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        
        progressCircle.add(animation, forKey: "ani")
        finished()
        
    }
    func annimateView(){
        self.innerVc.frame = CGRect(x: screenWidth, y: 150 , width: screenWidth, height: screenHeight)
        
        UIView.animate(withDuration: 0.50, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [], animations: {
            //Set x position what ever you want
            self.innerVc.frame = CGRect(x: 0, y: 150 , width: screenWidth, height: screenHeight)
            
            
        }, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

