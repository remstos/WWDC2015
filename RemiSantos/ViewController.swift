//
//  ViewController.swift
//  RemiSantos
//
//  Created by Remi Santos on 29/03/15.
//  Copyright (c) 2015 Remi Santos. All rights reserved.
//

import UIKit


let A4Width = isIpad ? 400 : 200 as CGFloat
let A4Height = isIpad ? 566 : 283 as CGFloat

class ViewController: UIViewController,RSIntroViewDelegate {
    var introView:RSIntroView!
    
    var rectA:RSIntroElement!
    var rectC:Triangle!
    var rectD:Triangle!
    var rectE:Triangle!
    var rectF:Triangle!
    var rectG:RSIntroElement!
    var rectH:RSIntroElement!
    var slideView:UIImageView!
    var titles = ["Hello there!", "More about me", "Some projects", "See you there?!"]
    
    var firstAppear = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.clipsToBounds = true
        let bg = UIImageView(frame: self.view.frame)
        bg.image = UIImage(named:"origami_bg")
        bg.contentMode = .ScaleAspectFill
        bg.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        self.view.addSubview(bg)

        slideView = UIImageView(image: UIImage(named:"touch"))
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if firstAppear {
            buildIntro()
            Bubble.addBubblesToIntroView(introView, number: 80)
            buildTitleLabel()
            buildFolds()
            buildPages()
            introView.alpha = 0
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.introView.alpha = 1
            })
        }
        firstAppear = false
        slideView.layer.removeAllAnimations()
        let slideAnim = CAKeyframeAnimation(keyPath: "transform.translation.y")
        slideAnim.values = [170, 120, 70, 20]
        let alphaAnim = CAKeyframeAnimation(keyPath: "opacity")
        alphaAnim.values = [0, 1, 1, 0]
        let scaleAnim = CAKeyframeAnimation(keyPath: "transform.scale")
        scaleAnim.values = [0.6, 0.8, 0.8, 0.6]
        var groupAnim = CAAnimationGroup()
        groupAnim.animations = [slideAnim, alphaAnim, scaleAnim]
        groupAnim.duration = 1.5
        groupAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        groupAnim.repeatCount = Float.infinity
        slideView.layer.addAnimation(groupAnim, forKey: "slide")
        view.bringSubviewToFront(slideView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func buildIntro() {
        introView = RSIntroView(frame: self.view.frame)
        introView.backgroundColor = UIColor.clearColor()
        introView.delegate = self
        self.view.addSubview(introView)
        
    }
    func buildPages() {
        let page1 = RSIntroPage(introView: introView)
        page1.titleLabel.font = UIFont(name: "Avenir-Book", size: 14)
        if (isIpad) {
            page1.titleLabel.frame.origin.y += 200;
        }
        page1.title = "Here's my WWDC15 application.\nScroll down to see more"
        introView.addPageWithView(page1, atIndex:0)
        page1.addSubview(slideView)
        slideView.center = page1.center
        slideView.center.y = page1.frame.size.height - 200
        
        let page2 = self.storyboard?.instantiateViewControllerWithIdentifier("PageAboutVC") as? PageAboutViewController
        page2?.page = 2
        page2?.introView = introView
        introView.addPageWithView(page2!.view, atIndex:1)
        
        let page3 = self.storyboard?.instantiateViewControllerWithIdentifier("PageProjectVC") as? PageProjectsViewController
        introView.addPageWithView(page3!.view, atIndex:2)
        page3?.page = 3
        page3?.introView = introView
        
        let page4 = self.storyboard?.instantiateViewControllerWithIdentifier("PageWWDCVC") as? PageWWDCViewController
        introView.addPageWithView(page4!.view, atIndex:3)
        page4?.page = 4
        page4?.introView = introView
        
    }
    func buildFolds() {
        let pageHeight = self.view.frame.size.height
        rectA = RSIntroElement(frame: CGRect(x: 0, y: 0, width: A4Width, height: A4Height/2))
        rectA.backgroundColor = UIColor.whiteColor()
        rectA.shadowify()
        rectA.center = self.view.center
        rectA.center.y -= 80
        rectA.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        rectA.addKeyFrame(rectA.frame, forTime: 0)
        rectA.addKeyFrame(rectA.frame, forTime: pageHeight)
        rectA.addKeyFrame(rectA.frame, forTime: pageHeight*3)
        rectA.addKeyFrame(CGRectOffset(rectA.frame, 0, -500), forTime: pageHeight*4)
        rectA.layer.shadowOffset = CGSize(width: 1, height: -1)
        let fold1:UIView! = self.storyboard?.instantiateViewControllerWithIdentifier("Fold1").view!
        rectA.addSubview(fold1)
        fold1.frame = rectA.bounds
        introView.addElement(rectA)
        rectA.addTimeHandlerWithBlock { (time, element) -> Void in
            if(time < pageHeight) {
                element.hidden = false
                var flipV = CATransform3DIdentity
                flipV.m34 = 1 / -1000
                flipV = CATransform3DRotate(flipV, degree2radian(-180*(time/pageHeight)), 1, 0, 0)
                self.rectA.layer.transform = flipV
                if time > pageHeight/2 {
                    fold1.hidden = true
                } else {
                    fold1.hidden = false
                }
            } else {
                element.hidden = true
            }
        }
        
        
        rectC = Triangle(frame: CGRect(x: CGRectGetMinX(rectA.frame), y: CGRectGetMaxY(rectA.frame), width: A4Width/2, height: A4Width/2), orientation:.TopLeft)
        rectC.backgroundColor = UIColor.clearColor()
        rectC.addKeyFrame(rectC.frame, forTime: 0)
        rectC.addKeyFrame(rectC.frame, forTime: pageHeight*2)
        rectC.addKeyFrame(rectC.frame, forTime: pageHeight*3)
        rectC.addKeyFrame(CGRectOffset(rectC.frame, 0, -400), forTime: pageHeight*4)
        rectC.shadowify()
        introView.addElement(rectC)
        
        rectD = Triangle(frame: CGRect(x: CGRectGetMidX(rectA.frame), y: CGRectGetMaxY(rectA.frame), width: A4Width/2, height: A4Width/2), orientation:.TopRight)
        rectD.backgroundColor = UIColor.clearColor()
        rectD.shadowify()
        rectD.addKeyFrame(rectD.frame, forTime: 0)
        rectD.addKeyFrame(rectD.frame, forTime: pageHeight*2)
        rectD.addKeyFrame(rectD.frame, forTime: pageHeight*3)
        rectD.addKeyFrame(CGRectOffset(rectD.frame, 0, -400), forTime: pageHeight*4)
        rectD.addTimeHandlerWithBlock { (time, element) -> Void in
            if(time >= pageHeight && time <= pageHeight*3) {
                var identity = CATransform3DIdentity
                identity.m34 = 1 / -1000
                
                let percent = (time - pageHeight) / pageHeight
                var flipL = CATransform3DRotate(identity, degree2radian(max(-178,-150*percent)), 1, -1, 0)
                self.rectC.layer.transform = flipL
                let flipR = CATransform3DRotate(identity, degree2radian(max(-178,-150*percent)), 1, 1, 0)
                self.rectD.layer.transform = flipR
            }
        }
        introView.addElement(rectD)
        
        rectE = Triangle(frame: CGRect(x: CGRectGetMinX(rectA.frame), y: CGRectGetMaxY(rectA.frame), width: A4Width/2, height: A4Width/2), orientation:.BottomRight)
        rectE.backgroundColor = UIColor.clearColor()
        rectE.addKeyFrame(rectE.frame, forTime: 0)
        rectE.addKeyFrame(rectE.frame, forTime: pageHeight*2)
        rectE.addKeyFrame(rectE.frame, forTime: pageHeight*3)
        rectE.addKeyFrame(CGRectOffset(rectE.frame, 0, -400), forTime: pageHeight*4)
        introView.addElement(rectE)
        rectF = Triangle(frame: CGRect(x: CGRectGetMidX(rectA.frame), y: CGRectGetMaxY(rectA.frame), width: A4Width/2, height: A4Width/2), orientation:.BottomLeft)
        rectF.backgroundColor = UIColor.clearColor()
        rectF.addKeyFrame(rectF.frame, forTime: 0)
        rectF.addKeyFrame(rectF.frame, forTime: pageHeight)
        rectF.addKeyFrame(rectF.frame, forTime: pageHeight*2)
        rectF.addKeyFrame(rectF.frame, forTime: pageHeight*3)
        rectF.addKeyFrame(CGRectOffset(rectF.frame, 0, -400), forTime: pageHeight*4)
        introView.addElement(rectF)
        
        
        rectG = RSIntroElement(frame: CGRect(x: CGRectGetMinX(rectA.frame), y: CGRectGetMaxY(rectC.frame), width: A4Width, height: A4Height/2 - A4Width/2))
        rectG.backgroundColor = UIColor.whiteColor()
        rectG.shadowify()
        rectG.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        rectG.frame.origin.y = CGRectGetMaxY(rectC.frame)
        rectG.addKeyFrame(rectG.frame, forTime: 0)
        rectG.addKeyFrame(rectG.frame, forTime: pageHeight*3)
        rectG.addKeyFrame(rectG.frame, forTime: pageHeight*3)
        rectG.addKeyFrame(CGRectOffset(rectG.frame, 0, -400), forTime: pageHeight*4)
        introView.addElement(rectG)
        
        rectH = RSIntroElement(frame: rectG.frame)
        rectH.backgroundColor = UIColor.whiteColor()
        rectH.shadowify()
        rectH.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        rectH.frame.origin.y = CGRectGetMaxY(rectC.frame)
        rectH.addKeyFrame(rectH.frame, forTime: 0)
        rectH.addKeyFrame(rectH.frame, forTime: pageHeight*3)
        rectH.addKeyFrame(rectH.frame, forTime: pageHeight*3)
        rectH.addKeyFrame(CGRectOffset(rectH.frame, 0, -400), forTime: pageHeight*4)
        let wwdcTitle = UILabel(frame: rectG.bounds)
        wwdcTitle.text = "WWDC15"
        wwdcTitle.textAlignment = .Center
        wwdcTitle.font = UIFont(name: "Avenir-Roman", size: 30)
        wwdcTitle.layer.transform = CATransform3DMakeRotation(degree2radian(-180), 1, 0, 0)
        wwdcTitle.hidden = true
        rectG.addSubview(wwdcTitle)
        
        rectH.addTimeHandlerWithBlock { (time, element) -> Void in
            if(time > pageHeight*2 && time <= pageHeight*3) {
                let percent = (time - pageHeight*2) / pageHeight
                var identity = CATransform3DIdentity
                identity.m34 = 1 / -750
                let flipG = CATransform3DRotate(identity, degree2radian(140*percent), 1, 0, 0)
                self.rectG.layer.transform = flipG
                let flipH = CATransform3DRotate(identity, degree2radian(-160*percent), 1, 0, 0)
                self.rectH.layer.transform = flipH
                wwdcTitle.hidden = time < pageHeight*2.7 
            }
        }
        introView.addElement(rectH)
        
        introView.bringSubviewToFront(rectH)
        introView.bringSubviewToFront(rectG)
        introView.bringSubviewToFront(rectE)
        introView.bringSubviewToFront(rectF)
        introView.bringSubviewToFront(rectA)
    }
    
    func buildTitleLabel() {
        let margin = 20 as CGFloat
        let pageHeight = self.view.frame.size.height

        let titleLabel = UILabel(frame: CGRect(x: margin, y: margin + 10, width: introView.frame.size.width-margin*2, height: 100))
    
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.textAlignment = .Center
        titleLabel.numberOfLines = 0
        titleLabel.text = titles[0]
        titleLabel.font = UIFont(name: "Avenir-Book", size: 20)
        titleLabel.layer.shadowColor = UIColor.grayColor().CGColor
        titleLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        titleLabel.layer.shadowOpacity = 1
        titleLabel.layer.shadowRadius = 0
        titleLabel.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        let titleElement = RSIntroElement(frame: titleLabel.frame)
        titleLabel.frame.origin = CGPointZero
        titleElement.addSubview(titleLabel)
        introView.addElement(titleElement)
        let titleUp = CGRectApplyAffineTransform(titleElement.frame, CGAffineTransformMakeTranslation(0, -200))
        titleElement.addKeyFrame(titleElement.frame, forTime: 0)
        titleElement.addKeyFrame(titleUp, forTime: pageHeight*0.5)
        titleElement.addKeyFrame(CGRectOffset(titleElement.frame, 0, 40), forTime: pageHeight)
        titleElement.addKeyFrame(titleUp, forTime: pageHeight*1.5)
        titleElement.addKeyFrame(CGRectOffset(titleElement.frame, 0, 40), forTime: pageHeight*2)
        titleElement.addKeyFrame(titleUp, forTime: pageHeight*2.5)
        titleElement.addKeyFrame(CGRectOffset(titleElement.frame, 0, 40), forTime: pageHeight*3)
        titleElement.addTimeHandlerWithBlock { (time, element) -> Void in
            let page = Int((time + (pageHeight/2))/pageHeight)
            let text = self.titles[page]
            if titleLabel.text != text {
                titleLabel.text = text
            }
        }
    }
    func introViewPageDidAppear(page: Int) {
        
    }
    
}

func degree2radian(a:CGFloat)->CGFloat {
    let b = CGFloat(M_PI) * a/180
    return b
}
