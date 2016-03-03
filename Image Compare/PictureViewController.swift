//
//  PictureViewController.swift
//  Image Compare
//
//  Created by Vijay Chandran J on 02/03/16.
//  Copyright © 2016 Vijay Chandran J. All rights reserved.
//

import UIKit

class PictureViewController: UIViewController {
    
    // * manage frame of self.view, toolbar
    var frame: CGRect {
  
        get {
            return self.view.frame
        }
        
        set(value) {
            self.view.frame = value
            self.toolBar.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, 30.0)
        }
    }
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.yellowColor()
        
        // * toolbar
        self.toolBar = UIToolbar(frame: CGRectMake(0.0, 0.0, 0.0, 0.0))
        self.view.addSubview(toolBar)
        
        // * toolbar items
        addBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addButtonAction:")
        cameraBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Camera, target: self, action: "cameraButtonAction:")
        compareBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Bookmarks, target: self, action: "compareButtonAction:")
        
        let flexibleSpaceBarButtonItem = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        
        self.toolBar.setItems([addBarButtonItem, flexibleSpaceBarButtonItem, cameraBarButtonItem, flexibleSpaceBarButtonItem, compareBarButtonItem], animated: false)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.frame = self.view.frame
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: actions
    @IBAction func addButtonAction(button: UIBarButtonItem) {
        
    }
    
    @IBAction func cameraButtonAction(button: UIBarButtonItem) {
        
    }
    
    @IBAction func compareButtonAction(button: UIBarButtonItem) {
        
    }
    
    //MARK: private
    private var toolBar: UIToolbar!
    private var addBarButtonItem, cameraBarButtonItem, compareBarButtonItem: UIBarButtonItem!

}
