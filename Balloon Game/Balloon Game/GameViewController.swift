//
//  GameViewController.swift
//  Balloo!
//
//  Created by Kathryn Hodge & Amanda on 2/14/15.
//  Copyright (c) 2015 blondiebytes. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    var savedData:SavedData?
    
    // either game or country
    var whichScreen:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Manually creating game scene -- instead of unarchieve
        if (whichScreen == "game") {
            let scene:GameScene = GameScene()
            scene.savedData = savedData!
            scene.viewC = self
            setUpTheScene(scene)
        } else if (whichScreen == "country") {
            let scene:ChooseCountryScene = ChooseCountryScene()
            scene.viewC = self
            scene.savedData = savedData!
            setUpTheScene(scene)
        } else {
            // do nothing
        }
    }
    
    func setUpTheScene(scene:SKScene) {
        // For debugging
        let skView = self.view as! SKView
        skView.showsFPS = false
        skView.showsNodeCount = false
        skView.showsPhysics = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        skView.presentScene(scene)

    }
    
        // Segues and Segue Identifiers:
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "goToMail" || segue.identifier == "backToMail") {
                var svc = segue.destinationViewController as! MailboxViewController;
                svc.savedData = self.savedData!
            } else if (segue.identifier == "backToMainMenu") {
                var svc = segue.destinationViewController as! MainMenuViewController;
            }
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
