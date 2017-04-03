 //
//  ViewController.swift
//  DiagnosticDemo
//
//  Created by pradnya on 22/03/17.
//  Copyright © 2017 pradnya. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import MediaPlayer
import CoreBluetooth
import CoreLocation
// import Reachability

let screenSize: CGRect = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height
 
 var gpstestResult : String!
 var volumeTest : String!
 var proximityTestresult : String!
 var wifiTestresult : String!
 
 var reachability = Reachability()


open class Toast{
    
    class var sharedInstance: Toast {
        struct Static {
            static let sharedInstance: Toast = Toast()
        }
        return Static.sharedInstance
    }
    
    
    func rectForText(_ text: String, font: UIFont, maxSize: CGSize) -> CGSize {
        let attrString = NSAttributedString.init(string: text, attributes: [NSFontAttributeName:font])
        let rect = attrString.boundingRect(with: maxSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        let size = CGSize(width: rect.size.width, height: rect.size.height)
        return size
    }
    
    
    open func toastNormal(_ backgroundColor:UIColor, textColor:UIColor, message:String, numberOfLines:Int, height:CGFloat, position:String)
    {
        
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let label = UILabel(frame: CGRect.zero)
        label.textAlignment = NSTextAlignment.center
        label.text = message
        label.font = UIFont(name: "MyriadPro-Regular", size: 17)
        label.adjustsFontSizeToFitWidth = true
        
        label.backgroundColor =  UIColor(red: 26.0/255.0, green: 41.0/255.0, blue: 64.0/255.0, alpha: 1)
        label.textColor = UIColor.white
        
        label.sizeToFit()
        label.numberOfLines = numberOfLines
        label.layer.shadowColor = UIColor.gray.cgColor
        label.layer.shadowOffset = CGSize(width: 4, height: 3)
        label.layer.shadowOpacity = 0.3
        if(position == "bottom"){
            label.frame = CGRect(x: (screenWidth-200)/2,y: screenHeight-50, width: 200, height: height)
        }else if(position == "center"){
            label.frame = CGRect(x: (screenWidth-200)/2,y: (screenHeight-height)/2, width: 200, height: height)
        }else{
            label.frame = CGRect(x: (screenWidth-200)/2,y: 120, width: 200, height: height)
        }
        
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.alpha = 1
        
        //Indicator.sharedInstance.stopActivityIndicator()
        appDelegate.window!.addSubview(label)
        
        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.curveEaseOut, animations: { () -> Void in
            //label.frame = CGRectMake((screenWidth-200)/2,screenHeight-50, 200, height)
            if(position == "bottom"){
                label.frame = CGRect(x: (screenWidth-200)/2,y: screenHeight-50, width: 200, height: height)
            }else if(position == "center"){
                label.frame = CGRect(x: (screenWidth-200)/2,y: (screenHeight-height)/2, width: 200, height: height)
            }else{
                label.frame = CGRect(x: (screenWidth-200)/2,y: 120, width: 200, height: height)
            }
        },  completion: {
            (value: Bool) in
            UIView.animate(withDuration: 2.0, delay: 2.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
                label.alpha = 0
            },  completion: {
                (value: Bool) in
                label.removeFromSuperview()
            })
        })
    }
    
    
    open func textOnlyToast(_ message:String, position:String)
    {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let label = UILabel(frame: CGRect.zero)
        label.textAlignment = NSTextAlignment.center
        label.text = message
        label.font = UIFont(name: "MyriadPro-Regular", size: 15)
        label.adjustsFontSizeToFitWidth = true
        
        label.backgroundColor =  UIColor(red: 26.0/255.0, green: 41.0/255.0, blue: 64.0/255.0, alpha: 1)
        label.textColor = UIColor.white
        
        let sizeoftxt:CGSize  = rectForText(message, font: label.font, maxSize: CGSize(width: screenWidth-100,height: 200))
        
        
        label.sizeToFit()
        label.numberOfLines = 10
        label.layer.shadowColor = UIColor.gray.cgColor
        label.layer.shadowOffset = CGSize(width: 4, height: 3)
        label.layer.shadowOpacity = 0.3
        if(position == "bottom"){
            label.frame = CGRect(x: (screenWidth-200)/2,y: screenHeight-120, width: 200, height: 60)
        }else if(position == "center"){
            label.frame = CGRect(x: (screenWidth-200)/2,y: (screenHeight-sizeoftxt.height)/2, width: 200, height: 60)
        }else{
            label.frame = CGRect(x: (screenWidth-200)/2,y: 120, width: 200, height: 60)
        }
        //label.frame = CGRectMake((screenWidth-200)/2,(screenHeight-sizeoftxt.height)/2, 200, sizeoftxt.height)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.alpha = 1
        
        //Indicator.sharedInstance.stopActivityIndicator()
        appDelegate.window!.addSubview(label)
        
        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.curveEaseOut, animations: { () -> Void in
            if(position == "bottom"){
                label.frame = CGRect(x: (screenWidth-200)/2,y: screenHeight-120, width: 200, height: 60)
            }else if(position == "center"){
                label.frame = CGRect(x: (screenWidth-200)/2,y: (screenHeight-sizeoftxt.height)/2, width: 200, height: 60)
            }else{
                label.frame = CGRect(x: (screenWidth-200)/2,y: 120, width: 200, height: 60)
            }
            //label.frame = CGRectMake((screenWidth-200)/2,(screenHeight-sizeoftxt.height)/2, 200, sizeoftxt.height)
        },  completion: {
            (value: Bool) in
            UIView.animate(withDuration: 2.0, delay: 2.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
                label.alpha = 0
            },  completion: {
                (value: Bool) in
                label.removeFromSuperview()
            })
        })
        
    }
    
    open func intervalToast(_ message:String, interval:Double, position:String)
    {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let label = UILabel(frame: CGRect.zero)
        label.textAlignment = NSTextAlignment.center
        label.text = message
        label.font = UIFont(name: "MyriadPro-Regular", size: 13)
        label.adjustsFontSizeToFitWidth = true
        
        label.backgroundColor =  UIColor(red: 26.0/255.0, green: 41.0/255.0, blue: 64.0/255.0, alpha: 1)
        label.textColor = UIColor.white
        
        let sizeoftxt:CGSize  = rectForText(message, font: label.font, maxSize: CGSize(width: screenWidth-100,height: 200))
        
        
        label.sizeToFit()
        label.numberOfLines = 10
        label.layer.shadowColor = UIColor.gray.cgColor
        label.layer.shadowOffset = CGSize(width: 4, height: 3)
        label.layer.shadowOpacity = 0.3
        if(position == "bottom"){
            label.frame = CGRect(x: (screenWidth-200)/2,y: screenHeight-50, width: 200, height: sizeoftxt.height)
        }else if(position == "center"){
            label.frame = CGRect(x: (screenWidth-200)/2,y: (screenHeight-sizeoftxt.height)/2, width: 200, height: sizeoftxt.height)
        }else{
            label.frame = CGRect(x: (screenWidth-200)/2,y: 120, width: 200, height: sizeoftxt.height)
        }
        //label.frame = CGRectMake((screenWidth-200)/2,(screenHeight-sizeoftxt.height)/2, 200, sizeoftxt.height)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.alpha = 1
        
        //Indicator.sharedInstance.stopActivityIndicator()
        appDelegate.window!.addSubview(label)
        
        UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.curveEaseOut, animations: { () -> Void in
            if(position == "bottom"){
                label.frame = CGRect(x: (screenWidth-200)/2,y: screenHeight-50, width: 200, height: sizeoftxt.height)
            }else if(position == "center"){
                label.frame = CGRect(x: (screenWidth-200)/2,y: (screenHeight-sizeoftxt.height)/2, width: 200, height: sizeoftxt.height)
            }else{
                label.frame = CGRect(x: (screenWidth-200)/2,y: 120, width: 200, height: sizeoftxt.height)
            }
            //label.frame = CGRectMake((screenWidth-200)/2,(screenHeight-sizeoftxt.height)/2, 200, sizeoftxt.height)
        },  completion: {
            (value: Bool) in
            UIView.animate(withDuration: interval, delay: 2.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
                label.alpha = 0
            },  completion: {
                (value: Bool) in
                label.removeFromSuperview()
            })
        })
        
    }
}

