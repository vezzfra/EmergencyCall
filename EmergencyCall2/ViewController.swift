//
//  ViewController.swift
//  EmergencyCall2
//
//  Created by Francesco on 05/03/15.
//  Copyright (c) 2015 Francesco Vezzoli. All rights reserved.
//

import UIKit
import iAd
import CoreLocation
import SystemConfiguration

class ViewController: UIViewController, ADBannerViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var copyright: UILabel!
    @IBOutlet var adBannerView: ADBannerView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var select: UIButton!
    
    let locationManager = CLLocationManager()

    public class Reachability {
        /**
        * Check if internet connection is available
        */
        class func isConnectedToNetwork() -> Bool {
            var status:Bool = false
            
            let url = NSURL(string: "http://google.com")
            let request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "HEAD"
            request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
            request.timeoutInterval = 10.0
            
            var response:NSURLResponse?
            
            var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: nil) as NSData?
            
            if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    status = true
                }
            }
            
            return status
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        infoLabel.hidden = true
        select.hidden = true
        
        self.canDisplayBannerAds = true
        self.adBannerView?.delegate = self
        self.adBannerView?.hidden = true
        
        if Reachability.isConnectedToNetwork() {
            
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.startUpdatingLocation()
        
            
        } else {
            
            select.hidden = false
            
            let language = NSBundle.mainBundle().preferredLocalizations.first as! String
            
            if (language == "it") {
                
                let string = NSUserDefaults.standardUserDefaults().objectForKey("newLocation") as! NSString
                    
                infoLabel.text = "Ti trovi in: " + (string as String)
                infoLabel.hidden = false
                    
        
            }
            
            if (language == "en") {
                
                
                let string = NSUserDefaults.standardUserDefaults().objectForKey("newLocation") as! NSString
                    
                infoLabel.text = "You are in: " + (string as String)
                infoLabel.hidden = false
            
            
        }
        }
        
        
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: { (placemarks, error) -> Void in
            
            
            if (error != nil) {
                
                println("Error:" + error.localizedDescription)
                
                return
            }
            
            if placemarks.count > 0 {
                
                
                
                let pm = placemarks[0] as! CLPlacemark
                
                self.displayLocationInfo(pm)
                
                
                
            }else {
                
                println("Error with data")
                
            }
            
            
            
            
            
        })
        
        
        
    }
    
    func displayLocationInfo(placemark: CLPlacemark) {
        
        self.locationManager.stopUpdatingLocation()

        println(placemark.country)
        
        let language = NSBundle.mainBundle().preferredLocalizations.first as! String
        
        if (language == "it") {
            
            infoLabel.text = "Ti trovi in: " + placemark.country
            infoLabel.hidden = false
            
        }
        
        if (language == "en") {
     
                infoLabel.text = "You are in: " + placemark.country
                infoLabel.hidden = false
 
        }
        
        
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        
        println("Error: " + error.localizedDescription)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

    
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        
        self.adBannerView?.hidden = false
        
    }

    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        
        println("Error: \(error.description)")
    
    }
    


}

