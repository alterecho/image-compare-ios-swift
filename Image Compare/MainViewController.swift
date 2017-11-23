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
        self.view.backgroundColor = UIColor.black
        
        pictureViewController1 = PictureViewController()
        pictureViewController2 = PictureViewController()
        pictureViewController1.view.backgroundColor = UIColor.yellow
        pictureViewController1?.view.frame = CGRect(
            x: 0.0, y: c_STATUS_BAR_HEIGHT,
            width: self.view.frame.size.width, height: (self.view.frame.size.height - c_STATUS_BAR_HEIGHT) * 0.5
        )
        pictureViewController2?.view.frame = CGRect(
            x: 0.0, y: pictureViewController1!.view.frame.origin.y + pictureViewController1!.view.frame.size.height,
            width: self.view.frame.size.width, height: (self.view.frame.size.height - c_STATUS_BAR_HEIGHT) * 0.5
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
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if #available(iOS 8.0, *) {
            super.viewWillTransition(to: size, with: coordinator)
        } else {
            // Fallback on earlier versions
        };
        coordinator.animate(alongsideTransition: { (context) -> Void in
            
            
            if size.width > size.height {
                
                // * landscape
                self.pictureViewController1.frame = CGRect(x: 0.0, y: self.statusBarHeight, width: size.width * 0.5, height: size.height);
                self.pictureViewController2.frame = CGRect(x: size.width * 0.5, y: self.statusBarHeight, width: size.width * 0.5, height: size.height)
            } else {
                
                // * portrait
                self.pictureViewController1.frame = CGRect(x: 0.0, y: self.statusBarHeight, width: size.width, height: size.height * 0.5)
                self.pictureViewController2.frame = CGRect(x: 0.0,
                    y: self.pictureViewController1.frame.origin.y + self.pictureViewController1.frame.size.height,
                    width: size.width, height: size.height * 0.5)
            }
            
            }) { (context) -> Void in
                
        }
    }
    
    /* iOS 7 and below */
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        super.willRotate(to: toInterfaceOrientation, duration: duration)
        if toInterfaceOrientation == UIInterfaceOrientation.landscapeLeft || toInterfaceOrientation == UIInterfaceOrientation.landscapeRight {
            
            // * landscape
            let ss = UIScreen.main.bounds.size
            let size = CGSize(width: ss.height, height: ss.width)
            self.pictureViewController1.frame = CGRect(x: 0.0, y: self.statusBarHeight, width: size.width * 0.5, height: size.height);
            self.pictureViewController2.frame = CGRect(x: size.width * 0.5, y: self.statusBarHeight, width: size.width * 0.5, height: size.height)
        } else {
            
            // * portrait
            let ss = UIScreen.main.bounds.size
            let size = CGSize(width: ss.width, height: ss.height)
            self.pictureViewController1.frame = CGRect(x: 0.0, y: self.statusBarHeight, width: size.width, height: size.height * 0.5)
            self.pictureViewController2.frame = CGRect(x: 0.0,
                y: self.pictureViewController1.frame.origin.y + self.pictureViewController1.frame.size.height,
                width: size.width, height: size.height * 0.5)
        }
    }
    
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    fileprivate var pictureViewController1, pictureViewController2: PictureViewController!
    fileprivate var statusBarHeight: CGFloat = 20.0
    

}

