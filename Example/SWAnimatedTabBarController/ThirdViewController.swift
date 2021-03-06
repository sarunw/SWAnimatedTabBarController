//
//  ThirdViewController.swift
//  SWAnimatedTabBarController
//
//  Created by Sarun Wongpatcharapakorn on 24/4/15.
//  Copyright (c) 2015 Sarun Wongpatcharapakorn. All rights reserved.
//

import UIKit
import SWAnimatedTabBarController

class ThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.sw_animatedTabBarItem?.setAnimatedBadgeHidden(false)
        self.sw_animatedTabBarItem?.setAnimatedTitle("New Third")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func buttonTapped(sender: AnyObject) {
        let image = UIImage(named: "first")
        
        self.sw_animatedTabBarItem?.setAnimatedImage(image)
    }
    
    @IBAction func changeBothTapped(sender: AnyObject) {
        let image = UIImage(named: "first")
        
        self.sw_animatedTabBarItem?.setAnimated(image, title: "Change Third")
    }
    @IBAction func changeTitleTapped(sender: AnyObject) {
        self.sw_animatedTabBarItem?.setAnimatedTitle("Only Third")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
