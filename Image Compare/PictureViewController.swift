//
//  PictureViewController.swift
//  Image Compare
//
//  Created by Vijay Chandran J on 02/03/16.
//  Copyright © 2016 Vijay Chandran J. All rights reserved.
//

import UIKit
import MobileCoreServices
import AssetsLibrary

/* 
     The core view controller that handles picking of image, showing image's metadata, and other operations
*/
class PictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let toolbarHeight: CGFloat = c_TOOL_BAR_HEIGHT
    
    // * manage frame of self.view, toolbar
    var frame: CGRect {
  
        get {
            return self.view.frame
        }
        
        set(value) {
            self.view.frame = value
            self._toolBar.frame = CGRectMake(0.0, 0.0, self.view.frame.size.width, c_TOOL_BAR_HEIGHT)
            _toolBar.barTintColor = UIColor.blackColor()
            _toolBar.tintColor = UIColor.whiteColor()
            _toolBar.translucent = true
            self._pictureView.toolBarHeight = self._toolBar.frame.size.height
        }
    }
    
    override func loadView() {
        if _pictureView == nil {
            _pictureView = PictureView()
        }
        self.view = _pictureView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // * toolbar
        self._toolBar = UIToolbar(frame: CGRectMake(0.0, 0.0, 0.0, 0.0))
        self.view.addSubview(_toolBar)
        
        // * toolbar items
        _addBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addButtonAction:")
        _cameraBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Camera, target: self, action: "cameraButtonAction:")
        _detailsBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Bookmarks, target: self, action: "compareButtonAction:")
        
        _cancelBarButtonItem = UIBarButtonItem(title: NSLocalizedString("close".localized, comment: "nil"), style: UIBarButtonItemStyle.Plain, target: self, action: "_hideDetails")
        
        let flexibleSpaceBarButtonItem = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        
        self._toolBar.setItems([_addBarButtonItem, flexibleSpaceBarButtonItem, _cameraBarButtonItem, flexibleSpaceBarButtonItem, _detailsBarButtonItem], animated: false)
        
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
        
            // * the pictureView will extract the image and metadata
        
        self._pictureView.set(imagePickerControllerMediaInfo: info)
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
        if let metaData = _pictureView.metaDataSet {    //* image has metadata
            
            if _detailsViewController == nil {
                _detailsViewController = DetailsViewController(pictureViewController: self)
            }
            
            _detailsViewController?.show(metaDataSet: metaData, inViewController: self)
            _detailsViewController?.set(dismissTarget: self, action: _hideDetails)
            
            let flexibleSpaceBarButtonItem = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
            _toolBar.setItems([flexibleSpaceBarButtonItem, _cancelBarButtonItem], animated: true)
        } else {        // * image has no metadata. show alert
            if #available(iOS 8.0, *) {
              
                let alertController = UIAlertController(title: "error".localized, message: "no_metadata".localized, preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "ok".localized, style: UIAlertActionStyle.Default, handler: { (alertAction) -> Void in
                    alertController.dismissViewControllerAnimated(true, completion: nil)
                }))
                self.presentViewController(alertController, animated: true, completion: nil)
                
            } else {
                // Fallback on earlier versions
                let alertView = UIAlertView(title: "error".localized, message: "no_metadata".localized, delegate: nil, cancelButtonTitle: "ok".localized)
                alertView.show()
            }
           
        
                
        }
        
        
    }
    
    /* not private, because it's used from outside (as action of bar button item) */
    func _hideDetails() {
        if let vc = _detailsViewController {
            vc.dismiss()
            let flexibleSpaceBarButtonItem = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
            _toolBar.setItems([_addBarButtonItem, flexibleSpaceBarButtonItem, _cameraBarButtonItem, flexibleSpaceBarButtonItem, _detailsBarButtonItem], animated: true)
        }
    }
    
    //MARK:- private
    private var _pictureView: PictureView!
    private var _toolBar: UIToolbar!
    private var _addBarButtonItem, _cameraBarButtonItem, _detailsBarButtonItem, _cancelBarButtonItem: UIBarButtonItem!
    private var _detailsViewController: DetailsViewController?

}