class ViewController: UIViewController ,AVAudioPlayerDelegate,AVAudioRecorderDelegate,CLLocationManagerDelegate {
    @IBOutlet var circleVc:UIView!
    @IBOutlet var buttonVc:UIView!
    @IBOutlet var innerVc:UIView!
    @IBOutlet var buttonScroll:UIScrollView!
    
    @IBOutlet var gpsBtn:UIButton!
    @IBOutlet var wifiBtn : UIButton!
    @IBOutlet var proximityBtn:UIButton!
    @IBOutlet var volumeBtn:UIButton!
    
    @IBOutlet var TestImage: UIImageView!
    var audioPlayer = AVAudioPlayer()
    var audioRecorder: AVAudioRecorder?
    var volumelvl1 = Float()
    
    @IBOutlet var EndTaskBtn: UIButton!
    var xcoord : Double!
    var ycoord : Double!
    var locationManager = CLLocationManager()
    
    var volumeflagup : String!
    var volumeflagdwn : String!
    @IBOutlet var gifImg:UIImageView!
    
    let device = UIDevice.current
    
     var audioSession =  AVAudioSession()
    
    let reachability = Reachability()!
    
    @IBOutlet var resultLabel:UILabel!
    
    @IBOutlet var testNameLbl:UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.resultLabel.text = "GPS Test."
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.title = ""
        self.EndTaskBtn.isHidden = true
        // self.resultLabel.text = "GPS Test."
       
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        
        self.title = "Smart Check"
        loadEmptyCircle()
        
