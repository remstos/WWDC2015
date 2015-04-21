//
//  UIView+Extension.swift
//  RemiSantos
//
//  Created by Remi Santos on 20/04/15.
//  Copyright (c) 2015 Remi Santos. All rights reserved.
//

import UIKit

extension UIView {

    func addParallaxEffectWithIntensity(intensity:CGFloat) {

        let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y",
            type: .TiltAlongVerticalAxis)
        verticalMotionEffect.minimumRelativeValue = -intensity
        verticalMotionEffect.maximumRelativeValue = intensity
        
        let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x",
            type: .TiltAlongHorizontalAxis)
        horizontalMotionEffect.minimumRelativeValue = -intensity
        horizontalMotionEffect.maximumRelativeValue = intensity
        
        let group = UIMotionEffectGroup()
        group.motionEffects = [horizontalMotionEffect, verticalMotionEffect]
        
        self.addMotionEffect(group)
    }
    
}
