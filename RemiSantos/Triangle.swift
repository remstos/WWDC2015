//
//  Triangle.swift
//  OrigamiHat
//
//  Created by Remi Santos on 03/02/15.
//  Copyright (c) 2015 Remi Santos. All rights reserved.
//

import UIKit

enum TriangleOrientation:Int {
    case TopRight
    case TopLeft
    case BottomLeft
    case BottomRight
}

extension UIView {
    func shadowify() {
        self.layer.shadowColor = UIColor(white: 0.3, alpha: 0.4).CGColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
}
class Triangle: RSIntroElement {

    var orientation:TriangleOrientation = .TopRight
    init(frame: CGRect, orientation:TriangleOrientation) {
        super.init(frame:frame)
        self.orientation = orientation
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect) {

        let ctx = UIGraphicsGetCurrentContext();
        
        CGContextBeginPath(ctx);
        if orientation == .TopLeft {
            CGContextMoveToPoint   (ctx, CGRectGetMinX(rect), CGRectGetMinY(rect));  // top left
            CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMinY(rect));  // top right
            CGContextAddLineToPoint(ctx, CGRectGetMinX(rect), CGRectGetMaxY(rect));  // bottom left
        } else if orientation == .TopRight{
            CGContextMoveToPoint   (ctx, CGRectGetMinX(rect), CGRectGetMinY(rect));  // top left
            CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMinY(rect));  // top right
            CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));  // bottom right
        } else if orientation == .BottomLeft{
            CGContextMoveToPoint   (ctx, CGRectGetMinX(rect), CGRectGetMinY(rect));  // top left
            CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));  // bottom right
            CGContextAddLineToPoint(ctx, CGRectGetMinX(rect), CGRectGetMaxY(rect));  // bottom left
        } else if orientation == .BottomRight{
            CGContextMoveToPoint   (ctx, CGRectGetMinX(rect), CGRectGetMaxY(rect));  // bottom left
            CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMinY(rect));  // top right
            CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));  // bottom right
        }
        UIColor.whiteColor().setFill()
        CGContextClosePath(ctx);
        
        CGContextFillPath(ctx);
    }

}
