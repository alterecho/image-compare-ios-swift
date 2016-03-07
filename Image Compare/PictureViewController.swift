//
//  PictureViewController.swift
//  Image Compare
//
//  Created by Vijay Chandran J on 02/03/16.
//  Copyright © 2016 Vijay Chandran J. All rights reserved.
//

import UIKit
import MobileCoreServices

/* 
     The core view controller that handles picking of image, and other operations
*/
class PictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let toolbarHeight: CGFloat = 44.0
    
    // * manage frame of self.view, toolbar
    var frame: CGRect {
  
        get {
            return self.view.frame
        }
        
        set(value) {
            self.view.frame = value
            self._toolBar.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, 44.0)
            self._pictureView.toolBarHeight = self._toolBar.frame.size.height
        }
    }
    
    override func loadView() {
        self.view = _pictureView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // * toolbar
        self._toolBar = UIToolbar(frame: CGRectMake(0.0, 0.0, 0.0, 0.0))
        self._toolBar.alpha = 0.25
        self.view.addSubview(_toolBar)
        
        // * toolbar items
        _addBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addButtonAction:")
        _cameraBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Camera, target: self, action: "cameraButtonAction:")
        _compareBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Bookmarks, target: self, action: "compareButtonAction:")
        
        let flexibleSpaceBarButtonItem = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        
        self._toolBar.setItems([_addBarButtonItem, flexibleSpaceBarButtonItem, _cameraBarButtonItem, flexibleSpaceBarButtonItem, _compareBarButtonItem], animated: false)
        
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
    
    //MARK:- UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let obj = info[UIImagePickerControllerOriginalImage]
        if let image = obj as? UIImage {
            _pictureView.image = image
        }
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //MARK:- actions
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
        self._showDetails()
    }
    
    private func _showDetails() {
        if _detailsViewController == nil {
            _detailsViewController = DetailsViewController(pictureViewController: self)
        }
        
        _detailsViewController?.show(inViewController: self)
        _detailsViewController?.setTarget(self, action: "_hideDetails")
        
    }
    
    /* not private, because it's used from outside (as action of bar button item) */
    func _hideDetails() {
        if let vc = _detailsViewController {
            vc.dismiss()
        }
    }
    
    //MARK: private
    private let _pictureView: PictureView = PictureView()
    private var _toolBar: UIToolbar!
    private var _addBarButtonItem, _cameraBarButtonItem, _compareBarButtonItem: UIBarButtonItem!
    private var _detailsViewController: DetailsViewController?

}
