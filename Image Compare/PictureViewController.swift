//
//  PictureViewController.swift
//  Image Compare
//
//  Created by Vijay Chandran J on 02/03/16.
//  Copyright © 2016 Vijay Chandran J. All rights reserved.
//

import UIKit
import MobileCoreServices

class PictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // * manage frame of self.view, toolbar
    var frame: CGRect {
  
        get {
            return self.view.frame
        }
        
        set(value) {
            self.view.frame = value
            self.toolBar.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, 44.0)
        }
    }
    
    override func loadView() {
        self.view = pictureView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let obj = info[UIImagePickerControllerOriginalImage]
        if let image = obj as? UIImage {
            pictureView.image = image
        }
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //MARK: actions
    @IBAction func addButtonAction(button: UIBarButtonItem) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = [kUTTypeImage as String]
        imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func cameraButtonAction(button: UIBarButtonItem) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = [kUTTypeImage as String]
        imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
        imagePickerController.allowsEditing = true
        
        self.presentViewController(imagePickerController, animated: true, completion: nil)
        
    }
    
    @IBAction func compareButtonAction(button: UIBarButtonItem) {
        
    }
    
    //MARK: private
    private let pictureView: PictureView = PictureView()
    private var toolBar: UIToolbar!
    private var addBarButtonItem, cameraBarButtonItem, compareBarButtonItem: UIBarButtonItem!

}
