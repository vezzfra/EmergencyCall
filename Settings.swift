//
//  Settings.swift
//  EmergencyCall2
//
//  Created by Francesco on 06/03/15.
//  Copyright (c) 2015 Francesco Vezzoli. All rights reserved.
//

import UIKit

class Settings: UIViewController {
    
    @IBOutlet weak var scroller: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scroller.scrollEnabled = true
        scroller.contentSize = CGSizeMake(320, 1276)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
