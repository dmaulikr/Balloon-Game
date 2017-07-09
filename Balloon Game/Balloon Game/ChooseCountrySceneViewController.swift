//// WE DON'T NEED THIS
////  ChooseCountrySceneViewController.swift
////  Balloon Game
////
////  Created by Kathryn Hodge on 4/12/15.
////  Copyright (c) 2015 blondiebytes. All rights reserved.
////
//
//import Foundation
//import UIKit
//import SpriteKit
//
//// page turner
//class ChooseCountrySceneViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
//    
//    var savedData:SavedData?
//    
//    // INDEX = 0 --> GO TO MAILBOX
//    // INDEX = 1 --> GO TO CHOOSE COUNTRIES
//    var index = 0;
//    var identifiers:NSArray = ["LetterScreen", "ChooseCountryScreenVC"]
//    var viewcontrollers:[AnyObject] = []
//    
//    override func viewDidLoad() {
//        
//        NSLog("choose country didload")
//        
//        super.viewDidLoad()
//
//        NSLog("choose country super didload finished")
//
//        self.dataSource = self
//        self.delegate = self
//        
//        self.viewcontrollers = [UIViewController](count: 2, repeatedValue: self)
//        
//        for i in 0...1 {
//            let id : String = identifiers[i] as! String
//            NSLog("instantiat \(id)")
//            let mvc: AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier(id)
//            let vc = mvc as! HasSavedData
//            vc.setSavedData(self.savedData!)
//            vc.setViewController(self)
//            viewcontrollers[i] = vc
//            }
//        
//        let startingViewController:UIViewController = self.viewControllerAtIndex(self.index);
//        let viewControllers: NSArray = [startingViewController]
//        self.setViewControllers(viewControllers as! [AnyObject], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
//        
//        
//    }
//    
//    func viewControllerAtIndex(index: Int) -> UIViewController! {
//        if ( 0 <= index && index < 2 ) {
//            return self.viewcontrollers[index] as! UIViewController
//        } else {
//            return nil
//        }
//    }
//    
//    // override func setViewControllers(viewControllers: [AnyObject]!, direction: UIPageViewControllerNavigationDirection, animated: Bool, completion: ((Bool) -> Void)!) {
//    //setting view controller content...
//    //    }
//    
//    // Required Methods for UIPageViewControllerDataSource
//    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
//        let identifier = viewController.restorationIdentifier
//        let index = self.identifiers.indexOfObject(identifier!)
//        
//        // because we are before the start
//        if index <= 0 {
//            return nil
//        }
//        self.index--
//        return self.viewControllerAtIndex(self.index)
//        
//    }
//    
//    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
//        let identifier = viewController.restorationIdentifier
//        let index = self.identifiers.indexOfObject(identifier!)
//        
//        // because we are at the end of all the screens
//        if index >= identifiers.count - 1 {
//            return nil
//        }
//        
//        self.index++
//        return self.viewControllerAtIndex(self.index)
//        
//    }
//    
//    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
//        return self.identifiers.count
//    }
//    
//    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
//        return 0
//    }
//    
//    // Segues and Segue Identifiers:
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
//        NSLog("prepare for segue")
//        if (segue.identifier == "nextRound") {
//            var svc = segue.destinationViewController as! GameViewController;
//            svc.savedData = self.savedData!
//        }
//    }
//    
//    
//    
//    //
//    // Boilerplate
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