        gpstestResult = "0"
        proximityTestresult = "0"
        volumeTest = "0"
        wifiTestresult = "0"
        self.volumeflagup = "0"
        self.volumeflagdwn = "0"
     
        self.testNameLbl.text = "GPS Test"
        self.gpsBtn.setBackgroundImage(UIImage.init(named: "gpsSel"), for: .normal)
        self.proximityBtn.setBackgroundImage(UIImage.init(named: "proximity"), for: .normal)
        self.volumeBtn.setBackgroundImage(UIImage.init(named: "volume"), for: .normal)
        self.wifiBtn.setBackgroundImage(UIImage.init(named: "wifi"), for: .normal)
        
//        self.proximityBtn.backgroundColor = UIColor.lightGray
//        self.volumeBtn.backgroundColor = UIColor.lightGray
//        self.wifiBtn.backgroundColor = UIColor.lightGray
        
        
        self.TestImage.image = UIImage(named: "gps")
    }
    override func viewDidAppear(_ animated: Bool) {
        self.resultLabel.text = "GPS Test."
        self.resultLabel.text = "Ensure the device GPS feature is on."
       // self.resultLabel.text = "GPS Test."
         //self.resultLabel.text =
//        [UIView animateWithDuration:1.0
//            animations:^{
//            label.alpha = 0.0f;
//            label.text = newText;
//            label.alpha = 1.0f;
//            }];
        let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            // Your code with delay
            self.gpsBtnAction()
        }
        
    
        self.TestImage.image = UIImage(named: "wocGps")
    }
