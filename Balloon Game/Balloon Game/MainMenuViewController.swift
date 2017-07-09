//
//  MainMenuViewController.swift
//  Balloon Game
//
//  Created by Kathryn Hodge on 4/12/15.
//  Copyright (c) 2015 blondiebytes. All rights reserved.
//

import Foundation

import UIKit

class MainMenuViewController: UIViewController {
    
    override func viewDidLoad() {
               super.viewDidLoad()
    }
    
    
    
    // Segues and Segue Identifiers:
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
            if (segue.identifier == "firstRound") {
                var svc = segue.destinationViewController as! GameViewController;
                svc.savedData = SavedData()
                svc.whichScreen = "game"
            }
        }
    
    func prepareForUnwindData(segue:UIStoryboardSegue) {
        if (segue.identifier == "backToMenu") {
            //GameViewController svc = (GameViewController) segue.sourceViewController;
            NSLog("get data from gamescene")
        }
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        NSLog("backToMainMenu")
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
