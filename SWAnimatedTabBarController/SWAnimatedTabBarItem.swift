//
//  SWAnimatedTabBarItem.swift
//  SWAnimatedTabBarController
//
//  Created by Sarun Wongpatcharapakorn on 23/4/15.
//  Copyright (c) 2015 Sarun Wongpatcharapakorn. All rights reserved.
//

import UIKit

@objc public protocol SWAnimatedTabBarItemDelegate {
    func tabBarItem(item: SWAnimatedTabBarItem, didEnableBadge badgeEnabled: Bool)
    func tabBarItem(item: SWAnimatedTabBarItem, didChangeTitle title: String?)
    func tabBarItem(item: SWAnimatedTabBarItem, didChangeImage image: UIImage?)
    func tabBarItem(item: SWAnimatedTabBarItem, didChangeImage image: UIImage?, title: String?)
}


public protocol SWAnimatedTabBarItemAnimation {
    
    func playAnimation(iconView: IconView)
    func selectedState(iconView: IconView)
}

public class SWItemAnimation: NSObject, SWAnimatedTabBarItemAnimation {
    
    public func playAnimation(iconView: IconView) {
        
    }
    
    public func selectedState(iconView: IconView) {
        
    }
}

// MARK: Animation
public enum SWAnimatedTabBarItemContextTransitioningImageKey {
    case OldImage
    case NewImage
}

public enum SWAnimatedTabBarItemContextTransitioningTitleKey {
    case OldTitle
    case NewTitle
}

/**
*  Context used in animation
*/
public protocol SWAnimatedTabBarItemContextTransitioning {
    func imageView() -> UIImageView
    func textLabel() -> UILabel
    
    func imageForKey(key: SWAnimatedTabBarItemContextTransitioningImageKey) -> UIImage?
    func titleForKey(key: SWAnimatedTabBarItemContextTransitioningTitleKey) -> String?

    /**
        Notifies the system that the transition animation is done.
    */
    func completeTransition()
}

protocol SWAnimatedTabBarItemAnimatedTransitioning {
    func animatedTransition(transitionContext: SWAnimatedTabBarItemContextTransitioning)
}


protocol SWAnimatedTabBarItemTransitionDelegate: class {
    func animationControllerForChangedTabBarItem(
        tabBarItem: SWAnimatedTabBarItem) -> SWAnimatedTabBarItemAnimatedTransitioning?
}

public class SWAnimatedTabBarItem: UITabBarItem {
    
    weak var delegate: SWAnimatedTabBarItemDelegate?
    weak var transitionDelegate: SWAnimatedTabBarItemTransitionDelegate?
    
    @IBOutlet public weak var animation: SWItemAnimation?
    
    @IBInspectable public var badgeEnabled: Bool = false {
        didSet {
            self.delegate?.tabBarItem(self, didEnableBadge: badgeEnabled)
        }
    }
    
    @IBInspectable public var sw_title: String? {
        didSet {
            self.delegate?.tabBarItem(self, didChangeTitle: sw_title)
        }
    }
    
    @IBInspectable public var sw_image: UIImage? {
        didSet {
            self.delegate?.tabBarItem(self, didChangeImage: sw_image)
        }
    }
    
    public override func setAnimated(image: UIImage?, title: String?) {
        let templateImage = image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        self.delegate?.tabBarItem(self, didChangeImage: templateImage, title: title)
    }
    
    public override func setAnimatedBadgeHidden(hidden: Bool) {
        self.badgeEnabled = !hidden
    }
    
    public override func setAnimatedTitle(title: String?) {
        self.sw_title = title
    }
    
    public override func setAnimatedImage(image: UIImage?) {
        let templateImage = image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        self.sw_image = templateImage
    }
    
    // TODO: wait until Apple fix this to use this
//    override var badgeValue: String? {
//        didSet {
//            self.delegate?.tabBarItem(self, didSetBadgeValue: badgeValue)
//            // HAX: swift bug causing recursive
//            // It cleary indicate here: https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Properties.html
//            // If you assign a value to a property within its own didSet observer, the new value that you assign will replace the one that was just set.
//            //badgeValue = nil
//        }
//    }
}

public extension UITabBarItem {
    public func setAnimatedBadgeHidden(hidden: Bool) {
    }
    
    public func setAnimatedTitle(title: String?) {
    }
    
    public func setAnimatedImage(image: UIImage?) {
    }
    
    public func setAnimated(image: UIImage?, title: String?) {        
    }
}


