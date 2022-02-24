//
//  TodayViewController.swift
//  TodayWidget
//
//  Created by Francesco on 05/03/15.
//  Copyright (c) 2015 Francesco Vezzoli. All rights reserved.
//

import UIKit
import NotificationCenter
import CoreLocation
import SystemConfiguration

class TodayViewController: UIViewController, NCWidgetProviding, CLLocationManagerDelegate {
    
    var cont1true = Bool()
    var cont2true = Bool()
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var police: UIButton!
    @IBOutlet weak var ambulance: UIButton!
    @IBOutlet weak var firetruck: UIButton!
    @IBOutlet weak var carabinieri: UIButton!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var donne: UIButton!
    @IBOutlet weak var bimbi: UIButton!
    @IBOutlet weak var policeLabel: UILabel!
    @IBOutlet weak var ambulanceLabel: UILabel!
    @IBOutlet weak var firetruckLabel: UILabel!
    @IBOutlet weak var carabinieriLabel: UILabel!
    @IBOutlet weak var donneLabel: UILabel!
    @IBOutlet weak var bimbiLabel: UILabel!
    @IBOutlet weak var police911: UIButton!
    @IBOutlet weak var ambulance911: UIButton!
    @IBOutlet weak var fire911: UIButton!
    @IBOutlet weak var label911: UILabel!
    @IBOutlet weak var checkLabel: UILabel!
    
    @IBOutlet weak var string1: NSString!
    @IBOutlet weak var loadingLabel: UILabel!
    
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
        
        self.preferredContentSize = CGSizeMake(0, 120)
        
        checkLabel.hidden = true
        
        
        if Reachability.isConnectedToNetwork() {
            
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.startUpdatingLocation()
            
            let language = NSBundle.mainBundle().preferredLocalizations.first as! NSString
            
            if (language == "it") {
                
                loadingLabel.text = "Trovo la posizione..."
                
            } else {
                
                loadingLabel.text = "Finding your location..."
                
            }
            
            
        } else {
            
            let language = NSBundle.mainBundle().preferredLocalizations.first as! NSString
            
            if (language == "it") {
                
                loadingLabel.text = "Impossibile determinare la posizione! Selezionane una manualmente dall'App."
                
            } else {
                
                loadingLabel.text = "Unable to find your location! Please select one manually from the App."
                
            }
            
            self.displayLocation()
            
        }

        police.hidden = true
        policeLabel.hidden = true
        ambulance.hidden = true
        ambulanceLabel.hidden = true
        firetruck.hidden = true
        firetruckLabel.hidden = true
        donne.hidden = true
        donneLabel.hidden = true
        bimbi.hidden = true
        bimbiLabel.hidden = true
        carabinieri.hidden = true
        carabinieriLabel.hidden = true
        
        police911.hidden = true
        ambulance911.hidden = true
        fire911.hidden = true
        label911.hidden = true
        loadingLabel.hidden = false
        
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
    
