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
            self._toolBar.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: c_TOOL_BAR_HEIGHT)
            _toolBar.barTintColor = UIColor.black
            _toolBar.tintColor = UIColor.white
            _toolBar.isTranslucent = true
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
        self._toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: 0.0))
        self.view.addSubview(_toolBar)
        
        // * toolbar items
        _addBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(PictureViewController.addButtonAction(_:)))
        _cameraBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(PictureViewController.cameraButtonAction(_:)))
        _detailsBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(PictureViewController.compareButtonAction(_:)))
        _detailsBarButtonItem.isEnabled = false
        
        _cancelBarButtonItem = UIBarButtonItem(title: NSLocalizedString("close".localized, comment: "nil"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(PictureViewController._hideDetails))
        
        let flexibleSpaceBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        self._toolBar.setItems([_addBarButtonItem, flexibleSpaceBarButtonItem, _cameraBarButtonItem, flexibleSpaceBarButtonItem, _detailsBarButtonItem], animated: false)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.frame = self.view.frame
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
            // * the pictureView will extract the image and metadata
        
        if self._pictureView.set(imagePickerControllerMediaInfo: info as [String : AnyObject]).0 {  // * if image was extracted from the info
            _detailsBarButtonItem.isEnabled = true
        } else {    // * no image. disable details button
            _detailsBarButtonItem.isEnabled = false
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK:- actions
    @IBAction func addButtonAction(_ button: UIBarButtonItem) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = [kUTTypeImage as String]
        imagePickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func cameraButtonAction(_ button: UIBarButtonItem) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = [kUTTypeImage as String]
        imagePickerController.sourceType = UIImagePickerControllerSourceType.camera
        imagePickerController.allowsEditing = true
        
        self.present(imagePickerController, animated: true, completion: nil)
        
    }
    
    @IBAction func compareButtonAction(_ button: UIBarButtonItem) {
        self._showDetails()
    }
    
    fileprivate func _showDetails() {
        if let metaData = _pictureView.metaDataSet {    //* image has metadata
            
            if _detailsViewController == nil {
                _detailsViewController = DetailsViewController(pictureViewController: self)
            }
            
            _detailsViewController?.show(metaDataSet: metaData, inViewController: self)
            _detailsViewController?.set(dismissTarget: self, action: _hideDetails)
            
            let flexibleSpaceBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            _toolBar.setItems([flexibleSpaceBarButtonItem, _cancelBarButtonItem], animated: true)
        } else {        // * image has no metadata. show alert
            if #available(iOS 8.0, *) {
              
                let alertController = UIAlertController(title: "error".localized, message: "no_metadata".localized, preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "ok".localized, style: UIAlertActionStyle.default, handler: { (alertAction) -> Void in
                    alertController.dismiss(animated: true, completion: nil)
                }))
                self.present(alertController, animated: true, completion: nil)
                
            } else {
                // Fallback on earlier versions
                let alertView = UIAlertView(title: "error".localized, message: "no_metadata".localized, delegate: nil, cancelButtonTitle: "ok".localized)
                alertView.show()
            }
           
        
                
        }
        
        
    }
    
    /* not private, because it's used from outside (as action of close bar button item) */
    func _hideDetails() {
        if let vc = _detailsViewController {
            vc.dismiss({ (completed) -> () in
                let flexibleSpaceBarButtonItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
                self._toolBar.setItems([self._addBarButtonItem, flexibleSpaceBarButtonItem, self._cameraBarButtonItem, flexibleSpaceBarButtonItem, self._detailsBarButtonItem], animated: true)
            })
            
        }
    }
    
    //MARK:- private
    fileprivate var _pictureView: PictureView!
    fileprivate var _toolBar: UIToolbar!
    fileprivate var _addBarButtonItem, _cameraBarButtonItem, _detailsBarButtonItem, _cancelBarButtonItem: UIBarButtonItem!
    fileprivate var _detailsViewController: DetailsViewController?

}
