//// WE DON'T NEED THIS
////  ChooseCountryScreenVC.swift
////  Balloon Game
////
////  Created by Kathryn Hodge on 4/24/15.
////  Copyright (c) 2015 blondiebytes. All rights reserved.
////
//
//import Foundation
//import SpriteKit
//
//class ChooseCountryScreenVC: HasSavedData {
//    
//    var savedData:SavedData?
//    var viewC:UIViewController?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Manually creating game scene -- instead of unarchieve
//        let scene:ChooseCountryScene = ChooseCountryScene()
//        scene.viewC = self.viewC
//        scene.setSavedData(savedData!)
//        // Configure the view.
//        let skView = self.view as! SKView
//        // For debugging
//        skView.showsFPS = false
//        skView.showsNodeCount = true
//        skView.showsPhysics = true
//        
//        /* Sprite Kit applies additional optimizations to improve rendering performance */
//        skView.ignoresSiblingOrder = true
//        scene.savedData = savedData!
//        
//        skView.presentScene(scene)
//        //     }
//    }
//    
//    override func setSavedData(data: SavedData) {
//        self.savedData = data
//    }
//    
//    override func setViewController(vc: UIViewController) {
//        self.viewC = vc
//    }
//    
////    // Segues and Segue Identifiers:
////   override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
////            if (segue.identifier == "nextRound") {
////                var svc = segue.destinationViewController as! GameViewController;
////                svc.savedData = self.savedData!
////            }
////        }
//    
//    
//    override func shouldAutorotate() -> Bool {
//        return true
//    }
//    
//    override func supportedInterfaceOrientations() -> Int {
//        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
//            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
//        } else {
//            return Int(UIInterfaceOrientationMask.All.rawValue)
//        }
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Release any cached data, images, etc that aren't in use.
//    }
//    
//    override func prefersStatusBarHidden() -> Bool {
//        return true
//    }
//}