
//
//  SingleLetterView.swift
//  Balloon Game
//
//  Created by Kathryn Hodge on 4/22/15.
//  Copyright (c) 2015 blondiebytes. All rights reserved.
//

import Foundation
import UIKit

class SingleLetterView : UIView {
    var letterStationeryView:UIImageView?
    var textView:UITextView?
    var shouldShow:Bool?
    
    init(letterText:String, screenWidth:CGFloat, screenHeight:CGFloat) {
        // will be random stationery
        
        
        let parentScreenW:CGFloat = screenWidth
        let parentScreenH:CGFloat = screenHeight
        let stationeryX:CGFloat = screenWidth/16
        let stationeryY:CGFloat = screenHeight/7
        let sizeConst:CGFloat = 3/4
        
        let theFrame:CGRect = CGRect (x: stationeryX, y: stationeryY, width: parentScreenW * sizeConst, height: parentScreenH * 3/5)
        
        
        let letterstationery:UIImage = UIImage(named: "stationery")!
        
        
        
        super.init(frame: theFrame)
        
        self.shouldShow = true
        
        // imageView
        self.letterStationeryView = UIImageView(frame: theFrame)
        self.letterStationeryView!.image = letterstationery
        
        
        // attributes
        let font =  UIFont(name: "Helvetica", size: 12.0)
        let color = UIColor.blackColor()
        var paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        
        
        // attributedText
        let attributes = /*font style */ [NSFontAttributeName: font!,
            /*font color */ NSForegroundColorAttributeName: color, /*line spacing*/ NSParagraphStyleAttributeName: paragraphStyle]
        var attributedLetterText:NSMutableAttributedString = NSMutableAttributedString(string: letterText, attributes:attributes)
        
        // textView
        
        let textFrame:CGRect = CGRect (x: stationeryX + theFrame.size.width/10, y: stationeryY + theFrame.size.height/4, width: theFrame.size.width * (4/5), height: theFrame.size.height/2)
        
        self.textView = UITextView(frame: textFrame)
        self.textView!.attributedText = attributedLetterText
        self.textView!.backgroundColor = nil
        self.textView!.editable = false
        self.setGestures()
        
        
        // addThings
        self.addSubview(letterStationeryView!)
        self.addSubview(textView!)
    }
    
    
    func setGestures() {
        let tapInView: UITapGestureRecognizer = UITapGestureRecognizer (target: self, action: Selector("handleTap:"))
        self.textView!.addGestureRecognizer(tapInView)
    }
    
    func handleTap (sender:UITapGestureRecognizer) {
        // if it shouldn't be shown now, then take it awayyy
        if (!self.shouldShow!) {
            self.removeFromSuperview()
            self.shouldShow = true
        }
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
}
