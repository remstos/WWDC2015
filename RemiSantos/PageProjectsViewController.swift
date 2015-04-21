//
//  PageProjectsViewController.swift
//  RemiSantos
//
//  Created by Remi Santos on 18/04/15.
//  Copyright (c) 2015 Remi Santos. All rights reserved.
//

import UIKit

class PageProjectsViewController: UIViewController {

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

        var captain = Link(frame: CGRect(x: 40, y: 150, width: linkSize+10, height: linkSize+10))
        captain.image = UIImage(named: "captain-icon")
        captain.detailText = "Bring popular posts from social networks on the same place. Given a hashtag, the #Captain find what's happening on Facebook, Twitter, Instagram and Vine! Wow!"
        captain.appId = "934806007"
        captain.addKeyFrame(CGRectOffset(captain.frame, -200, 0), forTime: time - CGFloat(300))
        captain.addKeyFrame(captain.frame, forTime: time)
        captain.addKeyFrame(topFrame, forTime: time + CGFloat(450))
        captain.frame = CGRectOffset(captain.frame, -200, 0)
        introView?.addElement(captain)
        
        var thumb = Link(frame: CGRect(x: view.frame.size.width - 70, y: 60, width: linkSize-2, height: linkSize-2))
        thumb.image = UIImage(named: "thumbify-icon")
        thumb.detailText = "The thumb keyboard. It’s now easy to say it with a thumb! It’s FREE! No in-app purchase. How cool is that?"
        thumb.appId = "945400201"
        thumb.addKeyFrame(CGRectOffset(thumb.frame, 250, 0), forTime: time - CGFloat(300))
        thumb.addKeyFrame(thumb.frame, forTime: time)
        thumb.addKeyFrame(topFrame, forTime: time + CGFloat(450))
        thumb.frame = CGRectOffset(thumb.frame, 250, 0)
        introView?.addElement(thumb)
        
        var sofa = Link(frame: CGRect(x: view.frame.size.width - 100, y: 250, width: linkSize, height: linkSize))
        sofa.image = UIImage(named: "sofa-icon")
        sofa.detailText = "Leave your TV remote lost under your sofa. An app for iOS and Mac with a nice widget on the Notification Center to have a quick access to the remote, and an Apple Watch app. (working for Freebox only for now)"
        sofa.linkUrl = "http://sofaremote.com"
        sofa.addKeyFrame(CGRectOffset(sofa.frame, 200, 0), forTime: time - CGFloat(300))
        sofa.addKeyFrame(sofa.frame, forTime: time)
        sofa.addKeyFrame(topFrame, forTime: time + CGFloat(450))
        sofa.frame = CGRectOffset(sofa.frame, 200, 0)
        introView?.addElement(sofa)
        
        var drawl = Link(frame: CGRect(x: view.frame.size.width - 150, y: view.frame.size.height - 200, width: linkSize+5, height: linkSize+5))
        drawl.image = UIImage(named: "drawl-icon")
        drawl.detailText = "Drawl it like a boss, send it to your Messenger friends."
        drawl.linkUrl = "http://getdrawl.com"
        drawl.addKeyFrame(CGRectOffset(drawl.frame, 250, 0), forTime: time - CGFloat(300))
        drawl.addKeyFrame(drawl.frame, forTime: time)
        drawl.addKeyFrame(topFrame, forTime: time + CGFloat(450))
        drawl.frame = CGRectOffset(drawl.frame, 250, 0)
        introView?.addElement(drawl)

        var loopse = Link(frame: CGRect(x: 100, y: view.frame.size.height - 150, width: linkSize, height: linkSize))
        loopse.image = UIImage(named: "loopse-icon")
        loopse.appId = "704783915"
        loopse.detailText = "Spots + Friends = Sessions. Find new spots from your favorites sports around you, invite some friends and have a nice session"
        loopse.addKeyFrame(CGRectOffset(loopse.frame, -250, 0), forTime: time - CGFloat(300))
        loopse.addKeyFrame(loopse.frame, forTime: time)
        loopse.addKeyFrame(topFrame, forTime: time + CGFloat(450))
        loopse.frame = CGRectOffset(loopse.frame, -250, 0)
        introView?.addElement(loopse)

        var peekaboo = Link(frame: CGRect(x: 30, y: view.frame.size.height - 80, width: linkSize, height: linkSize))
        peekaboo.image = UIImage(named: "peekaboo-icon")
        peekaboo.detailText = "Fun wallpapers for iPhone 6(+). With just a few taps pimp your iPhone with fun and cute wallpapers ! Cowboys, astronauts, cooks, sailors and many more are all in ! Double tap the home button and... peekaboo !"
        peekaboo.appId = "923358480"
        peekaboo.addKeyFrame(CGRectOffset(peekaboo.frame, -150, 0), forTime: time - CGFloat(300))
        peekaboo.addKeyFrame(peekaboo.frame, forTime: time)
        peekaboo.addKeyFrame(topFrame, forTime: time + CGFloat(450))
        peekaboo.frame = CGRectOffset(peekaboo.frame, -150, 0)
        introView?.addElement(peekaboo)
    }
}
