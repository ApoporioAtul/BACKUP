//
//  UiView.swift
//  ApporioTinderClone
//
//  Created by Piyush /kumar on 07/02/17.
//  Copyright © 2017 Apporio. All rights reserved.
//
import UIKit

extension UIView {
    
    
    class func loadFromNibNamed(nibNamed: String, bundle : NSBundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiateWithOwner(nil, options: nil)[0] as? UIView
    }
    
  
    
    func viewShadowEffect ()
        
    {
        
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 2
        self.layer.borderColor = UIColor.clearColor().CGColor
    }
    
   
   
    
    
    func edgeWithShadow ()
        
    {
        
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 2
        self.layer.cornerRadius = 5
        self.layer.borderColor = UIColor.clearColor().CGColor
    }
    
    
    
    func edgeWithShadow (edge: CGFloat)
        
    {
        
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 2
        self.layer.cornerRadius = edge
        self.layer.borderColor = UIColor.clearColor().CGColor
    }
    
    
    
    
    func cellSpacingWithEdge()
    {
        
        
        layer.backgroundColor = CGColorCreate(CGColorSpaceCreateDeviceRGB(), [1.0, 1.0, 1.0, 1.0])
        layer.masksToBounds = false
        layer.cornerRadius = 2.0
        layer.shadowOffset = CGSizeMake(-1, 1)
        layer.shadowOpacity = 0.2
        
        
    }
    
    
    func roundView ()
        
    {
        
        self.layer.cornerRadius = self.frame.size.height/2
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.clearColor().CGColor
        self.layer.borderWidth = 1.0
        
        
        
        
        
    }
    
    func roundViewWithBorderColor (color: UIColor)
        
    {
        
        self.layer.cornerRadius = self.frame.size.height/2
        self.clipsToBounds = true
        self.layer.borderColor = color.CGColor
        self.layer.borderWidth = 1.0

    }
    
    
    
    
    func edgeWithBorderColor(color: UIColor)
        
    {
        
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowOpacity = 0.3
        self.layer.cornerRadius = 5
        self.layer.borderWidth  = 1
        self.layer.borderColor = color.CGColor
        
        
    }
    
    
    
    
    
    
    
    func border()
    {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red:222/255.0, green:225/255.0, blue:227/255.0, alpha: 1.0).CGColor
        self.layer.cornerRadius = 3
        
    }
    
    func borderWithColor(color: UIColor)
    {
        self.layer.borderWidth = 1
        self.layer.borderColor = color.CGColor
        self.layer.cornerRadius = 3
    }
    
    
           func slideLeft()
        {
            
            
            let transition = CATransition()
            transition.duration = 0.2
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromLeft
            self.layer.addAnimation(transition, forKey: kCATransition)
        }
        
        
        
        func slideRight()
        {
            
            let transition = CATransition()
            transition.duration = 0.2
            transition.type = kCATransitionPush
            transition.subtype = kCATransitionFromRight
            self.layer.addAnimation(transition, forKey: kCATransition)
            
            
        }
  
  

    
}