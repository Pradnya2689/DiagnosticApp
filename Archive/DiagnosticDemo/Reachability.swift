//
//  Reachability.swift
//  Diagnostic
//
//  Created by Administrator on 09/03/17.
//  Copyright © 2017 IngramMicro. All rights reserved.
//

import Foundation
import SystemConfiguration
import SystemConfiguration.CaptiveNetwork

public class Reachability {
    
    class func isConnectedToNetwork() -> Bool {
        
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        // Only Working for WIFI
         let isReachable = flags == .reachable
         let needsConnection = flags == .connectionRequired
         
         return isReachable && !needsConnection
        
        // Working for Cellular and WIFI
//        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
//        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
//        let ret = (isReachable && !needsConnection)
//        
//        return ret
        
        
        
        
    }

        class func fetchSSIDInfo() ->  String {
            var  currentSSID = ""
            if let interfaces:CFArray? = CNCopySupportedInterfaces() {
                for i in 0..<CFArrayGetCount(interfaces){
                    let interfaceName: UnsafeRawPointer = CFArrayGetValueAtIndex(interfaces, i)
                    let rec = unsafeBitCast(interfaceName, to: AnyObject.self)
                    let unsafeInterfaceData = CNCopyCurrentNetworkInfo("\(rec)" as CFString)
                    if unsafeInterfaceData != nil {
                        let interfaceData = unsafeInterfaceData as! Dictionary <String,AnyObject>
                      currentSSID = interfaceData["SSID"] as! String
                    }
                }
            }
            return currentSSID
        }
  

        
      class func getSSID() -> String? {
            
            let interfaces = CNCopySupportedInterfaces()
            if interfaces == nil {
                return nil
            }
            
            let interfacesArray = interfaces as! [String]
            if interfacesArray.count <= 0 {
                return nil
            }
            
            let interfaceName = interfacesArray[0] as String
            let unsafeInterfaceData =     CNCopyCurrentNetworkInfo(interfaceName as CFString)
            if unsafeInterfaceData == nil {
                return nil
            }
            
            let interfaceData = unsafeInterfaceData as! Dictionary <String,AnyObject>
            
            return interfaceData["SSID"] as? String
        }
    
    
}