//    override func viewDidAppear(_ animated: Bool) {
//        
//    }
    
    func reachabilityStatusChanged(_ sender: NSNotification)
    {
//        guard let networkStatus = (sender.object as? Reachability)?.currentReachabilityStatus() else { return }
//        updateInterfaceWithCurrent(networkStatus: networkStatus)
    }
        //volume button test
    func loadSEcondVC(){
        self.testNameLbl.text = "Proximity Sensor Test"
        self.resultLabel.text = ""
        let gifManager = SwiftyGifManager(memoryLimit:50)
        // let gif = UIImage(gifName: "motion_gesture_aircall6.gif")
        let gifImage = UIImage(gifName: "motion_gesture_aircall6.gif")
        self.gifImg.setGifImage(gifImage, manager: gifManager, loopCount: 20)
        self.gifImg.isHidden = false
        self.TestImage.isHidden = true
        
 
        //self.gpsBtn.setBackgroundImage(UIImage.init(named: "gpsSel"), for: .normal)
        self.proximityBtn.setBackgroundImage(UIImage.init(named: "proxSel"), for: .normal)
        self.volumeBtn.setBackgroundImage(UIImage.init(named: "volume"), for: .normal)
        self.wifiBtn.setBackgroundImage(UIImage.init(named: "wifi"), for: .normal)
       
        UIView.animate(withDuration: 0.50, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [], animations: {
            
            self.loadEmptyCircle()
            
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when) {
                
               self.proximityDetector()
            }
            
            
            
        }, completion: nil)
        
    }
    //proximity test
    func loadThirdView(){
        self.testNameLbl.text = "Volume Button Test"
        self.resultLabel.text = ""
         (MPVolumeView().subviews.filter{NSStringFromClass($0.classForCoder) == "MPVolumeSlider"}.first as? UISlider)?.setValue(0.5, animated: false)
        
         (MPVolumeView().subviews.filter{NSStringFromClass($0.classForCoder) == "MPVolumeSlider"}.first as? UISlider)?.setValue(0.5, animated: false)
        self.resultLabel.text = "Press Volume Up"
      
        self.gifImg.isHidden = true
        self.TestImage.isHidden = false
        self.TestImage.image = nil
        self.TestImage.gifImage = nil
        self.TestImage.image = UIImage(named: "wocvol")
      //  self.proximityBtn.setBackgroundImage(UIImage.init(named: "proxSel"), for: .normal)
        self.volumeBtn.setBackgroundImage(UIImage.init(named: "volumeSel"), for: .normal)
        self.wifiBtn.setBackgroundImage(UIImage.init(named: "wifi"), for: .normal)
        UIView.animate(withDuration: 0.50, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [], animations: {
            
            self.loadEmptyCircle()
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when) {
                
               self.volumedetect()
            }
            
           
        }, completion: nil)
    }
    //wifi test
    func loadFourthView(){
        
             self.testNameLbl.text = "Wi-Fi Test"
        self.resultLabel.text = ""
        self.TestImage.image = UIImage(named: "wocwifi")
//        self.volumeBtn.backgroundColor = UIColor.green
//        self.wifiBtn.backgroundColor = UIColor.blue
//        self.gpsBtn.setBackgroundImage(UIImage.init(named: "gpsSel"), for: .normal)
//        self.proximityBtn.setBackgroundImage(UIImage.init(named: "proxSel"), for: .normal)
//        self.volumeBtn.setBackgroundImage(UIImage.init(named: "volumeSel"), for: .normal)
        self.wifiBtn.setBackgroundImage(UIImage.init(named: "wifiSel"), for: .normal)
        
        UIView.animate(withDuration: 0.50, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [], animations: {
            
            self.loadEmptyCircle()
            let when = DispatchTime.now() + 1
            DispatchQueue.main.asyncAfter(deadline: when) {
                 self.wifi()
            }
            
        }, completion: nil)
        
       
    }
    // load empty gray circle
    func loadEmptyCircle(){
        let circle = self.circleVc!
        var progressCircle1 = CAShapeLayer()
        
        let circlePath1 = UIBezierPath(ovalIn: circle.bounds)
        
        progressCircle1 = CAShapeLayer ()
        progressCircle1.path = circlePath1.cgPath
        progressCircle1.strokeColor = UIColor.init(red: 188/255.0, green: 188/255.0, blue: 188/255.0, alpha: 1).cgColor
        progressCircle1.fillColor = UIColor.clear.cgColor
        progressCircle1.lineWidth = 8.0
        
        self.circleVc.layer.addSublayer(progressCircle1)
    }
    
    // load animation circle
    func loadFillCircle()
    {
         let circle = self.circleVc!
        var progressCircle = CAShapeLayer()
        
        let circlePath = UIBezierPath(ovalIn: circle.bounds)
        
        progressCircle = CAShapeLayer ()
        progressCircle.path = circlePath.cgPath
        progressCircle.strokeColor = UIColor.init(red: 0, green: 128/255.0, blue: 255/255, alpha: 1).cgColor

        progressCircle.fillColor = UIColor.clear.cgColor
        progressCircle.lineWidth = 7.0
        
        circle.layer.addSublayer(progressCircle)
        
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        
        progressCircle.add(animation, forKey: "ani")
    }
    func HalfFillCircle()
    {
        let circle = self.circleVc!
        var progressCircle = CAShapeLayer()
        
        let circlePath = UIBezierPath(ovalIn: circle.bounds)
        
        progressCircle = CAShapeLayer ()
        progressCircle.path = circlePath.cgPath
        progressCircle.strokeColor = UIColor.init(red: 0, green: 128/255.0, blue: 255/255, alpha: 1).cgColor
        progressCircle.fillColor = UIColor.clear.cgColor
        progressCircle.lineWidth = 8.0
        
        circle.layer.addSublayer(progressCircle)
        
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 0.5
        animation.duration = 2
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        
        progressCircle.add(animation, forKey: "ani")
    }
    func AnotherHalfFillCircle()
    {
        let circle = self.circleVc!
        var progressCircle = CAShapeLayer()
        
        let circlePath = UIBezierPath(ovalIn: circle.bounds)
        
        progressCircle = CAShapeLayer ()
        progressCircle.path = circlePath.cgPath
        progressCircle.strokeColor = UIColor.init(red: 0, green: 128/255.0, blue: 255/255, alpha: 1).cgColor
        progressCircle.fillColor = UIColor.clear.cgColor
        progressCircle.lineWidth = 8.0
        
        circle.layer.addSublayer(progressCircle)
        
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.5
        animation.toValue = 1
        animation.duration = 2
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
        progressCircle1.lineWidth = 8.0
        
        circle.layer.addSublayer(progressCircle1)
        var progressCircle = CAShapeLayer()
        
        let circlePath = UIBezierPath(ovalIn: circle.bounds)
        
        progressCircle = CAShapeLayer ()
        progressCircle.path = circlePath.cgPath
        progressCircle.strokeColor = UIColor.init(red: 0, green: 128/255.0, blue: 255/255, alpha: 1).cgColor
        progressCircle.fillColor = UIColor.clear.cgColor
        progressCircle.lineWidth = 8.0
        
        circle.layer.addSublayer(progressCircle)
        
       
    }

    
    //# MARK: - Volume Detect
    func volumedetect() -> Void{
       
        self.resultLabel.text = "Press volume up button of your phone."
        self.volumeflagup = "0"
        self.volumeflagdwn = "0"
        
        volumelvl1 = MPMusicPlayerController.applicationMusicPlayer().value(forKey: "volume") as! Float
        do{
           
            try audioSession.setActive(true)
            audioSession.addObserver(self, forKeyPath: "outputVolume", options: NSKeyValueObservingOptions.new, context: nil)
        }catch{
            print("could not start reachability notifier")
        }
      
    }
    
    func volumeChanged(notification: NSNotification){
        print("got in here")
    }
    

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "outputVolume"{
            print("got in here")
            // float volumeLevel = [[MPMusicPlayerController applicationMusicPlayer] volume]
            var volumelvl = MPMusicPlayerController.applicationMusicPlayer().value(forKey: "volume") as! Float
            print(volumelvl)
            print(volumelvl1)
            


            if ((volumelvl > volumelvl1) && (self.volumeflagup == "0") && (self.volumeflagdwn == "0"))
            {
                print("up");
                self.volumeflagup = "1"
                 self.HalfFillCircle()
                // self.volumeBtn.setBackgroundImage(UIImage.init(named: "volume"), for: .normal)
                 self.TestImage.image = UIImage(named: "volumeup")
                self.resultLabel.text = "Press Volume Down Button."
                self.resultLabel.text = "Press the Volume Down Button of your phone."
                volumelvl1 = volumelvl
            }
                
           else  if ((volumelvl < volumelvl1)  && (self.volumeflagup == "1") && (self.volumeflagdwn == "0"))
            {
               
              
                volumelvl1 = volumelvl
                    print("down");
                self.volumeflagdwn = "1"
                self.TestImage.image = UIImage(named: "volumedown")
                 self.AnotherHalfFillCircle()
                   }
            
            else
            {
            volumelvl1 = volumelvl
            }
            
            
            
            if (self.volumeflagup == "1" && self.volumeflagdwn == "1")
            {
            
                
                do
                {
                     audioSession.removeObserver(self, forKeyPath: "outputVolume", context: nil)
                    try audioSession.setActive(false)
                     volumeTest  = "1"
//                    self.loadFillCircle()
//                    let when = DispatchTime.now() + 4 // change 2 to desired number of seconds
//                    DispatchQueue.main.asyncAfter(deadline: when) {
//
//                        // Your code with delay
//                        self.annimateView()
//                        self.loadFourthView()
//                        
//                    }
                    self.loadFillCircle()
                    
                    let when = DispatchTime.now() + 3 // change 2 to desired number of seconds
                    DispatchQueue.main.asyncAfter(deadline: when) {
                        
                        self.volumeBtn.setBackgroundImage(UIImage.init(named: "succvol"), for: .normal)
                        self.resultLabel.text = "Volume Button test successful."
                        
                        
                    }
                    let when1 = DispatchTime.now() + 5  // change 2 to desired number of seconds
                    DispatchQueue.main.asyncAfter(deadline: when1) {
                        
                        self.annimateView()
                        self.loadFourthView()
                        
                    }
                }
                catch
                {
                
                }
            }
            
            
        }
    }
    
    //# MARK: - Proximity
    func proximityDetector() -> Void {
       
        self.resultLabel.text = "Slowly hover your hand on the top of the phone."
      //device = UIDevice.current
        device.isProximityMonitoringEnabled = true
        if device.isProximityMonitoringEnabled {
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "UIDeviceProximityStateDidChangeNotification")  , object: device)
            NotificationCenter.default.addObserver(self, selector: #selector(proximityChanged(notification:)), name: NSNotification.Name(rawValue: "UIDeviceProximityStateDidChangeNotification"), object: device)
        }
        if device.isProximityMonitoringEnabled == false{
            proximityTestresult = "0"
        }
    }
    
    func proximityChanged(notification: NSNotification) {

        device.isProximityMonitoringEnabled = false
       
        if let device = notification.object as? UIDevice
        {
             NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "UIDeviceProximityStateDidChangeNotification")  , object: device)
            print("\(device) detected!")
            proximityTestresult = "1"
            self.resultLabel.text = "Proximity Sensors Test In Progress."
            self.loadFillCircle()
            
            
            let when = DispatchTime.now() + 3 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.proximityBtn.setBackgroundImage(UIImage.init(named: "succproxi"), for: .normal)
                self.resultLabel.text = "Proximity sensor test successful."
                
                
            }
            let when1 = DispatchTime.now() + 4  // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when1) {
                // Your code with delay
                //self.resultLabel.text = "Location detected: \(locValue.latitude) \(locValue.longitude)"
                self.annimateView()
                self.loadThirdView()
                
            }
            
        }
        else
        {
            print("\(device) not detected!")
            proximityTestresult = "0"
            self.proximityBtn.setBackgroundImage(UIImage.init(named: "failproxi"), for: .normal)
            self.resultLabel.text = "Proximity sensor test failed."
            self.loadFillCircle()
            
            
            let when = DispatchTime.now() + 3 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                
               // self.resultLabel.text = "Proximity sensor test success."
                
                
            }
            let when1 = DispatchTime.now() + 4  // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when1) {
                // Your code with delay
                //self.resultLabel.text = "Location detected: \(locValue.latitude) \(locValue.longitude)"
                self.annimateView()
                self.loadThirdView()
                
            }

        
        }
    }
    
    //# MARK: - Wifi
    
    // @IBAction func wifiBtnAction(_ sender: Any) {
    func wifi() -> Void
    {
        
       self.resultLabel.text = "Ensure the device's Wi-Fi feature is on."
       
       if (Reachability2.isConnectedToNetwork())
        {
            print("Internet Connection Available!")
           NotificationCenter.default.removeObserver(self, name: ReachabilityChangedNotification, object: reachability)
            
            let wifiName = Reachability2.getSSID()
             let wifiName1 = Reachability2.fetchSSIDInfo()
            
            guard wifiName != nil else {
                
                print("no wifi name")
                self.resultLabel.text = "Wi-Fi test failed. Connect to a Wi-Fi network to perform this test."
                
                return
            }
        
            print("my network name is: \(wifiName!)")
            //wifiTestresult = "1"
            
              self.loadFillCircle()
            let when = DispatchTime.now() + 3 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                wifiTestresult = "1"
               self.resultLabel.text = "Wi-Fi test successful."
                
                
            }
            
            Toast.sharedInstance.textOnlyToast("Wi-Fi connected to \(wifiName!)", position: "bottom")
            
            let when1 = DispatchTime.now() + 4 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when1) {
                // Your code with delay
                let reportVC = self.storyboard?.instantiateViewController(withIdentifier: "reportVC") as! ReportViewController
                self.navigationController?.pushViewController(reportVC, animated: true)
                
            }
            
        }
        else
        {
            resultLabel.text = "Wi-Fi test failed. Turn-on Wi-Fi on the device"
            self.wifiBtn.setBackgroundImage(UIImage.init(named: "failwifi"), for: .normal)
             self.EndTaskBtn.isHidden = false
            wifiTestresult = "0"
            print("Internet Connection not Available!")
            NotificationCenter.default.removeObserver(self, name: ReachabilityChangedNotification, object: reachability)
            NotificationCenter.default.addObserver(self, selector:  #selector(ViewController.reachabilityChanged(_:)),name: ReachabilityChangedNotification,object: reachability)
            do{
                try reachability.startNotifier()
            }catch{
                print("could not start reachability notifier")
            }
            
        }
    }
    func reachabilityChanged(_ sender: NSNotification) {
        
        self.resultLabel.text = "Auto-test in progress. Wi-Fi is connected."
        
        let reachability = sender.object as! Reachability
   
        if (Reachability2.isConnectedToNetwork())
        {
            NotificationCenter.default.removeObserver(self, name: ReachabilityChangedNotification, object: reachability)
            print("Internet Connection Available!")
           NotificationCenter.default.removeObserver(self, name: ReachabilityChangedNotification, object: reachability)
             self.EndTaskBtn.isHidden = true
            let wifiName = Reachability2.getSSID()
            
            let wifiName1 = Reachability2.fetchSSIDInfo()
            
            guard wifiName != nil else {
                 //// TODO: Alert -----
                print("no wifi name")
                 return
            }
             print("my network name is: \(wifiName!)")
            
            self.loadFillCircle()
            
            
            let when = DispatchTime.now() + 3 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                wifiTestresult = "1"
                self.resultLabel.text = "Wi-Fi Test Completed."
                self.wifiBtn.setBackgroundImage(UIImage.init(named: "succwifi"), for: .normal)
                
            }
            
            Toast.sharedInstance.textOnlyToast("Wi-Fi connected to \(wifiName!)", position: "bottom")
            
            let when1 = DispatchTime.now() + 4 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when1) {
                // Your code with delay
                let reportVC = self.storyboard?.instantiateViewController(withIdentifier: "reportVC") as! ReportViewController
                self.navigationController?.pushViewController(reportVC, animated: true)
                
            }
            
        }
        else
        {
             wifiTestresult = "0"
            resultLabel.text = "Please check with your Wi-Fi settings"
            self.EndTaskBtn.isHidden = false
            
            print("Internet Connection not Available!")

            
            }
            print("Internet Connection not Available!")
        

    }

    @IBAction func EndTask(_ sender: Any)
    {
        wifiTestresult = "0"
        let when = DispatchTime.now()  // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            // Your code with delay
            let reportVC = self.storyboard?.instantiateViewController(withIdentifier: "reportVC") as! ReportViewController
            self.navigationController?.pushViewController(reportVC, animated: true)
        }
        
    }
    
    //# MARK: - GPS
    func gpsBtnAction() -> Void {
      
        self.loadFillCircle()
        let when1 = DispatchTime.now() + 4
        // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when1) {
            
            self.annimateView()
            self.loadSEcondVC()
            
        }

        // gpResult.text = "GPS Finding Location"
        
       locationManager.startUpdatingLocation()
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
                print("No access")
