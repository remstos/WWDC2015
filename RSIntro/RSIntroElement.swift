//
//  RSIntroElement.swift
//  BSIntro
//
//  Created by Remi Santos on 22/01/15.
//  Copyright (c) 2015 Remi Santos. All rights reserved.
//

import UIKit

class BYKeyFrameInterval:NSObject {
    var start:BYKeyFrame
    var end:BYKeyFrame
    init(start:BYKeyFrame, end:BYKeyFrame) {
        self.start = start
        self.end = end
        super.init()
    }
}
class BYKeyFrame:NSObject {
    var frame:CGRect
    var time:CGFloat
    init(frame:CGRect, time:CGFloat) {
        self.frame = frame
        self.time = time
        super.init()
    }
}


class RSIntroElement: UIView {
    
    var keyframes = [CGFloat:BYKeyFrame]()
    var times = [CGFloat]()
    var timeHandler:((time:CGFloat, element:RSIntroElement)->Void)?
    var introView: RSIntroView?
    
    init() {
        super.init(frame:CGRect.zeroRect)
        setup()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    func setup(){
        self.clipsToBounds = false
        userInteractionEnabled = false
    }
    func addKeyFrame(frame:CGRect, forTime time:CGFloat) {
        keyframes[time] = BYKeyFrame(frame: frame, time: time)
        addTime(time)
    }
    func addTimeHandlerWithBlock( block:(time:CGFloat, element:RSIntroElement)->Void) {
        timeHandler = block
    }
    private func addTime(time:CGFloat){
        times.append(time)
        times.sort { (a, b) -> Bool in
            return a < b
        }
    }
    
    func getFrameWithInterval(interval:BYKeyFrameInterval, forTime:CGFloat) -> CGRect{
        var frame = self.frame
        frame.origin.x = self.valueForTime(forTime, withStartTime: interval.start.time, endTime: interval.end.time, startValue: CGRectGetMinX(interval.start.frame), endValue: CGRectGetMinX(interval.end.frame))
        frame.origin.y = self.valueForTime(forTime, withStartTime: interval.start.time, endTime: interval.end.time, startValue: CGRectGetMinY(interval.start.frame), endValue: CGRectGetMinY(interval.end.frame))
        frame.size.width = self.valueForTime(forTime, withStartTime: interval.start.time, endTime: interval.end.time, startValue: CGRectGetWidth(interval.start.frame), endValue: CGRectGetWidth(interval.end.frame))
        frame.size.height = self.valueForTime(forTime, withStartTime: interval.start.time, endTime: interval.end.time, startValue: CGRectGetHeight(interval.start.frame), endValue: CGRectGetHeight(interval.end.frame))
        
        return frame
    }
    
    func getIntervalFramesForTime(forTime:CGFloat) -> BYKeyFrameInterval {
        var startTime:CGFloat = times.first!
        var endTime:CGFloat = times.last!
        var i = 0
        if forTime < startTime {
            endTime = startTime
        } else if forTime > endTime {
            startTime = endTime
        } else {
            for time in times {
                
                if i < times.count - 2 {
                    let nextTime = times[i+1]
                    if forTime >= time && forTime < nextTime {
                        startTime = time
                        endTime = nextTime
                        break
                    }
                } else if i > 0 {
                    startTime = times[i-1]
                }
                i++
            }
        }
        return BYKeyFrameInterval(start: keyframes[startTime]!, end:keyframes[endTime]!)
    }
    func valueForTime(time:CGFloat, withStartTime:CGFloat, endTime:CGFloat, startValue:CGFloat, endValue:CGFloat) -> CGFloat {
        let dt = (endTime - withStartTime);
        let timePassed = (time - withStartTime);
        let dv = (endValue - startValue);
        let vv = dv / dt;
        return (timePassed * vv) + startValue;
    }
    
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, withEvent: event)
        if(view == self && !userInteractionEnabled) { return nil }
        return view
    }
}
