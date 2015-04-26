//
//  FirstViewController.swift
//  SWAnimatedTabBarController
//
//  Created by Sarun Wongpatcharapakorn on 4/23/15.
//  Copyright (c) 2015 Sarun Wongpatcharapakorn. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationController?.sw_animatedTabBarItem?.setAnimatedTitle("What wrong")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