//                gpstestResult = "0"
//                self.loadFillCircle()
//                
//                let when = DispatchTime.now() + 3 // change 2 to desired number of seconds
//                DispatchQueue.main.asyncAfter(deadline: when) {
//                    
//                    self.resultLabel.text = "Failed to get location"
//                    
//                    
//                }
//                let when1 = DispatchTime.now() + 4  // change 2 to desired number of seconds
//                DispatchQueue.main.asyncAfter(deadline: when1) {
//                    // Your code with delay
//                    //self.resultLabel.text = "Location detected: \(locValue.latitude) \(locValue.longitude)"
//                    self.annimateView()
//                    self.loadSEcondVC()
//                    
//                }
                
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
               //  self.resultLabel.text = "Auto-test in progress. Ensure the device GPS feature is on."
                locationManager.startUpdatingLocation()
            }
        } else {
            print("Location services are not enabled")
            self.gpsBtn.setBackgroundImage(UIImage.init(named: "failgps"), for: .normal)
             self.resultLabel.text = "GPS test failed. Turn-on GPS on the device"
        }
    }
     func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: " + error.localizedDescription)
                        gpstestResult = "0"
                        self.loadFillCircle()
        
                        let when = DispatchTime.now() + 3
        // change 2 to desired number of seconds
                        DispatchQueue.main.asyncAfter(deadline: when) {
                            self.gpsBtn.setBackgroundImage(UIImage.init(named: "failgps"), for: .normal)
                            self.resultLabel.text = "Failed to get location"
        
                        }
                        let when1 = DispatchTime.now() + 4
        // change 2 to desired number of seconds
                        DispatchQueue.main.asyncAfter(deadline: when1) {
                           
                            self.annimateView()
                            self.loadSEcondVC()
                            
                        }
    }
    func  locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
               manager.stopUpdatingLocation()
        locationManager.stopUpdatingLocation()
        manager.delegate = nil
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        //gpResult.text = "locations = \(locValue.latitude) \(locValue.longitude)"
        
        if(locValue.latitude != 0 && locValue.longitude != 0){
        
             gpstestResult = "1"
           
            print("GPS Test Successful")
            self.loadFillCircle()
            
            let when = DispatchTime.now() + 3 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.resultLabel.text = "GPS test successful."
               //succgps
               self.gpsBtn.setBackgroundImage(UIImage.init(named: "succgps"), for: .normal)
                
            }
             self.resultLabel.text = "Your location detected \n \(locValue.latitude) \(locValue.longitude)"
            let when1 = DispatchTime.now() + 4  // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when1) {
                
                self.annimateView()
                self.loadSEcondVC()
                
            }
        }else{
            gpstestResult = "0"
            
            loadFillCircle()
            let when = DispatchTime.now() + 4 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                // Your code with delay
                self.gpsBtn.setBackgroundImage(UIImage.init(named: "failgps"), for: .normal)
                self.resultLabel.text = "Failed to find location."
                self.loadSEcondVC()
                
            }

        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

