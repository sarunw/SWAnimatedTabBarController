//
//  SWAnimatedTabBarController.swift
//  SWAnimatedTabBarController
//
//  Created by Sarun Wongpatcharapakorn on 4/23/15.
//  Copyright (c) 2015 Sarun Wongpatcharapakorn. All rights reserved.
//

import UIKit

struct IconView {
    var icon: UIImageView
    var textLabel: UILabel
}

class SWAnimatedTabBarController: UITabBarController {
    var containerView: UIView!
    var tabBarItemContainerViews = [UIView]()
    var iconViews: [IconView] = Array()
    let deselectedColor = UIColor(red: 146/255.0, green: 146/255.0, blue: 146/255.0, alpha: 1)
    var selectedColor: UIColor {
        return tabBar.tintColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createContainerView()
        self.createTabBarItems()
        self.delegate = self
        
        setIconViewAtIndex(0, selected: true)
    }
    
    override func viewDidLayoutSubviews() {
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
        if let itemCount = tabBar.items?.count,
           let items = tabBar.items as? [UITabBarItem]
        {
            for (index, tabBarItem) in enumerate(items) {
                let container = tabBarItemContainerViews[index]
                
                // Icon, prefered 25x25 or 30x30 for circle
                let iconImageView = UIImageView()
                iconImageView.image = tabBarItem.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
                iconImageView.tintColor = deselectedColor
                iconImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
                
                // Text
                let textLabel = UILabel()
                textLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
                textLabel.text = tabBarItem.title
                textLabel.textColor = deselectedColor
                textLabel.font = UIFont.systemFontOfSize(10)
                textLabel.textAlignment = .Center
        
                container.addSubview(iconImageView)
                container.addSubview(textLabel)
                
                createConstraints(iconImageView, parent: container, yOffset: 18)
                createConstraints(textLabel, parent: container, yOffset: 41)
                
                let iconView = IconView(icon: iconImageView, textLabel: textLabel)
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

}

extension SWAnimatedTabBarController: UITabBarControllerDelegate {
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        
        if let viewControllers = tabBarController.viewControllers as? AnyObject as? NSArray {
            let index = viewControllers.indexOfObject(viewController)
            if index != NSNotFound {
                let iconView = iconViews[index]
                setIconView(iconView, selected: true)
            }
        }
    }
    
    
}
