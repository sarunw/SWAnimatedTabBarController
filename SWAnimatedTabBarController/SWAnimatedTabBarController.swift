//
//  SWAnimatedTabBarController.swift
//  SWAnimatedTabBarController
//
//  Created by Sarun Wongpatcharapakorn on 4/23/15.
//  Copyright (c) 2015 Sarun Wongpatcharapakorn. All rights reserved.
//

import UIKit

public struct IconView {
    public var icon: UIImageView
    public var textLabel: UILabel
    public var badgeView: UIView
}

public class SWAnimatedTabBarController: UITabBarController {
    var containerView: UIView!
    var tabBarItemContainerViews = [UIView]()
    var iconViews: [IconView] = Array()
    let deselectedColor = UIColor(red: 146/255.0, green: 146/255.0, blue: 146/255.0, alpha: 1)
    var selectedColor: UIColor {
        return tabBar.tintColor
    }
    
    var animatedTabBarItemIndex: Int!
    var newImage: UIImage?
    var newTitle: String?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.createContainerView()
        self.createTabBarItems()
        self.setTabBarItemDelegate()
        self.delegate = self
    }
    
    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setIconViewAtIndex(self.selectedIndex, selected: true)
    }
    
    override public func viewDidLayoutSubviews() {
        println("view did load")
        containerView.frame = self.tabBar.bounds
//        var currentIndex = 0
//        for tabBarButton in self.tabBar.subviews {
//            println("tabBarButton \(tabBarButton)")
//            if tabBarButton.classForCoder.description() == "UITabBarButton" {
//                for subview in tabBarButton.subviews  {
//                    println("In tabbar button we have \(subview)")
//                    
//                    if subview.classForCoder.description() == "UITabBarButtonLabel" {
//                        if let label = subview as? UILabel {
//
//                        }
//                    }
//                    if subview.classForCoder.description() == "UITabBarSwappableImageView" {
//                        //                        println("sss \(subview)")
//                        //                        let view = UIView()
//                        //                        view.userInteractionEnabled = false
//                        //                        view.backgroundColor = UIColor.redColor()
//                        //                        view.frame = tabBarButton.bounds
//                        //                        tabBarButton.addSubview(view)
//                        //                        tabBarButton.insertSubview(view, aboveSubview: subview as! UIView)
//                    }
//                }
//            }
//        }
    }
    
    func setTabBarItemDelegate() {
        if let items = tabBar.items as? [UITabBarItem] {
            for item in items {
                if let customItem = item as? SWAnimatedTabBarItem {
                    customItem.delegate = self
                    customItem.transitionDelegate = self
                }
            }
        }
    }
    
    func createContainerView() {
        containerView = UIView()
        containerView.userInteractionEnabled = false
        containerView.backgroundColor = self.tabBar.backgroundColor
        containerView.backgroundColor = UIColor.whiteColor()
        containerView.frame = self.tabBar.bounds
        self.tabBar.addSubview(containerView)
        
        if let itemCount = tabBar.items?.count {
            var views = [String: UIView]()
            var formatString = "H:|"
            for index in 0..<itemCount {
                let tabBarItemContainerView = createTabBarItemContainer()
                
                tabBarItemContainerViews.append(tabBarItemContainerView)
                
                views["container\(index)"] = tabBarItemContainerView
                if index == 0 {
                    formatString += "-(0)-[container\(index)]"
                } else {
                    formatString += "-(0)-[container\(index)(==container0)]"
                }
            }
            formatString += "-(0)-|"
            println(formatString)
            let constraints = NSLayoutConstraint.constraintsWithVisualFormat(formatString, options: nil, metrics: nil, views: views)
            containerView.addConstraints(constraints)
        }
    }
    
    func createTabBarItemContainer() -> UIView {
        let tabBarItemContainerView = UIView()
        tabBarItemContainerView.userInteractionEnabled = false
        tabBarItemContainerView.setTranslatesAutoresizingMaskIntoConstraints(false)
        containerView.addSubview(tabBarItemContainerView)
        
        let views = ["view": tabBarItemContainerView]

        let vConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|", options: nil, metrics: nil, views: views)
        containerView.addConstraints(vConstraints)
        
        return tabBarItemContainerView
    }
    
    
    func createTabBarItems() {
        if let items = tabBar.items as? [UITabBarItem]
        {
            for (index, tabBarItem) in enumerate(items) {
                let container = tabBarItemContainerViews[index]
                
                // Icon, prefered 25x25 or 30x30 for circle
                let iconImageView = UIImageView()
                
                if let customItem = tabBarItem as? SWAnimatedTabBarItem,
                    let image = customItem.sw_image {
                    iconImageView.image = image.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
                } else {
                    iconImageView.image = tabBarItem.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
                }
                
                iconImageView.tintColor = deselectedColor
                iconImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
                
                // Text
                let textLabel = UILabel()
                textLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
                
                if let customItem = tabBarItem as? SWAnimatedTabBarItem,
                   let title = customItem.sw_title {
                    textLabel.text = title
                } else {
                    textLabel.text = tabBarItem.title
                }
                
                textLabel.textColor = deselectedColor
                textLabel.font = UIFont.systemFontOfSize(10)
                textLabel.textAlignment = .Center
                
                let badgeView = UIView()
                badgeView.layer.cornerRadius = 4
                badgeView.layer.masksToBounds = true
                badgeView.backgroundColor = selectedColor
                badgeView.userInteractionEnabled = false
                badgeView.setTranslatesAutoresizingMaskIntoConstraints(false)
                if let customItem = tabBarItem as? SWAnimatedTabBarItem {
                    badgeView.hidden = !customItem.badgeEnabled
                } else {
                    badgeView.hidden = (tabBarItem.badgeValue == nil) ? true : false
                }

        
                container.addSubview(badgeView)
                container.addSubview(iconImageView)
                container.addSubview(textLabel)
                
                createBadgeConstraints(badgeView, parent: container, centerXOffset: 18, yOffset: 11)
                createConstraints(iconImageView, parent: container, yOffset: 18)
                createConstraints(textLabel, parent: container, yOffset: 41)
                
                let iconView = IconView(icon: iconImageView, textLabel: textLabel, badgeView: badgeView)
                iconViews.append(iconView)
            }
        }
    }
    
    func createConstraints(view: UIView, parent: UIView, yOffset: CGFloat) {
        let hConstraint = NSLayoutConstraint(item: view, attribute: .CenterX, relatedBy: .Equal, toItem: parent, attribute: .CenterX, multiplier: 1, constant: 0)
        let vConstraint = NSLayoutConstraint(item: view, attribute: .CenterY, relatedBy: .Equal, toItem: parent, attribute: .Top, multiplier: 1, constant: yOffset)
        parent.addConstraint(hConstraint)
        parent.addConstraint(vConstraint)
    }
    
    func createBadgeConstraints(view: UIView, parent: UIView, centerXOffset: CGFloat, yOffset: CGFloat) {
        let hConstraint = NSLayoutConstraint(item: view, attribute: .CenterX, relatedBy: .Equal, toItem: parent, attribute: .CenterX, multiplier: 1, constant: centerXOffset)
        let vConstraint = NSLayoutConstraint(item: view, attribute: .CenterY, relatedBy: .Equal, toItem: parent, attribute: .Top, multiplier: 1, constant: yOffset)
        let widthConstraint = NSLayoutConstraint(item: view, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 8)
        let heightConstraint = NSLayoutConstraint(item: view, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 8)

        parent.addConstraints([widthConstraint, heightConstraint, hConstraint, vConstraint])
    }
    
    func setIconViewAtIndex(index: Int, selected: Bool) {
        let iconView = iconViews[index]
        setIconView(iconView, selected: selected)
    }
    
    func setIconView(iconView: IconView, selected: Bool) {
        let imageView = iconView.icon
        let textLabel = iconView.textLabel
        
        if selected {
            // deselect others
            if let items = self.tabBar.items as? [UITabBarItem] {
                for (index, tabBarItem) in enumerate(items) {
                    let iconView = iconViews[index]
                    let imageView = iconView.icon
                    let textLabel = iconView.textLabel
                    
                    imageView.tintColor = deselectedColor
                    textLabel.textColor = deselectedColor
                }
            }
        }
        
        let color = selected ? selectedColor : deselectedColor
        imageView.tintColor = color
        textLabel.textColor = color
    }

    func indexFromTabBarItem(item: UITabBarItem) -> Int? {
        if let items = self.tabBar.items as? AnyObject as? NSArray
        {
            let index = items.indexOfObject(item)
            return (index == NSNotFound) ? nil : index
        }
        
        return nil
    }
}

