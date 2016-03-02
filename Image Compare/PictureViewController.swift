//
//  PictureViewController.swift
//  Image Compare
//
//  Created by Vijay Chandran J on 02/03/16.
//  Copyright © 2016 Vijay Chandran J. All rights reserved.
//

import UIKit

class PictureViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellowColor()
        self.toolBar = UIToolbar(frame: CGRectMake(0.0, 0.0, 0.0, 0.0))
        self.view.addSubview(toolBar!)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.toolBar?.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, 30.0)
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        coordinator.animateAlongsideTransition({ (context) -> Void in
            print(self.view)
            self.toolBar?.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, 30.0)
            }) { (context) -> Void in
                
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private var toolBar: UIToolbar?

}
