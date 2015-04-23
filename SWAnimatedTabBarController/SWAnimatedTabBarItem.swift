//
//  SWAnimatedTabBarItem.swift
//  SWAnimatedTabBarController
//
//  Created by Sarun Wongpatcharapakorn on 23/4/15.
//  Copyright (c) 2015 Sarun Wongpatcharapakorn. All rights reserved.
//

import UIKit

@objc protocol SWAnimatedTabBarItemDelegate {
    func tabBarItem(item: SWAnimatedTabBarItem, didSetBadgeValue badgeValue: String?)
}

class SWAnimatedTabBarItem: UITabBarItem {
    
    var delegate: SWAnimatedTabBarItemDelegate?
    
    var _badgeValue: String?
    
    override var badgeValue: String? {
        get {
            return _badgeValue
        }
        
        set {
            self.delegate?.tabBarItem(self, didSetBadgeValue: newValue)
            _badgeValue = nil
        }
//        didSet {
//            self.delegate?.tabBarItem(self, didSetBadgeValue: badgeValue)
//            // HAX: swift bug causing recursive
//            // It cleary indicate here: https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Properties.html
//            // If you assign a value to a property within its own didSet observer, the new value that you assign will replace the one that was just set.
//            //badgeValue = nil
//        }
    }
}
