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
            label.frame = CGRect(x: (screenWidth-200)/2,y: screenHeight-50, width: 200, height: sizeoftxt.height+20)
        }else if(position == "center"){
            label.frame = CGRect(x: (screenWidth-200)/2,y: (screenHeight-sizeoftxt.height)/2, width: 200, height: sizeoftxt.height+20)
        }else{
            label.frame = CGRect(x: (screenWidth-200)/2,y: 120, width: 200, height: sizeoftxt.height+20)
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.title = ""
        self.EndTaskBtn.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
        //        self.buttonVc.translatesAutoresizingMaskIntoConstraints = true
        //        self.buttonVc.frame = CGRect(x: ((screenWidth/2)-25), y: 0, width: 603, height: 128);
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        
        self.title = "Quality Check"
        loadEmptyCircle()
        self.resultLabel.text = "GPS Test is in progress..Ensure that device's GPS feature is ON."
        
        
        //        NotificationCenter.default.addObserver(
        //            self,
        //            selector: #selector(ViewController.reachabilityStatusChanged(_:)),
        //            name: NSNotification.Name.reachabilityChanged,
        //            object: nil)
        
        gpstestResult = "0"
        proximityTestresult = "0"
        volumeTest = "0"
        wifiTestresult = "0"
        self.volumeflagup = "0"
        self.volumeflagdwn = "0"
       // self.gpsBtn.setImage("gpsSel", for: .normal)
        self.gpsBtn.setImage(UIImage.init(named: "gps"), for: .normal)
        self.proximityBtn.setImage(UIImage.init(named: "proxDis"), for: .normal)
        self.volumeBtn.setImage(UIImage.init(named: "volumeDis"), for: .normal)
        self.wifiBtn.setImage(UIImage.init(named: "wifiDis"), for: .normal)
        
//        self.proximityBtn.backgroundColor = UIColor.lightGray
//        self.volumeBtn.backgroundColor = UIColor.lightGray
//        self.wifiBtn.backgroundColor = UIColor.lightGray
        
        let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            // Your code with delay
            
            self.gpsBtnAction()
        }
        
    
        self.TestImage.image = UIImage(named: "gps")
    }
    
    func reachabilityStatusChanged(_ sender: NSNotification)
    {
//        guard let networkStatus = (sender.object as? Reachability)?.currentReachabilityStatus() else { return }
//        updateInterfaceWithCurrent(networkStatus: networkStatus)
    }
        //volume button test
    func loadSEcondVC(){
        
        let gifManager = SwiftyGifManager(memoryLimit:50)
        // let gif = UIImage(gifName: "motion_gesture_aircall6.gif")
        let gifImage = UIImage(gifName: "motion_gesture_aircall6.gif")
        self.gifImg.setGifImage(gifImage, manager: gifManager, loopCount: 20)
        self.gifImg.isHidden = false
        self.TestImage.isHidden = true
        self.resultLabel.text = "Hover your hand on device."
       // self.TestImage.setGifImage(gifImage, manager: gifManager, loopCount: 20)
//        self.gpsBtn.backgroundColor = UIColor.green
//        self.proximityBtn.backgroundColor = UIColor.blue
        self.gpsBtn.setImage(UIImage.init(named: "gpsSel"), for: .normal)
        self.proximityBtn.setImage(UIImage.init(named: "proximity"), for: .normal)
        self.volumeBtn.setImage(UIImage.init(named: "volumeDis"), for: .normal)
        self.wifiBtn.setImage(UIImage.init(named: "wifiDis"), for: .normal)
       
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
        
         (MPVolumeView().subviews.filter{NSStringFromClass($0.classForCoder) == "MPVolumeSlider"}.first as? UISlider)?.setValue(0.5, animated: false)
        self.resultLabel.text = "Press Volume Up and Volume Down Buttons of your phone."
      
        self.gifImg.isHidden = true
        self.TestImage.isHidden = false
        self.TestImage.image = nil
        self.TestImage.gifImage = nil
        self.TestImage.image = UIImage(named: "volume")
//        self.volumeBtn.backgroundColor = UIColor.blue
//        self.proximityBtn.backgroundColor = UIColor.green
        //self.TestImage.image = UIImage.init(named: "volume")
        self.gpsBtn.setImage(UIImage.init(named: "gpsSel"), for: .normal)
        self.proximityBtn.setImage(UIImage.init(named: "proxSel"), for: .normal)
        self.volumeBtn.setImage(UIImage.init(named: "volume"), for: .normal)
        self.wifiBtn.setImage(UIImage.init(named: "wifiDis"), for: .normal)
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
        
       
        self.resultLabel.text = "Wifi Test is in Progress..Ensure that your device's wifi is enabled."
        self.TestImage.image = UIImage(named: "wifi")
//        self.volumeBtn.backgroundColor = UIColor.green
//        self.wifiBtn.backgroundColor = UIColor.blue
        self.gpsBtn.setImage(UIImage.init(named: "gpsSel"), for: .normal)
        self.proximityBtn.setImage(UIImage.init(named: "proxSel"), for: .normal)
        self.volumeBtn.setImage(UIImage.init(named: "volumeSel"), for: .normal)
        self.wifiBtn.setImage(UIImage.init(named: "wifi"), for: .normal)
        
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
        progressCircle1.strokeColor = UIColor.lightGray.cgColor
        progressCircle1.fillColor = UIColor.clear.cgColor
        progressCircle1.lineWidth = 8.0
        
        circle.layer.addSublayer(progressCircle1)
    }
    
    // load animation circle
    func loadFillCircle(){
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
        
        
        self.volumeflagup = "0"
        self.volumeflagdwn = "0"
//        NotificationCenter.default.addObserver(self, selector: "volumeChanged:", name: NSNotification.Name(rawValue: "AVSystemController_SystemVolumeDidChangeNotification"), object: nil)
//        // Option #2
//        
//        do{
//            var audioSession =  AVAudioSession()
//            try audioSession.setActive(true)
//            audioSession.addObserver(self, forKeyPath: "outputVolume", options: NSKeyValueObservingOptions.new, context: nil)
//        }catch{
//            print("could not start reachability notifier")
//        }
//        
//        //        audioSession.setActive(true, error: nil)
        
        
       
        
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
            let volumelvl = MPMusicPlayerController.applicationMusicPlayer().value(forKey: "volume") as! Float
            
            
            if (volumelvl > volumelvl1)
            {
                print("up");
                self.volumeflagup = "1"
                //self.Vup.backgroundColor = UIColor.greenColor()
                volumelvl1 = volumelvl
            }
                
             if (volumelvl < volumelvl1)
            {
               
                // self.Vdown.backgroundColor = UIColor.greenColor()
                volumelvl1 = volumelvl
                print("down");
                self.volumeflagdwn = "1"
               // resultLabel.text = "Volume Button Test Completed."
                
                
            }
            
            
            
            if (self.volumeflagup == "1" && self.volumeflagdwn == "1")
            {
            
                do{
                    
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
                        
                        self.resultLabel.text = "Volume Button Test Completed."
                        
                        
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
        
      //device = UIDevice.current
        device.isProximityMonitoringEnabled = true
        if device.isProximityMonitoringEnabled {
            NotificationCenter.default.addObserver(self, selector: #selector(proximityChanged(notification:)), name: NSNotification.Name(rawValue: "UIDeviceProximityStateDidChangeNotification"), object: device)
        }
        if device.isProximityMonitoringEnabled == false{
            proximityTestresult = "0"
        }
    }
    
    func proximityChanged(notification: NSNotification) {

        device.isProximityMonitoringEnabled = false
        if let device = notification.object as? UIDevice {
            print("\(device) detected!")
            proximityTestresult = "1"
            self.resultLabel.text = "Proximity Sensors Test In Progress."
            self.loadFillCircle()
            
            
            let when = DispatchTime.now() + 3 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                
                self.resultLabel.text = "Proximity Sensors Test Completed."
                
                
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
        
       
       
        if (Reachability2.isConnectedToNetwork())
        {
            print("Internet Connection Available!")
          
            
            let wifiName = Reachability2.getSSID()
             let wifiName1 = Reachability2.fetchSSIDInfo()
            
            guard wifiName != nil else {
                
                print("no wifi name")
                
                return
            }
        
            print("my network name is: \(wifiName!)")
            //wifiTestresult = "1"
            
              self.loadFillCircle()
            let when = DispatchTime.now() + 3 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                wifiTestresult = "1"
               self.resultLabel.text = "Wi-Fi Test Completed."
                
                
            }
            
            Toast.sharedInstance.textOnlyToast("Wifi connected to \(wifiName!)", position: "bottom")
            
            let when1 = DispatchTime.now() + 4 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when1) {
                // Your code with delay
                let reportVC = self.storyboard?.instantiateViewController(withIdentifier: "reportVC") as! ReportViewController
                self.navigationController?.pushViewController(reportVC, animated: true)
                
            }
            
        }
        else
        {
            resultLabel.text = "Please check with your wifi settings"
             self.EndTaskBtn.isHidden = false
            wifiTestresult = "0"
            print("Internet Connection not Available!")

            NotificationCenter.default.addObserver(self, selector:  #selector(ViewController.reachabilityChanged(_:)),name: ReachabilityChangedNotification,object: reachability)
            do{
                try reachability.startNotifier()
            }catch{
                print("could not start reachability notifier")
            }
            
        }
    }
    func reachabilityChanged(_ sender: NSNotification) {
        
        let reachability = sender.object as! Reachability
   
        if (Reachability2.isConnectedToNetwork())
        {
            print("Internet Connection Available!")
          
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
                
                
            }
            
            Toast.sharedInstance.textOnlyToast("Wifi connected to \(wifiName!)", position: "bottom")
            
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
            resultLabel.text = "Please check with your wifi settings"
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
                locationManager.startUpdatingLocation()
            }
        } else {
            print("Location services are not enabled")
        }
    }
     func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: " + error.localizedDescription)
                        gpstestResult = "0"
                        self.loadFillCircle()
        
                        let when = DispatchTime.now() + 3
        // change 2 to desired number of seconds
                        DispatchQueue.main.asyncAfter(deadline: when) {
        
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
                
                self.resultLabel.text = "Location detected: \n \(locValue.latitude) \(locValue.longitude)"
                
                
            }
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

