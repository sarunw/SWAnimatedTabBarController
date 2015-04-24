//
//  SWPopAnimation.swift
//  SWAnimatedTabBarController
//
//  Created by Sarun Wongpatcharapakorn on 4/24/15.
//  Copyright (c) 2015 Sarun Wongpatcharapakorn. All rights reserved.
//

import UIKit

class SWPopAnimation: SWItemAnimation {
    override func playAnimation(iconView: IconView) {
        let animatedView = iconView.icon
        let frameDuration = 1.0/2
        let duration = 0.3
        let delay: NSTimeInterval = 0
        
        animatedView.transform = CGAffineTransformMakeScale(1, 1)
        UIView.animateKeyframesWithDuration(duration, delay: delay, options: nil, animations: { () -> Void in
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: frameDuration, animations: { () -> Void in
                animatedView.transform = CGAffineTransformMakeScale(1.2, 1.2)
            })
            UIView.addKeyframeWithRelativeStartTime(1 * frameDuration, relativeDuration: frameDuration, animations: { () -> Void in
                animatedView.transform = CGAffineTransformMakeScale(1, 1)
            })
            }, completion: nil)
    }
    
    override func selectedState(iconView: IconView) {
        self.playAnimation(iconView)
    }
}
