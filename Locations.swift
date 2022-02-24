//
//  Locations.swift
//  EmergencyCall2
//
//  Created by Francesco on 17/04/15.
//  Copyright (c) 2015 Francesco Vezzoli. All rights reserved.
//

import UIKit

class Locations: UITableViewController {
    
    let items = ["Albania", "Angola", "Saudi Arabia", "Austria", "Barbados", "United States", "Italy"]
    

    override func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int)
        -> Int {
            return self.items.count
    }

    override func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            let item = self.items[indexPath.row]
            
            let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath) as! UITableViewCell
            cell.textLabel!.text = item
            return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow();
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as UITableViewCell!;
        
        let string1 = currentCell.textLabel?.text
        
        let sharedDefaults = NSUserDefaults(suiteName:"group.francesco.emergencyTodayWidget")
        sharedDefaults?.setObject(string1, forKey: "selectedLocation")
        sharedDefaults?.synchronize()
        
        NSUserDefaults.standardUserDefaults().setObject(string1, forKey: "newLocation")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
}
