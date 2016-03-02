//
//  ViewController.swift
//  Image Compare
//
//  Created by Vijay Chandran J on 02/03/16.
//  Copyright © 2016 Vijay Chandran J. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.whiteColor()
        
        pictureViewController1 = PictureViewController()
        pictureViewController2 = PictureViewController()
        pictureViewController1?.view.frame = CGRectMake(0.0, 20.0, self.view.frame.size.width, self.view.frame.size.height * 0.5)
        pictureViewController2?.view.frame = CGRectMake(
            0.0,
            pictureViewController1!.view.frame.origin.y + pictureViewController1!.view.frame.size.height,
            self.view.frame.size.width,
            self.view.frame.size.height * 0.5)
        
        self.addChildViewController(pictureViewController1!)
        self.addChildViewController(pictureViewController2!)
        
        self.view.addSubview(pictureViewController1!.view)
        self.view.addSubview(pictureViewController2!.view)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private var pictureViewController1, pictureViewController2: PictureViewController?
    
    

}

