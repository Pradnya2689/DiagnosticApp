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

let screenSize: CGRect = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height

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
    
    
    var audioPlayer = AVAudioPlayer()
    var audioRecorder: AVAudioRecorder?
    var volumelvl1 = Float()
    
    var xcoord : Double!
    var ycoord : Double!
    var locationManager = CLLocationManager()

  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
        
       
        
        (MPVolumeView().subviews.filter{NSStringFromClass($0.classForCoder) == "MPVolumeSlider"}.first as? UISlider)?.setValue(0.5, animated: false)

         volumelvl1 = MPMusicPlayerController.applicationMusicPlayer().value(forKey: "volume") as! Float
        do{
            var audioSession =  AVAudioSession()
            try audioSession.setActive(true)
            audioSession.addObserver(self, forKeyPath: "outputVolume", options: NSKeyValueObservingOptions.new, context: nil)
        }catch{
            print("could not start reachability notifier")
        }
        
       self.proximityDetector()
        self.wifi()
        self.gpsBtnAction()
        
//        self.fillCircle {
//           self.annimateView()
//        }
      
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
    
     //# MARK: - Volume Detect
    @IBAction func volumedetect(sender: AnyObject) {
        
        NotificationCenter.default.addObserver(self, selector: "volumeChanged:", name: NSNotification.Name(rawValue: "AVSystemController_SystemVolumeDidChangeNotification"), object: nil)
        // Option #2
        
        do{
            var audioSession =  AVAudioSession()
            try audioSession.setActive(true)
            audioSession.addObserver(self, forKeyPath: "outputVolume", options: NSKeyValueObservingOptions.new, context: nil)
        }catch{
            print("could not start reachability notifier")
        }
        
        //        audioSession.setActive(true, error: nil)
        
        
        
    }
    
    func volumeChanged(notification: NSNotification){
        print("got in here")
    }

//    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutableRawPointer) {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "outputVolume"{
            print("got in here")
            // float volumeLevel = [[MPMusicPlayerController applicationMusicPlayer] volume]
            let volumelvl = MPMusicPlayerController.applicationMusicPlayer().value(forKey: "volume") as! Float
            
            
            if (volumelvl > volumelvl1)
            {
                print("up");
                //self.Vup.backgroundColor = UIColor.greenColor()
                volumelvl1 = volumelvl
            }
                
            else
            {
               // self.Vdown.backgroundColor = UIColor.greenColor()
                volumelvl1 = volumelvl
                print("down");
            }
            
            
            
        }
    }

    //# MARK: - Proximity
    func proximityDetector() -> Void {
        
        let device = UIDevice.current
        device.isProximityMonitoringEnabled = true
        if device.isProximityMonitoringEnabled {
            NotificationCenter.default.addObserver(self, selector: #selector(proximityChanged(notification:)), name: NSNotification.Name(rawValue: "UIDeviceProximityStateDidChangeNotification"), object: device)
        }

    }

    func proximityChanged(notification: NSNotification) {
        if let device = notification.object as? UIDevice {
            print("\(device) detected!")
        }
    }

    //# MARK: - Wifi
    
   // @IBAction func wifiBtnAction(_ sender: Any) {
    func wifi() -> Void {
        
   
        
        if Reachability.isConnectedToNetwork() == true
        {
            print("Internet Connection Available!")
//            gpResult.text = "Internet Connection Available!"
//            result.text = "Wifi Test Successful"
            
            let wifiName = Reachability.getSSID()
            let wifiName1 = Reachability.fetchSSIDInfo()
            
            //            let wifiName1 = Reachability.getUsedSSID(Reachability)
            
            
            guard wifiName != nil else {
                
                //// TODO: Alert -----
                print("no wifi name")
                
                return
            }
            
            
            print("my network name is: \(wifiName!)")
            Toast.sharedInstance.textOnlyToast("Wifi connected to \(wifiName!)", position: "bottom")
            
        }
        else
        {
            print("Internet Connection not Available!")
//            gpResult.text = "Internet Connection not Available!"
//            result.text = "Please Enable your wifi"
            
        }
    }
  
    //# MARK: - GPS
     func gpsBtnAction() -> Void {
        
       // gpResult.text = "GPS Finding Location"
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    func  locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        //gpResult.text = "locations = \(locValue.latitude) \(locValue.longitude)"
        
        if(locValue.latitude != 0 && locValue.longitude != 0){
           // result.text = "GPS Test Successful"
             print("GPS Test Successful")
        }
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