extension SWAnimatedTabBarController: UITabBarControllerDelegate {
    public func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        
        if let viewControllers = tabBarController.viewControllers as? AnyObject as? NSArray {
            let index = viewControllers.indexOfObject(viewController)
            if index != NSNotFound {
                let iconView = iconViews[index]
                setIconView(iconView, selected: true)
                
                if let customItem = viewController.tabBarItem as? SWAnimatedTabBarItem,
                   let animation = customItem.animation
                {
                    animation.selectedState(iconView)
                }
            }
        }
    }
}

extension SWAnimatedTabBarController: SWAnimatedTabBarItemContextTransitioning {
    public func imageView() -> UIImageView {
        let iconView = iconViews[animatedTabBarItemIndex]
        return iconView.icon
    }
    
    public func textLabel() -> UILabel {
        let iconView = iconViews[animatedTabBarItemIndex]
        return iconView.textLabel
    }
    
    public func imageForKey(key: SWAnimatedTabBarItemContextTransitioningImageKey) -> UIImage? {
        let iconView = iconViews[animatedTabBarItemIndex]

        switch key {
        case .OldImage: return iconView.icon.image
        case .NewImage: return self.newImage
        }
    }
    
    public func titleForKey(key: SWAnimatedTabBarItemContextTransitioningTitleKey) -> String? {
        let iconView = iconViews[animatedTabBarItemIndex]
        
        switch key {
        case .OldTitle: return iconView.textLabel.text
        case .NewTitle: return self.newTitle
        }
    }
    
