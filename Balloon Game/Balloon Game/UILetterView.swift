
//
//  UILetterView.swift
//  Balloon Game
//
//  Created by Kathryn Hodge on 4/22/15.
//  Copyright (c) 2015 blondiebytes. All rights reserved.
//

import Foundation
import UIKit

class UILetterView : UIView {
    let letterIcon:UIImage = UIImage(named:"recUnopenedLetter")!
    let letterOutline:UIImage = UIImage(named: "notRecievedLetter")!
    var isOpen:Bool!
    
    var letterIconImageView:UIImageView = UIImageView(frame: (CGRect (x: 0, y:0, width: UIScreen.mainScreen().bounds.width / 8, height: UIScreen.mainScreen().bounds.height / 8)))
    
    init() {
        super.init(frame: CGRect( x: 0 , y: 0, width: UIScreen.mainScreen().bounds.width / 8, height: UIScreen.mainScreen().bounds.height / 6))
        
        self.isOpen = false
        self.letterIconImageView.image = letterOutline
        addSubview(letterIconImageView)
    }
    
    func makeOpen() {
        self.letterIconImageView.image = letterIcon
        self.isOpen = true
    }
    
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}


