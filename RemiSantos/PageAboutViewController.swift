//
//  PageAboutViewController.swift
//  RemiSantos
//
//  Created by Remi Santos on 18/04/15.
//  Copyright (c) 2015 Remi Santos. All rights reserved.
//

import UIKit

class PageAboutViewController: UIViewController {

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

        var me = Link(frame: CGRect(x: view.frame.size.width - 70, y: 140, width: linkSize, height: linkSize))
        me.text = "Me"
        me.detailText = "Loving life, be optimistic and never give up, that's how I live. Rollerblade, go out, discover, code/create, enjoy the world."
        me.linkUrl = "http://www.remisantos.com"
        me.addKeyFrame(CGRectOffset(me.frame, -400, 0), forTime: time - CGFloat(300))
        me.addKeyFrame(me.frame, forTime: time)
        me.addKeyFrame(topFrame, forTime: time + CGFloat(450))
        me.frame = CGRectOffset(me.frame, -400, 0)
        introView?.addElement(me)
        
        var github = Link(frame: CGRect(x: 100, y: view.frame.size.height - 220, width: linkSize, height: linkSize))
        github.image = UIImage(named:"github-icon")
        github.detailText = "I open source more and more project, like the lib I used to create this app: `RSIntro` to easily build warm tour for our apps with elements moving smoothly"
        github.linkUrl = "http://www.github.com/Kemcake"
        github.addKeyFrame(CGRectOffset(github.frame, -200, 0), forTime: time - CGFloat(300))
        github.addKeyFrame(github.frame, forTime: time)
        github.addKeyFrame(topFrame, forTime: time + CGFloat(450))
        github.frame = CGRectOffset(github.frame, -200, 0)
        introView?.addElement(github)
        
        var twitter = Link(frame: CGRect(x: 30, y: view.frame.size.height - 180, width: linkSize, height: linkSize))
        twitter.image = UIImage(named:"twitter-icon")
        twitter.detailText = "Hey! I'm on Twitter ;)"
        twitter.linkUrl = "http://www.twitter.com/Kemcake"
        twitter.buttonTitle = "Follow me"
        twitter.addKeyFrame(CGRectOffset(twitter.frame, -100, 0), forTime: time - CGFloat(300))
        twitter.addKeyFrame(twitter.frame, forTime: time)
        twitter.addKeyFrame(topFrame, forTime: time + CGFloat(450))
        twitter.frame = CGRectOffset(twitter.frame, -100, 0)
        introView?.addElement(twitter)
        
        var school = Link(frame: CGRect(x: 50, y: 160, width: linkSize, height: linkSize))
        school.text = "School"
        school.detailText = "I'm studying at Ingesup, a Master in computer science - We've been featured on the Sept 2014 keynote as one of the first school to teach Swift!"
        school.linkUrl = "http://www.ingesup.com/non-categorise/keynote-d-apple-ingesup-dans-le-best-of.html"
        school.addKeyFrame(CGRectOffset(school.frame, -200, 0), forTime: time - CGFloat(300))
        school.addKeyFrame(school.frame, forTime: time)
        school.addKeyFrame(topFrame, forTime: time + CGFloat(450))
        school.frame = CGRectOffset(school.frame, -200, 0)
        introView?.addElement(school)
        
        var lab = Link(frame: CGRect(x: view.frame.size.width - 90, y: view.frame.size.height - 180, width: linkSize, height: linkSize))
        lab.titleLabel.font = UIFont.systemFontOfSize(14)
        lab.text = "Lab"
        lab.detailText = "I've been heading a Apple Lab in my school for 2 years. We're a team growing every year (about 20 now), and we have one day every two weeks to learn, share and create cool things around iOS and Mac. This a really good experience for me to teach what I know about Swift, Objective-c or whatever to others student and help them building great apps. I'm happy to say that this year we're three to apply for the WWDC scholarship! (Damien Audrezet, Edouard Chusseau and me :)"
        lab.addKeyFrame(CGRectOffset(lab.frame, 200, 0), forTime: time - CGFloat(300))
        lab.addKeyFrame(lab.frame, forTime: time)
        lab.addKeyFrame(topFrame, forTime: time + CGFloat(450))
        lab.frame = CGRectOffset(lab.frame, 200, 0)
        introView?.addElement(lab)
        
        var fr = Link(frame: CGRect(x: 200, y: 170, width: linkSize, height: linkSize))
        fr.image = UIImage(named: "french-icon")
        fr.detailText = "I'm french, you know how our english accent is nice ;). I live in Bordeaux, well known for the wine 🍷"
        fr.addKeyFrame(CGRectOffset(fr.frame, 300, 0), forTime: time - CGFloat(300))
        fr.addKeyFrame(fr.frame, forTime: time)
        fr.addKeyFrame(topFrame, forTime: time + CGFloat(450))
        fr.frame = CGRectOffset(fr.frame, 300, 0)
        introView?.addElement(fr)
    }

}