    func displayLocation() {
        
        let sharedDefaults = NSUserDefaults(suiteName: "group.francesco.emergencyTodayWidget")
        let string = sharedDefaults?.valueForKey("selectedLocation")
        
        checkLabel.text = string as? String
        
        println(string as? String)
        
        if ((string as? String) == "Italia") {
            
            
            loadingLabel.hidden = true
            
            police.hidden = false
            policeLabel.hidden = false
            ambulance.hidden = false
            ambulanceLabel.hidden = false
            firetruck.hidden = false
            firetruckLabel.hidden = false
            donne.hidden = false
            donneLabel.hidden = false
            bimbi.hidden = false
            bimbiLabel.hidden = false
            carabinieri.hidden = false
            carabinieriLabel.hidden = false
            
            police911.hidden = true
            ambulance911.hidden = true
            fire911.hidden = true
            label911.hidden = true
            
            
            
        }
        
        if ((string as? String) == "Italy") {
            
            loadingLabel.hidden = true
            
            
        }
        
        if ((string as? String) == "Svizzera") {
            
            self.preferredContentSize = CGSizeMake(0, 60)
            
            loadingLabel.hidden = true
            police.hidden = false
            policeLabel.hidden = false
            ambulance.hidden = false
            ambulanceLabel.hidden = false
            firetruck.hidden = false
            firetruckLabel.hidden = false
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = true
            ambulance911.hidden = true
            fire911.hidden = true
            label911.hidden = true
            
            policeLabel.text = "117"
            ambulanceLabel.text = "144"
            firetruckLabel.text = "118"
            
        }
        
        if ((string as? String) == "Croazia") {
            
            self.preferredContentSize = CGSizeMake(0, 60)
            
            loadingLabel.hidden = true
            police.hidden = false
            policeLabel.hidden = false
            ambulance.hidden = false
            ambulanceLabel.hidden = false
            firetruck.hidden = false
            firetruckLabel.hidden = false
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = true
            ambulance911.hidden = true
            fire911.hidden = true
            label911.hidden = true
            
            policeLabel.text = "192"
            ambulanceLabel.text = "112"
            firetruckLabel.text = "193"
            
        }
        
        if ((string as? String) == "Croatia") {
            
            self.preferredContentSize = CGSizeMake(0, 60)
            
            loadingLabel.hidden = true
            police.hidden = false
            policeLabel.hidden = false
            ambulance.hidden = false
            ambulanceLabel.hidden = false
            firetruck.hidden = false
            firetruckLabel.hidden = false
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = true
            ambulance911.hidden = true
            fire911.hidden = true
            label911.hidden = true
            
            policeLabel.text = "192"
            ambulanceLabel.text = "112"
            firetruckLabel.text = "193"
            
        }
        
        if ((string as? String) == "Egitto") {
            
            self.preferredContentSize = CGSizeMake(0, 60)
            
            loadingLabel.hidden = true
            police.hidden = false
            policeLabel.hidden = false
            ambulance.hidden = false
            ambulanceLabel.hidden = false
            firetruck.hidden = false
            firetruckLabel.hidden = false
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = true
            ambulance911.hidden = true
            fire911.hidden = true
            label911.hidden = true
            
            policeLabel.text = "122"
            ambulanceLabel.text = "123"
            firetruckLabel.text = "125"
            
        }
        
        if ((string as? String) == "Egypt") {
            
            self.preferredContentSize = CGSizeMake(0, 60)
            
            loadingLabel.hidden = true
            police.hidden = false
            policeLabel.hidden = false
            ambulance.hidden = false
            ambulanceLabel.hidden = false
            firetruck.hidden = false
            firetruckLabel.hidden = false
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = true
            ambulance911.hidden = true
            fire911.hidden = true
            label911.hidden = true
            
            policeLabel.text = "122"
            ambulanceLabel.text = "123"
            firetruckLabel.text = "125"
            
        }
        
        if ((string as? String) == "Albania") {
            
            self.preferredContentSize = CGSizeMake(0, 60)
            
            loadingLabel.hidden = true
            police.hidden = false
            policeLabel.hidden = false
            ambulance.hidden = false
            ambulanceLabel.hidden = false
            firetruck.hidden = false
            firetruckLabel.hidden = false
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = true
            ambulance911.hidden = true
            fire911.hidden = true
            label911.hidden = true
            
            policeLabel.text = "126"
            ambulanceLabel.text = "127"
            firetruckLabel.text = "129"
            
        }
        
        if ((string as? String) == "Austria") {
            
            self.preferredContentSize = CGSizeMake(0, 60)
            
            loadingLabel.hidden = true
            police.hidden = false
            policeLabel.hidden = false
            ambulance.hidden = false
            ambulanceLabel.hidden = false
            firetruck.hidden = false
            firetruckLabel.hidden = false
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = true
            ambulance911.hidden = true
            fire911.hidden = true
            label911.hidden = true
            
            policeLabel.text = "133"
            ambulanceLabel.text = "144"
            firetruckLabel.text = "122"
            
        }
        
        if ((string as? String) == "Andorra") {
            
            loadingLabel.hidden = true
            police.hidden = true
            policeLabel.hidden = true
            ambulance.hidden = true
            ambulanceLabel.hidden = true
            firetruck.hidden = true
            firetruckLabel.hidden = true
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = false
            ambulance911.hidden = false
            fire911.hidden = false
            label911.hidden = false
            
            label911.text = "860366"
            
        }
        
        if ((string as? String) == "Switzerland") {
            
            self.preferredContentSize = CGSizeMake(0, 60)
            
            loadingLabel.hidden = true
            police.hidden = false
            policeLabel.hidden = false
            ambulance.hidden = false
            ambulanceLabel.hidden = false
            firetruck.hidden = false
            firetruckLabel.hidden = false
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = true
            ambulance911.hidden = true
            fire911.hidden = true
            label911.hidden = true
            
            policeLabel.text = "117"
            ambulanceLabel.text = "144"
            firetruckLabel.text = "118"
            
        }
        
        if ((string as? String) == "Arabia Saudita") {
            
            self.preferredContentSize = CGSizeMake(0, 60)
            
            loadingLabel.hidden = true
            police.hidden = false
            policeLabel.hidden = false
            ambulance.hidden = false
            ambulanceLabel.hidden = false
            firetruck.hidden = false
            firetruckLabel.hidden = false
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = true
            ambulance911.hidden = true
            fire911.hidden = true
            label911.hidden = true
            
            policeLabel.text = "999"
            ambulanceLabel.text = "997"
            firetruckLabel.text = "998"
            
        }
        
        if ((string as? String) == "Saudi Arabia") {
            
            self.preferredContentSize = CGSizeMake(0, 60)
            
            loadingLabel.hidden = true
            police.hidden = false
            policeLabel.hidden = false
            ambulance.hidden = false
            ambulanceLabel.hidden = false
            firetruck.hidden = false
            firetruckLabel.hidden = false
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = true
            ambulance911.hidden = true
            fire911.hidden = true
            label911.hidden = true
            
            policeLabel.text = "999"
            ambulanceLabel.text = "997"
            firetruckLabel.text = "998"
            
        }
        
        if ((string as? String) == "Barbados") {
            
            self.preferredContentSize = CGSizeMake(0, 60)
            
            loadingLabel.hidden = true
            police.hidden = false
            policeLabel.hidden = false
            ambulance.hidden = false
            ambulanceLabel.hidden = false
            firetruck.hidden = false
            firetruckLabel.hidden = false
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = true
            ambulance911.hidden = true
            fire911.hidden = true
            label911.hidden = true
            
            policeLabel.text = "211"
            ambulanceLabel.text = "51"
            firetruckLabel.text = "311"
            
        }
        
        
        if ((string as? String) == "Belgio") {
            
            self.preferredContentSize = CGSizeMake(0, 60)
            
            loadingLabel.hidden = true
            police.hidden = false
            policeLabel.hidden = false
            ambulance.hidden = false
            ambulanceLabel.hidden = false
            firetruck.hidden = false
            firetruckLabel.hidden = false
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = true
            ambulance911.hidden = true
            fire911.hidden = true
            label911.hidden = true
            
            policeLabel.text = "101"
            ambulanceLabel.text = "100"
            firetruckLabel.text = "112"
            
        }
        
        if ((string as? String) == "Belgium") {
            
            self.preferredContentSize = CGSizeMake(0, 60)
            
            loadingLabel.hidden = true
            police.hidden = false
            policeLabel.hidden = false
            ambulance.hidden = false
            ambulanceLabel.hidden = false
            firetruck.hidden = false
            firetruckLabel.hidden = false
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = true
            ambulance911.hidden = true
            fire911.hidden = true
            label911.hidden = true
            
            policeLabel.text = "101"
            ambulanceLabel.text = "100"
            firetruckLabel.text = "112"
            
        }
        
        if ((string as? String) == "Angola") {
            
            self.preferredContentSize = CGSizeMake(0, 60)
            
            loadingLabel.hidden = true
            police.hidden = false
            policeLabel.hidden = false
            ambulance.hidden = false
            ambulanceLabel.hidden = false
            firetruck.hidden = false
            firetruckLabel.hidden = false
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = true
            ambulance911.hidden = true
            fire911.hidden = true
            label911.hidden = true
            
            policeLabel.text = "113"
            ambulanceLabel.text = "116"
            firetruckLabel.text = "115"
            
        }
        
        if ((string as? String) == "United States") {
            
            self.preferredContentSize = CGSizeMake(0, 120)
            
            loadingLabel.hidden = true
            police.hidden = true
            policeLabel.hidden = true
            ambulance.hidden = true
            ambulanceLabel.hidden = true
            firetruck.hidden = true
            firetruckLabel.hidden = true
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = false
            ambulance911.hidden = false
            fire911.hidden = false
            label911.hidden = false
            
            label911.text = "911"
            
        }
        
        if ((string as? String) == "Stati Uniti") {
            
            self.preferredContentSize = CGSizeMake(0, 120)
            
            loadingLabel.hidden = true
            police.hidden = true
            policeLabel.hidden = true
            ambulance.hidden = true
            ambulanceLabel.hidden = true
            firetruck.hidden = true
            firetruckLabel.hidden = true
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = false
            ambulance911.hidden = false
            fire911.hidden = false
            label911.hidden = false
            
            label911.text = "911"
            
        }
        
        if ((string as? String) == "Uruguay") {
            
            self.preferredContentSize = CGSizeMake(0, 120)
            
            loadingLabel.hidden = true
            police.hidden = true
            policeLabel.hidden = true
            ambulance.hidden = true
            ambulanceLabel.hidden = true
            firetruck.hidden = true
            firetruckLabel.hidden = true
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = false
            ambulance911.hidden = false
            fire911.hidden = false
            label911.hidden = false
            
            label911.text = "911"
            
        }
        
        if ((string as? String) == "Canada") {
            
            self.preferredContentSize = CGSizeMake(0, 120)
            
            loadingLabel.hidden = true
            police.hidden = true
            policeLabel.hidden = true
            ambulance.hidden = true
            ambulanceLabel.hidden = true
            firetruck.hidden = true
            firetruckLabel.hidden = true
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = false
            ambulance911.hidden = false
            fire911.hidden = false
            label911.hidden = false
            
            label911.text = "911"
            
        }
        
        
        if ((string as? String) == "Germany") {
            
            self.preferredContentSize = CGSizeMake(0, 60)
            
            loadingLabel.hidden = true
            police.hidden = false
            policeLabel.hidden = false
            ambulance.hidden = false
            ambulanceLabel.hidden = false
            firetruck.hidden = false
            firetruckLabel.hidden = false
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = true
            ambulance911.hidden = true
            fire911.hidden = true
            label911.hidden = true
            
            policeLabel.text = "110"
            ambulanceLabel.text = "112"
            firetruckLabel.text = "112"
            
        }
        
        if ((string as? String) == "Germania") {
            
            self.preferredContentSize = CGSizeMake(0, 60)
            
            loadingLabel.hidden = true
            police.hidden = false
            policeLabel.hidden = false
            ambulance.hidden = false
            ambulanceLabel.hidden = false
            firetruck.hidden = false
            firetruckLabel.hidden = false
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = true
            ambulance911.hidden = true
            fire911.hidden = true
            label911.hidden = true
            
            policeLabel.text = "110"
            ambulanceLabel.text = "112"
            firetruckLabel.text = "112"
            
        }

    }
    
