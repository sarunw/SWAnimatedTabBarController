//
//  SWAnimatedTabBarItem.swift
//  SWAnimatedTabBarController
//
//  Created by Sarun Wongpatcharapakorn on 23/4/15.
//  Copyright (c) 2015 Sarun Wongpatcharapakorn. All rights reserved.
//

import UIKit

@objc protocol SWAnimatedTabBarItemDelegate {
    func tabBarItem(item: SWAnimatedTabBarItem, didEnableBadge badgeEnabled: Bool)
    func tabBarItem(item: SWAnimatedTabBarItem, didChangeTitle title: String?)
    func tabBarItem(item: SWAnimatedTabBarItem, didChangeImage image: UIImage?)
}

protocol SWAnimatedTabBarItemAnimation {
    
    func playAnimation(iconView: IconView)
    func selectedState(iconView: IconView)
}

class SWItemAnimation: NSObject, SWAnimatedTabBarItemAnimation {
    
    func playAnimation(iconView: IconView) {
        
    }
    
    func selectedState(iconView: IconView) {
        
    }
}

class SWAnimatedTabBarItem: UITabBarItem {
    
    var delegate: SWAnimatedTabBarItemDelegate?
    @IBOutlet weak var animation: SWItemAnimation?
    
    @IBInspectable var badgeEnabled: Bool = false {
        didSet {
            self.delegate?.tabBarItem(self, didEnableBadge: badgeEnabled)
        }
    }
    
    @IBInspectable var sw_title: String? {
        didSet {
            self.delegate?.tabBarItem(self, didChangeTitle: sw_title)
        }
    }
    
    @IBInspectable var sw_image: UIImage? {
        didSet {
            self.delegate?.tabBarItem(self, didChangeImage: sw_image)
        }
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

extension UITabBarItem {
    func setAnimatedBadgeHidden(hidden: Bool) {
        if let customItem = self as? SWAnimatedTabBarItem {
            customItem.badgeEnabled = !hidden
        }
    }
    
    func setAnimatedTitle(title: String?) {
        if let customItem = self as? SWAnimatedTabBarItem {
            customItem.sw_title = title
        }
    }
    
    func setAnimatedImage(image: UIImage?) {
        if let customItem = self as? SWAnimatedTabBarItem {
            let templateImage = image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            customItem.sw_image = templateImage
        }
    }
}


