//
//  Bubble.swift
//  RemiSantos
//
//  Created by Remi Santos on 16/04/15.
//  Copyright (c) 2015 Remi Santos. All rights reserved.
//

import UIKit
private let maxBubbleSize = 30
private let minBubbleSize = 5

class Bubble: RSIntroElement {
   
    class func addBubblesToIntroView(introView:RSIntroView, number:Int) {
        
        for i in 0..<number {
            let size = randInRange(minBubbleSize...maxBubbleSize)
            let x = randInRange(0...Int(introView.frame.size.width))
            let y = randInRange(0...Int(introView.frame.size.height*4))
            let bubble = Bubble(frame: CGRect(x: x, y: y, width: size, height: size))
            bubble.addKeyFrame(bubble.frame, forTime: 0)
            let translateY = CGFloat(randInRange(y...y*2))
            bubble.addKeyFrame(CGRectApplyAffineTransform(bubble.frame, CGAffineTransformMakeTranslation(0, -translateY)), forTime: CGFloat(y))
            introView.addElement(bubble)
        }
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        buildView()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildView() {
        self.layer.cornerRadius = self.frame.size.width / 5
        self.backgroundColor = UIColor(white: 1, alpha: 0.9)
        self.layer.borderColor = UIColor.whiteColor().CGColor
        self.layer.borderWidth = 2
        self.alpha = 0.5
        
        self.addParallaxEffectWithIntensity(self.frame.size.width)
    }
}

func randInRange(range: Range<Int>) -> Int {
    return  Int(arc4random_uniform(UInt32(range.endIndex - range.startIndex))) + range.startIndex
}