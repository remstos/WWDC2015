//
//  Link.swift
//  RemiSantos
//
//  Created by Remi Santos on 19/04/15.
//  Copyright (c) 2015 Remi Santos. All rights reserved.
//

import UIKit

class Link: RSIntroElement {
    
    var text:String? {
        didSet {
            titleLabel.text = text
        }
    }
    
    var image:UIImage? {
        didSet {
            imageView.image = image
        }
    }
    private var titleLabel: UILabel!
    private var imageView: UIImageView!
    
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        buildView()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildView() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor(white: 1, alpha: 0.9)
        self.layer.borderColor = UIColor.whiteColor().CGColor
        
        titleLabel = UILabel(frame: self.frame)
        titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        titleLabel.font = UIFont(name: "Avenir-Book", size: 14)
        titleLabel.textColor = UIColor.blackColor()
        addSubview(titleLabel)
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[title]|", options: .allZeros, metrics: nil, views: ["title":titleLabel]))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[title]|", options: .allZeros, metrics: nil, views: ["title":titleLabel]))

        imageView = UIImageView(frame: self.frame)
        imageView.contentMode = .ScaleAspectFill
        imageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        addSubview(imageView)
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[imageView]|", options: .allZeros, metrics: nil, views: ["imageView":imageView]))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[imageView]|", options: .allZeros, metrics: nil, views: ["imageView":imageView]))
        
    }

    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesBegan(touches, withEvent: event)
        self.alpha = 0.7
    }
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        super.touchesEnded(touches, withEvent: event)
        self.alpha = 1
    }
}
