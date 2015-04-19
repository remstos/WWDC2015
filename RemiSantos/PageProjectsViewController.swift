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
        var captain = Link(frame: CGRect(x: 40, y: 150, width: linkSize+10, height: linkSize+10))
        captain.image = UIImage(named: "captain-icon")
        captain.addKeyFrame(CGRectOffset(captain.frame, -200, 0), forTime: time - CGFloat(300))
        captain.addKeyFrame(captain.frame, forTime: time)
        captain.addKeyFrame(CGRectOffset(captain.frame, -200, 0), forTime: time + CGFloat(300))
        captain.frame = CGRectOffset(captain.frame, -200, 0)
        introView?.addElement(captain)
        
        var sofa = Link(frame: CGRect(x: view.frame.size.width - 100, y: 250, width: linkSize, height: linkSize))
        sofa.image = UIImage(named: "sofa-icon")
        sofa.addKeyFrame(CGRectOffset(sofa.frame, 200, 0), forTime: time - CGFloat(300))
        sofa.addKeyFrame(sofa.frame, forTime: time)
        sofa.addKeyFrame(CGRectOffset(sofa.frame, 200, 0), forTime: time + CGFloat(300))
        sofa.frame = CGRectOffset(sofa.frame, 200, 0)
        introView?.addElement(sofa)
        
        var drawl = Link(frame: CGRect(x: view.frame.size.width - 150, y: view.frame.size.height - 200, width: linkSize+5, height: linkSize+5))
        drawl.image = UIImage(named: "drawl-icon")
        drawl.addKeyFrame(CGRectOffset(drawl.frame, 250, 0), forTime: time - CGFloat(300))
        drawl.addKeyFrame(drawl.frame, forTime: time)
        drawl.addKeyFrame(CGRectOffset(drawl.frame, 250, 0), forTime: time + CGFloat(300))
        drawl.frame = CGRectOffset(drawl.frame, 250, 0)
        introView?.addElement(drawl)

        var loopse = Link(frame: CGRect(x: 100, y: view.frame.size.height - 150, width: linkSize, height: linkSize))
        loopse.image = UIImage(named: "loopse-icon")
        loopse.addKeyFrame(CGRectOffset(loopse.frame, -250, 0), forTime: time - CGFloat(300))
        loopse.addKeyFrame(loopse.frame, forTime: time)
        loopse.addKeyFrame(CGRectOffset(loopse.frame, -250, 0), forTime: time + CGFloat(300))
        loopse.frame = CGRectOffset(loopse.frame, -250, 0)
        introView?.addElement(loopse)

        var peekaboo = Link(frame: CGRect(x: 30, y: view.frame.size.height - 80, width: linkSize, height: linkSize))
        peekaboo.image = UIImage(named: "peekaboo-icon")
        peekaboo.addKeyFrame(CGRectOffset(peekaboo.frame, -150, 0), forTime: time - CGFloat(300))
        peekaboo.addKeyFrame(peekaboo.frame, forTime: time)
        peekaboo.addKeyFrame(CGRectOffset(peekaboo.frame, -2-150, 0), forTime: time + CGFloat(300))
        peekaboo.frame = CGRectOffset(peekaboo.frame, -150, 0)
        introView?.addElement(peekaboo)
    }
}