    /**
    Notifies the system that the transition animation is done.
    */
    public func completeTransition() {
        let iconView = iconViews[animatedTabBarItemIndex]
        if let newImage = newImage {
            iconView.icon.image = newImage
        }
        
        if let newTitle = newTitle {
            iconView.textLabel.text = newTitle
        }
        
        newImage = nil
        newTitle = nil
    }
}

extension SWAnimatedTabBarController: SWAnimatedTabBarItemDelegate {
    public func tabBarItem(item: SWAnimatedTabBarItem, didChangeImage image: UIImage?, title: String?) {
        if let index = indexFromTabBarItem(item) {
            let iconView = iconViews[index]
            
            if let transitionDelegate = item.transitionDelegate {
                let context = self
                self.newImage = image
                self.newTitle = title
                transitionDelegate.animationControllerForChangedTabBarItem(item)?.animatedTransition(context)
            } else {
                // No animation just set it
                iconView.textLabel.text = title
                iconView.icon.image = image
            }
        }
    }
    
    public func tabBarItem(item: SWAnimatedTabBarItem, didChangeImage image: UIImage?) {
        if let index = indexFromTabBarItem(item) {
            let iconView = iconViews[index]
            
            if let transitionDelegate = item.transitionDelegate {
                let context = self
                self.newImage = image
                transitionDelegate.animationControllerForChangedTabBarItem(item)?.animatedTransition(context)
            } else {
                // No animation just set it
                iconView.icon.image = image
            }
        }
    }
    
    public func tabBarItem(item: SWAnimatedTabBarItem, didChangeTitle title: String?) {
        if let index = indexFromTabBarItem(item) {
            let iconView = iconViews[index]
            
            if let transitionDelegate = item.transitionDelegate {
                let context = self
                self.newTitle = title
                transitionDelegate.animationControllerForChangedTabBarItem(item)?.animatedTransition(context)
            } else {
                // No animation just set it
                iconView.textLabel.text = title
            }
        }
    }
    
    public func tabBarItem(item: SWAnimatedTabBarItem, didEnableBadge badgeEnabled: Bool) {
        if let index = indexFromTabBarItem(item) {
            let iconView = iconViews[index]
            if badgeEnabled {
                iconView.badgeView.alpha = 0
                iconView.badgeView.hidden = false
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    iconView.badgeView.alpha = 1
                    }, completion: nil)
            } else {
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    iconView.badgeView.alpha = 0
                    }, completion: { (finished) -> Void in
                        iconView.badgeView.hidden = true
                })
            }
        }
    }
}


extension SWAnimatedTabBarController: SWAnimatedTabBarItemTransitionDelegate {
    func animationControllerForChangedTabBarItem(tabBarItem: SWAnimatedTabBarItem) -> SWAnimatedTabBarItemAnimatedTransitioning? {
        if let index = indexFromTabBarItem(tabBarItem) {
            // This make we can use ! instead of ?
            animatedTabBarItemIndex = index
            return SWAnimator()
        } else {
            return nil
        }
    }
}