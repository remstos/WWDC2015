//
//  RSIntroView.swift
//  RSIntro
//
//  Created by Remi Santos on 15/01/15.
//  Copyright (c) 2015 Remi Santos. All rights reserved.
//

import UIKit


@objc protocol RSIntroViewDelegate {
    optional func introViewPageDidAppear(page:Int)
    optional func introViewPageWillDisappear(page:Int)
}

class RSIntroView: UIView,UIScrollViewDelegate {
    
    private var contentView:UIView!
    private var contentHeight:NSLayoutConstraint!
    private var contentWidth:NSLayoutConstraint!
    private var numberOfPages = 0
    private var elementViews:[RSIntroElement] = []

    /// The containing scrollView
    var scrollView:UIScrollView!
    /// Scroll direction
    var verticalScroll:Bool = true
    /// Visible page of the intro (readonly)
    private(set) var currentPage = 0 as Int
    /// Delegate for RSIntroViewDelegate
    var delegate:RSIntroViewDelegate?
    /// Enable/Disable paging
    var pagingEnabled:Bool = true {
        didSet {
            scrollView.pagingEnabled = pagingEnabled
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        
        scrollView = UIScrollView(frame: self.frame)
        scrollView.setTranslatesAutoresizingMaskIntoConstraints(false)
        scrollView.delegate = self
        scrollView.pagingEnabled = pagingEnabled
        self.addSubview(scrollView)
        let scrollH = NSLayoutConstraint.constraintsWithVisualFormat("H:|[scrollView]|", options: nil, metrics: nil, views: ["scrollView":scrollView])
        let scrollV = NSLayoutConstraint.constraintsWithVisualFormat("V:|[scrollView]|", options: nil, metrics: nil, views: ["scrollView":scrollView])
        self.addConstraints(scrollH+scrollV)
        
        contentView = UIView()
        contentView.setTranslatesAutoresizingMaskIntoConstraints(false)
        scrollView.addSubview(contentView)
        let contentH = NSLayoutConstraint.constraintsWithVisualFormat("H:|[content]|", options: nil, metrics: nil, views: ["content":contentView])
        let contentV = NSLayoutConstraint.constraintsWithVisualFormat("V:|[content]|", options: nil, metrics: nil, views: ["content":contentView])
        contentWidth = NSLayoutConstraint(item: contentView, attribute: .Width, relatedBy: .Equal, toItem: scrollView, attribute: .Width, multiplier: 1, constant:0)
        contentHeight = NSLayoutConstraint(item: contentView, attribute: .Height, relatedBy: .Equal, toItem: scrollView, attribute: .Height, multiplier: 1, constant:0)
        scrollView.addConstraints([contentWidth,contentHeight] + contentH + contentV)
    }
    
    /// Add a view to the intro that will handle moving
    /// between keyframes
    ///
    /// :param: elementView Element to add
    func addElement(elementView:RSIntroElement) {
        elementViews.append(elementView)
        elementView.introView = self
        self.addSubview(elementView)
    }
    
    /// Add a new page to the intro
    /// and update the scrollView size
    ///
    /// :param: view Page view
    /// :param: atIndex Index of the page
    func addPageWithView(view:UIView, atIndex index:Int) {
        numberOfPages++
        view.frame = scrollView.frame
        contentView.addSubview(view)
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        let w = NSLayoutConstraint(item: view, attribute: .Width, relatedBy: .Equal, toItem: scrollView, attribute: .Width, multiplier: 1, constant: 0)
        let h = NSLayoutConstraint(item: view, attribute: .Height, relatedBy: .Equal, toItem: scrollView, attribute: .Height, multiplier: 1, constant:0)
        scrollView.addConstraints([w,h])
        if verticalScroll {
            let top = NSLayoutConstraint(item: view, attribute: .Top, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1, constant: scrollView.frame.size.height * CGFloat(index))
            contentView.addConstraint(top)
            let leading = NSLayoutConstraint(item: view, attribute: .Leading, relatedBy: .Equal, toItem: contentView, attribute: .Leading, multiplier: 1, constant: 0)
            contentView.addConstraint(leading)
        } else {
            let leading = NSLayoutConstraint(item: view, attribute: .Leading, relatedBy: .Equal, toItem: contentView, attribute: .Leading, multiplier: 1, constant: scrollView.frame.size.width * CGFloat(index))
            contentView.addConstraint(leading)
            let top = NSLayoutConstraint(item: view, attribute: .Top, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1, constant: 0)
            contentView.addConstraint(top)
        }
        self.updateScrollViewContentSize()

    }
    
    /// Add a new page to the intro
    /// creating a RSIntroPage
    ///
    /// :param: title Title text shown on RSIntroPage
    /// :param: subtitle Subtitle text shown on RSIntroPage
    /// :param: image Image shown on RSIntroPage
    /// :param: atIndex Index of the page
    func addPageWithTitle(title:String?, subtitle:String?, image:UIImage?, atIndex:Int) {
        let view = RSIntroPage(introView: self)
        view.title = title
        view.subtitle = subtitle
        view.image = image
        self.addPageWithView(view, atIndex: atIndex)
    }
    
    func updateScrollViewContentSize(){
        if verticalScroll {
            scrollView.removeConstraint(contentHeight)
            contentHeight = NSLayoutConstraint(item: contentView, attribute: .Height, relatedBy: .Equal, toItem: scrollView, attribute: .Height, multiplier: CGFloat(numberOfPages), constant:0)
            scrollView.addConstraint(contentHeight)
        } else {
            scrollView.removeConstraint(contentWidth)
            contentWidth = NSLayoutConstraint(item: contentView, attribute: .Width, relatedBy: .Equal, toItem: scrollView, attribute: .Width, multiplier: CGFloat(numberOfPages), constant:0)
            scrollView.addConstraint(contentWidth)
        }
    }
    
    func scrollToNexPage(){
        if self.currentPage >= numberOfPages-1 {
            return
        }
        var offset = scrollView.contentOffset
        if verticalScroll {
            offset.y += self.frame.size.height
        } else {
            offset.x += self.frame.size.width
        }
        self.scrollView.setContentOffset(offset, animated: true)
    }
    
    func animateElementsForTime(time:CGFloat) {
        
        for element in elementViews {
            if element.times.count < 2 {
                continue
            }
            
            var interval = element.getIntervalFramesForTime(time)
            if interval.start == interval.end {
                element.frame = CGRectApplyAffineTransform(interval.start.frame, element.transform)
            } else {
                element.frame = CGRectApplyAffineTransform(element.getFrameWithInterval(interval, forTime: time), element.transform)
            }
            
            if element.timeHandler != nil {
                element.timeHandler!(time:time, element:element)
            }
        }
    }
    
    // MARK: - ScrollView delegate
    func getPageWithOffset(offset:CGPoint) -> Int {
        return verticalScroll ? Int(offset.y/self.frame.size.height) : Int(offset.x/self.frame.size.width)
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        var time = verticalScroll ? offset.y:offset.x
        animateElementsForTime(time)
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        currentPage = getPageWithOffset(offset)
        self.delegate?.introViewPageDidAppear?(currentPage)
    }
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        self.delegate?.introViewPageWillDisappear?(currentPage)
    }
}





