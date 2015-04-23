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
    
    override var badgeValue: String? {
        didSet {
            self.delegate?.tabBarItem(self, didSetBadgeValue: badgeValue)
        }
    }
}