    func displayLocationInfo(placemark: CLPlacemark) {
        
        checkLabel.text = placemark.country
       
        self.locationManager.stopUpdatingLocation()
        
        println(placemark.country)
        
        
        if (checkLabel.text == "Italia") {
            
            self.preferredContentSize = CGSizeMake(0, 120)
            
            loadingLabel.hidden = true
            police.hidden = false
            policeLabel.hidden = false
            ambulance.hidden = false
            ambulanceLabel.hidden = false
            firetruck.hidden = false
            firetruckLabel.hidden = false
            donne.hidden = false
            donneLabel.hidden = false
            bimbi.hidden = false
            bimbiLabel.hidden = false
            carabinieri.hidden = false
            carabinieriLabel.hidden = false
            
            police911.hidden = true
            ambulance911.hidden = true
            fire911.hidden = true
            label911.hidden = true
            
            
            
        }
        
        if (checkLabel.text == "Italy") {
            
            self.preferredContentSize = CGSizeMake(0, 120)
            
            loadingLabel.hidden = true
            police.hidden = false
            policeLabel.hidden = false
            ambulance.hidden = false
            ambulanceLabel.hidden = false
            firetruck.hidden = false
            firetruckLabel.hidden = false
            donne.hidden = false
            donneLabel.hidden = false
            bimbi.hidden = false
            bimbiLabel.hidden = false
            carabinieri.hidden = false
            carabinieriLabel.hidden = false
            
            police911.hidden = true
            ambulance911.hidden = true
            fire911.hidden = true
            label911.hidden = true
            
            
            
        }
        
        if (checkLabel.text == "Svizzera") {
            
            self.preferredContentSize = CGSizeMake(0, 60)
            
            loadingLabel.hidden = true
            police.hidden = false
            policeLabel.hidden = false
            ambulance.hidden = false
            ambulanceLabel.hidden = false
            firetruck.hidden = false
            firetruckLabel.hidden = false
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = true
            ambulance911.hidden = true
            fire911.hidden = true
            label911.hidden = true
            
            policeLabel.text = "117"
            ambulanceLabel.text = "144"
            firetruckLabel.text = "118"
            
        }
        
        if (checkLabel.text == "Croazia") {
            
            self.preferredContentSize = CGSizeMake(0, 60)
            
            loadingLabel.hidden = true
            police.hidden = false
            policeLabel.hidden = false
            ambulance.hidden = false
            ambulanceLabel.hidden = false
            firetruck.hidden = false
            firetruckLabel.hidden = false
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = true
            ambulance911.hidden = true
            fire911.hidden = true
            label911.hidden = true
            
            policeLabel.text = "192"
            ambulanceLabel.text = "112"
            firetruckLabel.text = "193"
            
        }
        
        if (checkLabel.text == "Croatia") {
            
            self.preferredContentSize = CGSizeMake(0, 60)
            
            loadingLabel.hidden = true
            police.hidden = false
            policeLabel.hidden = false
            ambulance.hidden = false
            ambulanceLabel.hidden = false
            firetruck.hidden = false
            firetruckLabel.hidden = false
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = true
            ambulance911.hidden = true
            fire911.hidden = true
            label911.hidden = true
            
            policeLabel.text = "192"
            ambulanceLabel.text = "112"
            firetruckLabel.text = "193"
            
        }
        
        if (checkLabel.text == "Egitto") {
            
            self.preferredContentSize = CGSizeMake(0, 60)
            
            loadingLabel.hidden = true
            police.hidden = false
            policeLabel.hidden = false
            ambulance.hidden = false
            ambulanceLabel.hidden = false
            firetruck.hidden = false
            firetruckLabel.hidden = false
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = true
            ambulance911.hidden = true
            fire911.hidden = true
            label911.hidden = true
            
            policeLabel.text = "122"
            ambulanceLabel.text = "123"
            firetruckLabel.text = "125"
            
        }
        
        if (checkLabel.text == "Egypt") {
            
            self.preferredContentSize = CGSizeMake(0, 60)
            
            loadingLabel.hidden = true
            police.hidden = false
            policeLabel.hidden = false
            ambulance.hidden = false
            ambulanceLabel.hidden = false
            firetruck.hidden = false
            firetruckLabel.hidden = false
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = true
            ambulance911.hidden = true
            fire911.hidden = true
            label911.hidden = true
            
            policeLabel.text = "122"
            ambulanceLabel.text = "123"
            firetruckLabel.text = "125"
            
        }
        
        if (checkLabel.text == "Albania") {
            
            self.preferredContentSize = CGSizeMake(0, 60)
            
            loadingLabel.hidden = true
            police.hidden = false
            policeLabel.hidden = false
            ambulance.hidden = false
            ambulanceLabel.hidden = false
            firetruck.hidden = false
            firetruckLabel.hidden = false
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = true
            ambulance911.hidden = true
            fire911.hidden = true
            label911.hidden = true
            
            policeLabel.text = "126"
            ambulanceLabel.text = "127"
            firetruckLabel.text = "129"
            
        }
        
        if (checkLabel.text == "Austria") {
            
            self.preferredContentSize = CGSizeMake(0, 60)
            
            loadingLabel.hidden = true
            police.hidden = false
            policeLabel.hidden = false
            ambulance.hidden = false
            ambulanceLabel.hidden = false
            firetruck.hidden = false
            firetruckLabel.hidden = false
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = true
            ambulance911.hidden = true
            fire911.hidden = true
            label911.hidden = true
            
            policeLabel.text = "133"
            ambulanceLabel.text = "144"
            firetruckLabel.text = "122"
            
        }
        
        if (checkLabel.text == "Andorra") {
            
            loadingLabel.hidden = true
            police.hidden = true
            policeLabel.hidden = true
            ambulance.hidden = true
            ambulanceLabel.hidden = true
            firetruck.hidden = true
            firetruckLabel.hidden = true
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = false
            ambulance911.hidden = false
            fire911.hidden = false
            label911.hidden = false
            
            label911.text = "860366"
            
        }
        
        if (checkLabel.text == "Switzerland") {
            
            self.preferredContentSize = CGSizeMake(0, 60)
            
            loadingLabel.hidden = true
            police.hidden = false
            policeLabel.hidden = false
            ambulance.hidden = false
            ambulanceLabel.hidden = false
            firetruck.hidden = false
            firetruckLabel.hidden = false
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = true
            ambulance911.hidden = true
            fire911.hidden = true
            label911.hidden = true
            
            policeLabel.text = "117"
            ambulanceLabel.text = "144"
            firetruckLabel.text = "118"
            
        }
        
        if (checkLabel.text == "Arabia Saudita") {
            
            self.preferredContentSize = CGSizeMake(0, 60)
            
            loadingLabel.hidden = true
            police.hidden = false
            policeLabel.hidden = false
            ambulance.hidden = false
            ambulanceLabel.hidden = false
            firetruck.hidden = false
            firetruckLabel.hidden = false
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = true
            ambulance911.hidden = true
            fire911.hidden = true
            label911.hidden = true
            
            policeLabel.text = "999"
            ambulanceLabel.text = "997"
            firetruckLabel.text = "998"
            
        }
        
        if (checkLabel.text == "Saudi Arabia") {
            
            self.preferredContentSize = CGSizeMake(0, 60)
            
            loadingLabel.hidden = true
            police.hidden = false
            policeLabel.hidden = false
            ambulance.hidden = false
            ambulanceLabel.hidden = false
            firetruck.hidden = false
            firetruckLabel.hidden = false
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = true
            ambulance911.hidden = true
            fire911.hidden = true
            label911.hidden = true
            
            policeLabel.text = "999"
            ambulanceLabel.text = "997"
            firetruckLabel.text = "998"
            
        }
        
        if (checkLabel.text == "Barbados") {
            
            self.preferredContentSize = CGSizeMake(0, 60)
            
            loadingLabel.hidden = true
            police.hidden = false
            policeLabel.hidden = false
            ambulance.hidden = false
            ambulanceLabel.hidden = false
            firetruck.hidden = false
            firetruckLabel.hidden = false
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = true
            ambulance911.hidden = true
            fire911.hidden = true
            label911.hidden = true
            
            policeLabel.text = "211"
            ambulanceLabel.text = "51"
            firetruckLabel.text = "311"
            
        }
        
        
        if (checkLabel.text == "Belgio") {
            
            self.preferredContentSize = CGSizeMake(0, 60)
            
            loadingLabel.hidden = true
            police.hidden = false
            policeLabel.hidden = false
            ambulance.hidden = false
            ambulanceLabel.hidden = false
            firetruck.hidden = false
            firetruckLabel.hidden = false
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = true
            ambulance911.hidden = true
            fire911.hidden = true
            label911.hidden = true
            
            policeLabel.text = "101"
            ambulanceLabel.text = "100"
            firetruckLabel.text = "112"
            
        }
        
        if (checkLabel.text == "Belgium") {
            
            self.preferredContentSize = CGSizeMake(0, 60)
            
            loadingLabel.hidden = true
            police.hidden = false
            policeLabel.hidden = false
            ambulance.hidden = false
            ambulanceLabel.hidden = false
            firetruck.hidden = false
            firetruckLabel.hidden = false
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = true
            ambulance911.hidden = true
            fire911.hidden = true
            label911.hidden = true
            
            policeLabel.text = "101"
            ambulanceLabel.text = "100"
            firetruckLabel.text = "112"
            
        }
        
        if (checkLabel.text == "Angola") {
            
            self.preferredContentSize = CGSizeMake(0, 60)
            
            loadingLabel.hidden = true
            police.hidden = false
            policeLabel.hidden = false
            ambulance.hidden = false
            ambulanceLabel.hidden = false
            firetruck.hidden = false
            firetruckLabel.hidden = false
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = true
            ambulance911.hidden = true
            fire911.hidden = true
            label911.hidden = true
            
            policeLabel.text = "113"
            ambulanceLabel.text = "116"
            firetruckLabel.text = "115"
            
        }
        
        if (checkLabel.text == "United States") {
            
            self.preferredContentSize = CGSizeMake(0, 120)
            
            loadingLabel.hidden = true
            police.hidden = true
            policeLabel.hidden = true
            ambulance.hidden = true
            ambulanceLabel.hidden = true
            firetruck.hidden = true
            firetruckLabel.hidden = true
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = false
            ambulance911.hidden = false
            fire911.hidden = false
            label911.hidden = false
            
            label911.text = "911"
            
        }
        
        if (checkLabel.text == "Stati Uniti") {
            
            self.preferredContentSize = CGSizeMake(0, 120)
            
            loadingLabel.hidden = true
            police.hidden = true
            policeLabel.hidden = true
            ambulance.hidden = true
            ambulanceLabel.hidden = true
            firetruck.hidden = true
            firetruckLabel.hidden = true
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = false
            ambulance911.hidden = false
            fire911.hidden = false
            label911.hidden = false
            
            label911.text = "911"
            
        }
        
        if (checkLabel.text == "Uruguay") {
            
            self.preferredContentSize = CGSizeMake(0, 120)
            
            loadingLabel.hidden = true
            police.hidden = true
            policeLabel.hidden = true
            ambulance.hidden = true
            ambulanceLabel.hidden = true
            firetruck.hidden = true
            firetruckLabel.hidden = true
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = false
            ambulance911.hidden = false
            fire911.hidden = false
            label911.hidden = false
            
            label911.text = "911"
            
        }
        
        if (checkLabel.text == "Canada") {
            
            self.preferredContentSize = CGSizeMake(0, 120)
            
            loadingLabel.hidden = true
            police.hidden = true
            policeLabel.hidden = true
            ambulance.hidden = true
            ambulanceLabel.hidden = true
            firetruck.hidden = true
            firetruckLabel.hidden = true
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = false
            ambulance911.hidden = false
            fire911.hidden = false
            label911.hidden = false
            
            label911.text = "911"
            
        }
        
        
        if (checkLabel.text == "Germany") {
            
            self.preferredContentSize = CGSizeMake(0, 60)
            
            loadingLabel.hidden = true
            police.hidden = false
            policeLabel.hidden = false
            ambulance.hidden = false
            ambulanceLabel.hidden = false
            firetruck.hidden = false
            firetruckLabel.hidden = false
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = true
            ambulance911.hidden = true
            fire911.hidden = true
            label911.hidden = true
            
            policeLabel.text = "110"
            ambulanceLabel.text = "112"
            firetruckLabel.text = "112"
            
        }
        
        if (checkLabel.text == "Germania") {
            
            self.preferredContentSize = CGSizeMake(0, 60)
            
            loadingLabel.hidden = true
            police.hidden = false
            policeLabel.hidden = false
            ambulance.hidden = false
            ambulanceLabel.hidden = false
            firetruck.hidden = false
            firetruckLabel.hidden = false
            donne.hidden = true
            donneLabel.hidden = true
            bimbi.hidden = true
            bimbiLabel.hidden = true
            carabinieri.hidden = true
            carabinieriLabel.hidden = true
            
            police911.hidden = true
            ambulance911.hidden = true
            fire911.hidden = true
            label911.hidden = true
            
            policeLabel.text = "110"
            ambulanceLabel.text = "112"
            firetruckLabel.text = "112"
            
        }
      
    }

    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        
        println("Error: " + error.localizedDescription)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        

        
        
    }
    
    @IBAction func police911(sender: UIButton) {
        
        if (label911.text == "911") {
        
            let url = "tel://911"
        
            
            let requestURL = NSURL(string:url)
            let request = NSURLRequest(URL: requestURL!)
            webView.loadRequest(request)
            
        }
        
        if (label911.text == "860366") {
            
            let url = "tel://860366"
            
            
            let requestURL = NSURL(string:url)
            let request = NSURLRequest(URL: requestURL!)
            webView.loadRequest(request)
            
        }
        
    }
    
        
    @IBAction func policecall(sender: UIButton) {
        
        if (policeLabel.text == "113") {
    
            
            let url = "tel://113"
            
            
            let requestURL = NSURL(string:url)
            let request = NSURLRequest(URL: requestURL!)
            webView.loadRequest(request)
            
        }
        
        if (policeLabel.text == "110") {
            
            let url = "tel://110"
            
            
            let requestURL = NSURL(string:url)
            let request = NSURLRequest(URL: requestURL!)
            webView.loadRequest(request)
            
        }
        
        if (policeLabel.text == "117") {
            
            let url = "tel://117"
            
            
            let requestURL = NSURL(string:url)
            let request = NSURLRequest(URL: requestURL!)
            webView.loadRequest(request)
            
        }
        
        if (policeLabel.text == "192") {
            
            let url = "tel://192"
            
            
            let requestURL = NSURL(string:url)
            let request = NSURLRequest(URL: requestURL!)
            webView.loadRequest(request)
            
        }
        
        if (policeLabel.text == "122") {
            
            let url = "tel://122"
            
            
            let requestURL = NSURL(string:url)
            let request = NSURLRequest(URL: requestURL!)
            webView.loadRequest(request)
            
        }
        
        if (policeLabel.text == "126") {
            
            let url = "tel://126"
            
            
            let requestURL = NSURL(string:url)
            let request = NSURLRequest(URL: requestURL!)
            webView.loadRequest(request)
            
        }
        
        if (policeLabel.text == "999") {
            
            let url = "tel://999"
            
            
            let requestURL = NSURL(string:url)
            let request = NSURLRequest(URL: requestURL!)
            webView.loadRequest(request)
            
        }
        
        if (policeLabel.text == "133") {
            
            
            let url = "tel://133"
            
            
            let requestURL = NSURL(string:url)
            let request = NSURLRequest(URL: requestURL!)
            webView.loadRequest(request)
            
        }
        
        if (policeLabel.text == "211") {
            
            
            let url = "tel://211"
            
            
            let requestURL = NSURL(string:url)
            let request = NSURLRequest(URL: requestURL!)
            webView.loadRequest(request)
            
        }
        
        if (policeLabel.text == "101") {
            
            
            let url = "tel://101"
            
            
            let requestURL = NSURL(string:url)
            let request = NSURLRequest(URL: requestURL!)
            webView.loadRequest(request)
            
        }


        
    }
    
    @IBAction func ambulancecall(sender: UIButton) {
        

        if (ambulanceLabel.text == "118") {
        
            let url = "tel://118"
            
            let requestURL = NSURL(string:url)
            let request = NSURLRequest(URL: requestURL!)
            webView.loadRequest(request)
            
        }
        
        if (ambulanceLabel.text == "112") {
            
            let url = "tel://112"
            
            let requestURL = NSURL(string:url)
            let request = NSURLRequest(URL: requestURL!)
            webView.loadRequest(request)
            
            
        }
        
        if (ambulanceLabel.text == "144") {
            
            let url = "tel://114"
            
            let requestURL = NSURL(string:url)
            let request = NSURLRequest(URL: requestURL!)
            webView.loadRequest(request)
            
        }
        
        if (ambulanceLabel.text == "123") {
            
            let url = "tel://112"
            
            let requestURL = NSURL(string:url)
            let request = NSURLRequest(URL: requestURL!)
            webView.loadRequest(request)
            
        }
        
        if (ambulanceLabel.text == "127") {
            
            let url = "tel://112"
            
            let requestURL = NSURL(string:url)
            let request = NSURLRequest(URL: requestURL!)
            webView.loadRequest(request)
            
        }
        
        if (ambulanceLabel.text == "116") {
            
            let url = "tel://116"
            
            let requestURL = NSURL(string:url)
            let request = NSURLRequest(URL: requestURL!)
            webView.loadRequest(request)
            
        }
        
        if (ambulanceLabel.text == "997") {
            
            let url = "tel://997"
            
            let requestURL = NSURL(string:url)
            let request = NSURLRequest(URL: requestURL!)
            webView.loadRequest(request)
            
        }
        
        if (ambulanceLabel.text == "144") {
            
            let url = "tel://144"
            
            let requestURL = NSURL(string:url)
            let request = NSURLRequest(URL: requestURL!)
            webView.loadRequest(request)
            
        }
        
        if (ambulanceLabel.text == "51") {
            
            let url = "tel://51"
            
            let requestURL = NSURL(string:url)
            let request = NSURLRequest(URL: requestURL!)
            webView.loadRequest(request)
            
        }
        
        if (ambulanceLabel.text == "100") {
            
            let url = "tel://100"
            
            let requestURL = NSURL(string:url)
            let request = NSURLRequest(URL: requestURL!)
            webView.loadRequest(request)
            
        }

        
    }
    
    @IBAction func firecall(sender: UIButton) {
        
        if (firetruckLabel.text == "115") {
    
            let url = "tel://115"
        
            let requestURL = NSURL(string:url)
            let request = NSURLRequest(URL: requestURL!)
            webView.loadRequest(request)
            
        }
        
        if (firetruckLabel.text == "112") {
            
            let url = "tel://112"
            
            let requestURL = NSURL(string:url)
            let request = NSURLRequest(URL: requestURL!)
            webView.loadRequest(request)
            
        }
        
        if (firetruckLabel.text == "118") {
            
            let url = "tel://118"
            
            let requestURL = NSURL(string:url)
            let request = NSURLRequest(URL: requestURL!)
            webView.loadRequest(request)
            
        }
        
        if (firetruckLabel.text == "193") {
            
            let url = "tel://193"
            
            let requestURL = NSURL(string:url)
            let request = NSURLRequest(URL: requestURL!)
            webView.loadRequest(request)
            
        }
    
        if (firetruckLabel.text == "125") {
            
            let url = "tel://125"
            
            let requestURL = NSURL(string:url)
            let request = NSURLRequest(URL: requestURL!)
            webView.loadRequest(request)
            
        }
        
        if (firetruckLabel.text == "129") {
            
            let url = "tel://129"
            
            let requestURL = NSURL(string:url)
            let request = NSURLRequest(URL: requestURL!)
            webView.loadRequest(request)
            
        }
        
        if (firetruckLabel.text == "998") {
            
            let url = "tel://998"
            
            let requestURL = NSURL(string:url)
            let request = NSURLRequest(URL: requestURL!)
            webView.loadRequest(request)
            
        }
        
        if (firetruckLabel.text == "122") {
            
            let url = "tel://122"
            
            let requestURL = NSURL(string:url)
            let request = NSURLRequest(URL: requestURL!)
            webView.loadRequest(request)
            
        }
        
        if (firetruckLabel.text == "311") {
            
            let url = "tel://311"
            
            let requestURL = NSURL(string:url)
            let request = NSURLRequest(URL: requestURL!)
            webView.loadRequest(request)
            
        }
        
    
    }
    
    @IBAction func carabiniericall(sender: UIButton) {
        
        let url = "tel://112"
        
        let requestURL = NSURL(string:url)
        let request = NSURLRequest(URL: requestURL!)
        webView.loadRequest(request)
        
    }
    
    @IBAction func womancall(sender: UIButton) {
        
        let url = "tel://1522"
        
        let requestURL = NSURL(string:url)
        let request = NSURLRequest(URL: requestURL!)
        webView.loadRequest(request)
        
    }
    

    @IBAction func childrencall(sender: UIButton) {
        
        let url = "tel://114"
        
        let requestURL = NSURL(string:url)
        let request = NSURLRequest(URL: requestURL!)
        webView.loadRequest(request)
        
    }

    
    
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        
        
        
        completionHandler(NCUpdateResult.NewData)
    }
    
}
