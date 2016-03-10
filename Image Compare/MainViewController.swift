//
//  ViewController.swift
//  Image Compare
//
//  Created by Vijay Chandran J on 02/03/16.
//  Copyright © 2016 Vijay Chandran J. All rights reserved.
//

import UIKit

/*
    View controller that displays two child view controllers, that are responsible for the core image operations
*/
class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.whiteColor()
        
        pictureViewController1 = PictureViewController()
        pictureViewController2 = PictureViewController()
        pictureViewController1.view.backgroundColor = UIColor.yellowColor()
        pictureViewController1?.view.frame = CGRectMake(
            0.0, c_STATUS_BAR_HEIGHT,
            self.view.frame.size.width, (self.view.frame.size.height - c_STATUS_BAR_HEIGHT) * 0.5
        )
        pictureViewController2?.view.frame = CGRectMake(
            0.0, pictureViewController1!.view.frame.origin.y + pictureViewController1!.view.frame.size.height,
            self.view.frame.size.width, (self.view.frame.size.height - c_STATUS_BAR_HEIGHT) * 0.5
        )
        
        self.addChildViewController(pictureViewController1!)
        self.addChildViewController(pictureViewController2!)
        
        self.view.addSubview(pictureViewController1!.view)
        self.view.addSubview(pictureViewController2!.view)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator);
        coordinator.animateAlongsideTransition({ (context) -> Void in
            
            
            if size.width > size.height {
                
                // * landscape
                self.pictureViewController1.frame = CGRectMake(0.0, self.statusBarHeight, size.width * 0.5, size.height);
                self.pictureViewController2.frame = CGRectMake(size.width * 0.5, self.statusBarHeight, size.width * 0.5, size.height)
            } else {
                
                // * portrait
                self.pictureViewController1.frame = CGRectMake(0.0, self.statusBarHeight, size.width, size.height * 0.5)
                self.pictureViewController2.frame = CGRectMake(0.0,
                    self.pictureViewController1.frame.origin.y + self.pictureViewController1.frame.size.height,
                    size.width, size.height * 0.5)
            }
            
            }) { (context) -> Void in
                
        }
    }
    
    private var pictureViewController1, pictureViewController2: PictureViewController!
    private var statusBarHeight: CGFloat = 20.0
    

}

