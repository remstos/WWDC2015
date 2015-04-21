//
//  PageWWDCViewController.swift
//  RemiSantos
//
//  Created by Remi Santos on 20/04/15.
//  Copyright (c) 2015 Remi Santos. All rights reserved.
//

import UIKit

class PageWWDCViewController: UIViewController {

    var introView: RSIntroView? {
        didSet {
            buildLinks()
        }
    }
    var page: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clearColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buildLinks() {
        let linkSize:CGFloat = 50
        var originY:CGFloat = 0
        var index = CGFloat(page-1)
        var time = view.frame.size.height * index
        var topFrame = CGRect(x: (view.frame.size.width - linkSize)/2, y: -70, width: linkSize, height: linkSize)

        var swift = Link(frame: CGRect(x: 50, y: view.frame.size.height - 220, width: linkSize, height: linkSize))
        swift.image = UIImage(named:"swift-icon")
        swift.detailText = "I was there when Swift has been released! WOW!"
        swift.addKeyFrame(CGRectOffset(swift.frame, -200, 0), forTime: time - CGFloat(300))
        swift.addKeyFrame(swift.frame, forTime: time)
        swift.addKeyFrame(topFrame, forTime: time + CGFloat(450))
        swift.frame = CGRectOffset(swift.frame, -200, 0)
        introView?.addElement(swift)
        
        var wwdc = Link(frame: CGRect(x: view.frame.size.width - 120, y: 170, width: linkSize, height: linkSize))
        wwdc.image = UIImage(named:"me-8")
        wwdc.detailText = "The WWDC 2014 was really awesome, such a wonderful experience!"
        wwdc.addKeyFrame(CGRectOffset(wwdc.frame, 200, 0), forTime: time - CGFloat(300))
        wwdc.addKeyFrame(wwdc.frame, forTime: time)
        wwdc.addKeyFrame(topFrame, forTime: time + CGFloat(450))
        wwdc.frame = CGRectOffset(wwdc.frame, 200, 0)
        introView?.addElement(wwdc)
        
        var guys = Link(frame: CGRect(x: view.frame.size.width - 80, y: view.frame.size.height - 250, width: linkSize, height: linkSize))
        guys.image = UIImage(named:"guys-icon")
        guys.detailText = "We're applying for the WWDC 2015 together! We're 3 from the same school (and from the Apple Lab) - Damien Audrezet - Edouard Chusseau and me!"
        guys.addKeyFrame(CGRectOffset(guys.frame, 200, 0), forTime: time - CGFloat(300))
        guys.addKeyFrame(guys.frame, forTime: time)
        guys.addKeyFrame(topFrame, forTime: time + CGFloat(450))
        guys.frame = CGRectOffset(guys.frame, 200, 0)
        introView?.addElement(guys)
        
        var bridge = Link(frame: CGRect(x: 80, y: view.frame.size.height - 140, width: linkSize, height: linkSize))
        bridge.image = UIImage(named:"bridge-icon")
        bridge.detailText = "San Francisco is a really nice place to visit 😍"
        bridge.addKeyFrame(CGRectOffset(bridge.frame, -240, 0), forTime: time - CGFloat(300))
        bridge.addKeyFrame(bridge.frame, forTime: time)
        bridge.addKeyFrame(topFrame, forTime: time + CGFloat(450))
        bridge.frame = CGRectOffset(bridge.frame, -240, 0)
        introView?.addElement(bridge)

    }

}
