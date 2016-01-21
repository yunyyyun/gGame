//
//  ViewController.swift
//  GravityGame
//
//  Created by mengyun on 16/1/17.
//  Copyright © 2016年 mengyun. All rights reserved.
//

import UIKit

class ViewController: UINavigationController {
    var gameViewController: GameViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        gameViewController = GameViewController()
        self.addChildViewController(gameViewController)
        view.addSubview(gameViewController.view)
        self.navigationBarHidden=true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

