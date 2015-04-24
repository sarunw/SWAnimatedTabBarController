//
//  SWAnimator.swift
//  SWAnimatedTabBarController
//
//  Created by Sarun Wongpatcharapakorn on 4/24/15.
//  Copyright (c) 2015 Sarun Wongpatcharapakorn. All rights reserved.
//

import UIKit

class SWAnimator: SWAnimatedTabBarItemAnimatedTransitioning {
    func animatedTransition(transitionContext: SWAnimatedTabBarItemContextTransitioning) {
        let imageView = transitionContext.imageView()
        let textLabel = transitionContext.textLabel()
        
        if let newImage = transitionContext.imageForKey(.NewImage),
           let newTitle = transitionContext.titleForKey(.NewTitle)
        {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                imageView.transform = CGAffineTransformMakeScale(0.2, 0.2)
            }, completion: { (finished) -> Void in
                imageView.image = newImage
                
                UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.2, options: nil, animations: { () -> Void in
                    imageView.transform = CGAffineTransformIdentity
                }, completion: { (finished) -> Void in
                    transitionContext.completeTransition()
                })
            })
            
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                textLabel.alpha = 0
            }, completion: { (finished) -> Void in
                textLabel.text = newTitle
                
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    textLabel.alpha = 1
                    })
            })
        } else if let newImage = transitionContext.imageForKey(.NewImage) {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                imageView.transform = CGAffineTransformMakeScale(0.2, 0.2)
                }, completion: { (finished) -> Void in
                    imageView.image = newImage
                    
                    UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.2, options: nil, animations: { () -> Void in
                        imageView.transform = CGAffineTransformIdentity
                        }, completion: { (finished) -> Void in
                            transitionContext.completeTransition()
                    })
            })
        } else if let newTitle = transitionContext.titleForKey(.NewTitle) {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                textLabel.alpha = 0
                }, completion: { (finished) -> Void in
                    textLabel.text = newTitle
                    
                    UIView.animateWithDuration(0.3, animations: { () -> Void in
                        textLabel.alpha = 1
                    }, completion: { (finished) -> Void in
                        transitionContext.completeTransition()
                    })
            })
        } else {
            transitionContext.completeTransition()
        }
        
    }
}
