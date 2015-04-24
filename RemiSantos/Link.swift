//
//  Link.swift
//  RemiSantos
//
//  Created by Remi Santos on 19/04/15.
//  Copyright (c) 2015 Remi Santos. All rights reserved.
//

import UIKit
import StoreKit

class Link: RSIntroElement, SKStoreProductViewControllerDelegate {
    
    var text:String? {
        didSet {
            titleLabel.text = text
        }
    }
    var detailText:String? {
        didSet {
            detailLabel.text = detailText
        }
    }
    var image:UIImage? {
        didSet {
            imageView.image = image
        }
    }
    var buttonTitle:String? {
        didSet {
            detailButton.setTitle(buttonTitle, forState: .Normal)
        }
    }
    var appId:String? {
        didSet {
            detailButton.hidden = false
            buttonHeight?.constant = 40
        }
    }
    var linkUrl:String? {
        didSet {
            detailButton.hidden = false
            buttonHeight?.constant = 40
        }
    }
    
    var titleLabel: UILabel!
    var imageView: UIImageView!
    var detailLabel: UILabel!
    var detailButton: UIButton!
    var popover:UIView!
    var popOpen = false
    var popOverlay: UIView!
    var buttonHeight:NSLayoutConstraint?
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        buildView()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildView() {
        self.layer.transform = CATransform3DMakeTranslation(0, 0, 1000) //prevent origami 3D transform z-index
        self.userInteractionEnabled = true
        self.clipsToBounds = false
        self.backgroundColor = UIColor.clearColor()
        self.addParallaxEffectWithIntensity(self.frame.size.width)

        imageView = UIImageView(frame: self.frame)
        imageView.image = UIImage(named: "empty-icon")
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = self.frame.size.width / 5
//        imageView.layer.borderColor = UIColor(red:0.729412, green:0.729412, blue:0.729412, alpha:1.0).CGColor
//        imageView.layer.borderWidth = 1
        imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        addSubview(imageView)
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[imageView]|", options: .allZeros, metrics: nil, views: ["imageView":imageView]))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[imageView]|", options: .allZeros, metrics: nil, views: ["imageView":imageView]))
        
        titleLabel = UILabel(frame: self.frame)
        titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        titleLabel.font = UIFont(name: "Avenir-Book", size: 20)
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textAlignment = .Center
        addSubview(titleLabel)
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-7-[title]-7-|", options: .allZeros, metrics: nil, views: ["title":titleLabel]))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[title]|", options: .allZeros, metrics: nil, views: ["title":titleLabel]))

        popover = UIView(frame: CGRect())
        popover.backgroundColor = UIColor.whiteColor()
        popover.layer.cornerRadius = 10
        popover.hidden = true
        popover.setTranslatesAutoresizingMaskIntoConstraints(false)
        addSubview(popover)
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(-120)-[popover]-(-120)-|", options: .allZeros, metrics: nil, views: ["popover":popover]))
        self.addConstraint(NSLayoutConstraint(item: popover, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1, constant: self.frame.size.height + 20))
        self.addConstraint(NSLayoutConstraint(item: popover, attribute: .Height, relatedBy: .LessThanOrEqual, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 180))

        
        detailLabel = UILabel(frame: self.frame)
        detailLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        detailLabel.font = UIFont(name: "Avenir-Book", size: 14)
        detailLabel.textColor = UIColor.blackColor()
        detailLabel.adjustsFontSizeToFitWidth = true
        detailLabel.numberOfLines = 0
        popover.addSubview(detailLabel)
        
        
        detailButton = UIButton.buttonWithType(.System) as! UIButton
        detailButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        detailButton.titleLabel?.font = UIFont(name: "Avenir-Roman", size: 14)
        detailButton.tintColor = UIColor(red:0.113725, green:0.600000, blue:0.964706, alpha:1.0)
        detailButton.addTarget(self, action: "moreButtonClicked:", forControlEvents: .TouchUpInside)
        detailButton.setTitle("See more", forState: .Normal)
        detailButton.hidden = true
        
        popover.addSubview(detailButton)
        popover.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[button]|", options: .allZeros, metrics: nil, views: ["button":detailButton]))
        popover.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[detail]-10-|", options: .allZeros, metrics: nil, views: ["detail":detailLabel]))
        popover.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[detail]-[button]|", options: .allZeros, metrics: nil, views: ["detail":detailLabel, "button":detailButton]))
        buttonHeight = NSLayoutConstraint(item: detailButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 0)
        popover.addConstraint(buttonHeight!)

        self.sendSubviewToBack(popover)
        
        popOverlay = UIView(frame: self.frame)
        popOverlay.backgroundColor = UIColor(white: 0, alpha: 0.5)
        popOverlay.hidden = true
    }

    func moreButtonClicked(sender:UIButton) {
        if appId != nil {
            if 1 == 1 || UIDevice.currentDevice().model.rangeOfString("Simulator", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil, locale: nil) != nil {
                let webVC = (UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController?.storyboard?.instantiateViewControllerWithIdentifier("WebVC") as! WebViewController
                webVC.url = "http://itunes.apple.com/app/id\(appId!)/"
                presentController(webVC)
//                UIApplication.sharedApplication().openURL(NSURL(string: "http://itunes.apple.com/app/id\(appId!)/")!)
                return
            }
            let store = SKStoreProductViewController()
            store.delegate = self
            let buttonTitle = sender.titleForState(.Normal)
            sender.enabled = false
            sender.setTitle("...Loading AppStore...", forState: .Normal)
            store.loadProductWithParameters([SKStoreProductParameterITunesItemIdentifier:appId!], completionBlock: { (success, error) -> Void in
                if success {
                    self.presentController(store)
                }
                sender.setTitle(buttonTitle, forState: .Normal)
                sender.enabled = true
            })
            
        } else if linkUrl != nil {
            let webVC = (UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController?.storyboard?.instantiateViewControllerWithIdentifier("WebVC") as! WebViewController
            webVC.url = linkUrl
            presentController(webVC)
        }
    }
    
    func presentController(controller:UIViewController) {
        self.closePopover()
        (UIApplication.sharedApplication().delegate as!AppDelegate).window?.rootViewController?.presentViewController(controller, animated: true, completion: nil)
    }
    
    var previousCenter:CGPoint?
    func openPopover() {
        previousCenter = self.center
        self.popover.hidden = false
        self.popover.alpha = 0
        self.superview?.window?.addSubview(self.popOverlay)
        self.superview?.window?.addSubview(self)
        self.popOverlay.frame = self.superview!.bounds
        self.popOverlay.center = self.superview!.center
        self.popOverlay.hidden = false
        self.popOverlay.alpha = 0
        self.superview?.window?.bringSubviewToFront(self)

        UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.allZeros, animations: { () -> Void in
            self.center = self.superview!.center
            self.popOverlay.alpha = 1
            self.imageView.transform = CGAffineTransformMakeScale(1.5, 1.5)
            self.titleLabel.transform = CGAffineTransformMakeScale(1.5, 1.5)
        },completion: { (finished) -> Void in
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.popover.alpha = 1
            }, completion: { (finished) -> Void in
                self.popOpen = true
            })
        })
        
        
        
    }
    
    func closePopover() {
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.popover.alpha = 0
        }, completion: { (finished) -> Void in
            self.popover.hidden = true
            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.allZeros, animations: { () -> Void in
                self.popOverlay.alpha = 0
                self.center = self.previousCenter!
                self.titleLabel.transform = CGAffineTransformIdentity
                self.imageView.transform = CGAffineTransformIdentity
            },completion: { (finished) -> Void in
                self.popOverlay.hidden = true
                self.popOpen = false
                self.introView?.addSubview(self)
            })
        })
        
    }
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        if !popOpen {
            self.alpha = 0.7
        }
    }
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesEnded(touches, withEvent: event)
        self.alpha = 1
        let view = (touches.first! as! UITouch).view
        if popOpen {
            closePopover()
        } else if CGRectContainsPoint(self.frame, (touches.first as! UITouch).locationInView(self.superview)) {
            openPopover()
        }
    }
    
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        if popOpen {
            if CGRectContainsPoint(detailButton.frame, self.convertPoint(point, toView: popover)) {
                return detailButton
            }
            return self
        }
        return super.hitTest(point, withEvent: event)
    }
    
    func productViewControllerDidFinish(viewController: SKStoreProductViewController!) {
        if viewController != nil {
            viewController.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
