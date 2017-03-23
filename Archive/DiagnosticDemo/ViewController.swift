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
    @IBOutlet var buttonScroll:UIScrollView!
    
    @IBOutlet var gpsBtn:UIButton!
    @IBOutlet var wifiBtn : UIButton!
    @IBOutlet var proximityBtn:UIButton!
    @IBOutlet var volumeBtn:UIButton!
    
    @IBOutlet var resultLabel:UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ""
        // Do any additional setup after loading the view, typically from a nib.
        self.buttonVc.translatesAutoresizingMaskIntoConstraints = true
        self.buttonVc.frame = CGRect(x: ((screenWidth/2)-25), y: 0, width: 603, height: 128);
        
        loadEmptyCircle()
        loadFillCircle()
        let when = DispatchTime.now() + 4 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            // Your code with delay
            self.annimateView()
            self.loadSEcondVC()
            
        }
//        self.fillCircle {
//           self.annimateView()
//        }
       
    }
        //volume button test
    func loadSEcondVC(){
        self.gpsBtn.backgroundColor = UIColor.green
        self.volumeBtn.backgroundColor = UIColor.blue
        self.buttonVc.frame = CGRect(x: ((screenWidth/2)-25), y: 0, width: 603, height: 128);
        
        UIView.animate(withDuration: 0.50, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [], animations: {
            //Set x position what ever you want
            self.buttonVc.frame = CGRect(x: 0, y: 0, width: 603, height: 128);
            
            self.loadEmptyCircle()
            self.loadFillCircle()
            let when = DispatchTime.now() + 4 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                // Your code with delay
                self.annimateView()
                self.loadThirdView()
                
            }
        }, completion: nil)
      //  self.buttonVc.translatesAutoresizingMaskIntoConstraints = true
        
        
    }
    //proximity test
    func loadThirdView(){
        self.volumeBtn.backgroundColor = UIColor.green
        self.proximityBtn.backgroundColor = UIColor.blue
        self.buttonVc.frame = CGRect(x: 0, y: 0, width: 603, height: 128);
        
        UIView.animate(withDuration: 0.50, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [], animations: {
            //Set x position what ever you want
            self.buttonVc.frame = CGRect(x: -145, y: 0, width: 603, height: 128);
            
            self.loadEmptyCircle()
            self.loadFillCircle()
            let when = DispatchTime.now() + 4 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                // Your code with delay
                self.annimateView()
                self.loadFourthView()
                
            }
        }, completion: nil)
    }
    //wifi test
    func loadFourthView(){
        self.proximityBtn.backgroundColor = UIColor.green
        self.wifiBtn.backgroundColor = UIColor.blue
        self.buttonVc.frame = CGRect(x: -145, y: 0, width: 603, height: 128);
        
        UIView.animate(withDuration: 0.50, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [], animations: {
            //Set x position what ever you want
            self.buttonVc.frame = CGRect(x: -280, y: 0, width: 603, height: 128);
            
            self.loadEmptyCircle()
            self.loadFillCircle()
            
        }, completion: nil)
        
        let when = DispatchTime.now() + 4 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            // Your code with delay
           let reportVC = self.storyboard?.instantiateViewController(withIdentifier: "reportVC") as! ReportViewController
            self.navigationController?.pushViewController(reportVC, animated: true)
            
        }
    }
    // load empty gray circle
    func loadEmptyCircle(){
        let circle = self.circleVc!
        var progressCircle1 = CAShapeLayer()
        
        let circlePath1 = UIBezierPath(ovalIn: circle.bounds)
        
        progressCircle1 = CAShapeLayer ()
        progressCircle1.path = circlePath1.cgPath
        progressCircle1.strokeColor = UIColor.lightGray.cgColor
        progressCircle1.fillColor = UIColor.clear.cgColor
        progressCircle1.lineWidth = 11.0
        
        circle.layer.addSublayer(progressCircle1)
    }
    
    // load animation circle
    func loadFillCircle(){
         let circle = self.circleVc!
        var progressCircle = CAShapeLayer()
        
        let circlePath = UIBezierPath(ovalIn: circle.bounds)
        
        progressCircle = CAShapeLayer ()
        progressCircle.path = circlePath.cgPath
        progressCircle.strokeColor = UIColor.green.cgColor
        progressCircle.fillColor = UIColor.clear.cgColor
        progressCircle.lineWidth = 9.0
        
        circle.layer.addSublayer(progressCircle)
        
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 3
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        
        progressCircle.add(animation, forKey: "ani")
    }
    // animate loader view
    func annimateView(){
        self.innerVc.frame = CGRect(x: screenWidth, y: 150 , width: screenWidth, height: screenHeight)
        
        UIView.animate(withDuration: 0.50, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [], animations: {
            //Set x position what ever you want
            self.innerVc.frame = CGRect(x: 0, y: 150 , width: screenWidth, height: screenHeight)
            
            
        }, completion: nil)
    }
    //unused code
    func fillCircle(finished: @escaping () -> Void){
        let circle = self.circleVc!
        var progressCircle1 = CAShapeLayer()
        
        let circlePath1 = UIBezierPath(ovalIn: circle.bounds)
        
        progressCircle1 = CAShapeLayer ()
        progressCircle1.path = circlePath1.cgPath
        progressCircle1.strokeColor = UIColor.lightGray.cgColor
        progressCircle1.fillColor = UIColor.clear.cgColor
        progressCircle1.lineWidth = 11.0
        
        circle.layer.addSublayer(progressCircle1)
        var progressCircle = CAShapeLayer()
        
        let circlePath = UIBezierPath(ovalIn: circle.bounds)
        
        progressCircle = CAShapeLayer ()
        progressCircle.path = circlePath.cgPath
        progressCircle.strokeColor = UIColor.green.cgColor
        progressCircle.fillColor = UIColor.clear.cgColor
        progressCircle.lineWidth = 9.0
        
        circle.layer.addSublayer(progressCircle)
        
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 3
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        
        progressCircle.add(animation, forKey: "ani")
        finished()
        let when = DispatchTime.now() + 4 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            // Your code with delay
            self.annimateView()
            self.loadSEcondVC()
            
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

