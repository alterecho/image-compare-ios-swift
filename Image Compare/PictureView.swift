//
//  PictureView.swift
//  Image Compare
//
//  Created by Vijay Chandran J on 03/03/16.
//  Copyright © 2016 Vijay Chandran J. All rights reserved.
//

import UIKit
import ImageIO
import AssetsLibrary

/** 
    View which holds an imageview, and allows panning and rotation of the imageview 
 */
class PictureView: UIView {
    
    /**
        extracts relevant data (image and metadata) from an info dictionary.
        sets the info from the UIImagePickerController delegate method.
        - returns: a tuple indicating if an image was extacted (0) and if meta-data was found (1)
    */
    func set(imagePickerControllerMediaInfo info: [String: AnyObject]) -> (Bool, Bool) {
        
        var ret: (Bool, Bool) = (false, false)
        
            // * get image from info
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self._imageView.image = image
            self._imageView.sizeToFit()
            ret.0 = true
            
        }
        // * get meta-data from info
        if let url = info[UIImagePickerControllerReferenceURL] as? URL {
            let assetsLibrary = ALAssetsLibrary()
            
            assetsLibrary.asset(for: url, resultBlock: { (asset: ALAsset?) in
                if let assetRepresentation: ALAssetRepresentation = asset?.defaultRepresentation() {
//                    self.metaDataSet = MetaDataSet(dictionary: assetRepresentation.metadata() as! [NSObject : AnyObject])
                    
                    self.metaDataSet = MetaDataSet(dictionary: assetRepresentation.metadata())
                    
                    ret.1 = true
                }
                
            }, failureBlock: { (error: Error?) in
                
            })
            
//            assetsLibrary.asset(for: url, resultBlock: { (asset: ALAsset!) -> Void in
//                let assetRepresentation: ALAssetRepresentation = asset.defaultRepresentation()
//                self.metaDataSet = MetaDataSet(dictionary: assetRepresentation.metadata() as! [NSObject : AnyObject])
//                ret.1 = true
//                }, failureBlock: { (error: NSError!) -> Void in
//                    
//            } as! ALAssetsLibraryAccessFailureBlock)
        }
        
        return ret
    }
    
    
    /** the metadata of the image is retrieved, when the image */
    fileprivate(set) var metaDataSet: MetaDataSet?
    
    /** is changed by PictureViewController, when it's frame property is set */
    var toolBarHeight: CGFloat = 0.0
    
    

    convenience init() {
        self.init(frame: CGRect.zero)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.green
        
        // * gestures
        _panGesture = UIPanGestureRecognizer(target: self, action: #selector(PictureView.pan(_:)))
        self.addGestureRecognizer(_panGesture!)
        
        _rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(PictureView.rotate(_:)))
        self.addGestureRecognizer(_rotationGesture!)
        
        _tapGesture = UITapGestureRecognizer(target: self, action: #selector(PictureView.tap(_:)))
        _tapGesture?.numberOfTapsRequired = 2
        self.addGestureRecognizer(_tapGesture!)
        
        _pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(PictureView.pinch(_:)))
        self.addGestureRecognizer(_pinchGesture!)
        
        
        self.addSubview(_imageView)
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        if let gesture = _pinchGesture {
            self.removeGestureRecognizer(gesture)
        }
        
        if let gesture = _tapGesture {
            self.removeGestureRecognizer(gesture)
        }
        
        if let gesture = _rotationGesture {
            self.removeGestureRecognizer(gesture)
        }
        
        if let gesture = _panGesture {
            self.removeGestureRecognizer(gesture)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        touchPoint = touch?.location(in: touch?.view)
        super.touchesBegan(touches, with: event)
    }
    
    @IBAction fileprivate func pan(_ gesture: UIPanGestureRecognizer) {
        print(gesture.translation(in: self))
        let t = gesture.translation(in: self)
        if gesture.state == UIGestureRecognizerState.began {
            originalPosition = _imageView.center
        } else if gesture.state == UIGestureRecognizerState.ended {
        } else {
            if let _ = touchPoint {
                _imageView.center = CGPoint(x: originalPosition.x + t.x, y: originalPosition.y + t.y)
            }
            
        }
        
    }
    
    @IBAction fileprivate func rotate(_ gesture: UIRotationGestureRecognizer) {
        print(gesture.rotation)
        if gesture.state == UIGestureRecognizerState.began {
            let transform = _imageView.transform
            _initialAngle = atan2(transform.b, transform.a)
        } else if gesture.state == UIGestureRecognizerState.changed {
            let transform = CGAffineTransform(rotationAngle: _initialAngle + gesture.rotation)
            _imageView.transform = transform
        }
       
    }
    
    @IBAction fileprivate func tap(_ gesture: UITapGestureRecognizer) {
        if gesture.numberOfTapsRequired == 2 {
            self.reset()
        }
    }
    
    @IBAction fileprivate func pinch(_ gesture: UIPinchGestureRecognizer) {
        print(gesture.scale)
        if gesture.state == UIGestureRecognizerState.began {
            _initialFrame = _imageView.bounds
        } else if gesture.state == UIGestureRecognizerState.changed {
            let w = _initialFrame.width * gesture.scale
            let h = _initialFrame.height * gesture.scale
            _imageView.bounds = CGRect(x: 0.0, y: 0.0, width: w, height: h)
        }
        
    }
    
    
    fileprivate var _panGesture: UIPanGestureRecognizer?            // * to move the image
    fileprivate var _rotationGesture: UIRotationGestureRecognizer?  // * to rotate image with two fingers
    fileprivate var _tapGesture: UITapGestureRecognizer?            // * double tap picture size toggle (fit to screen, max size)
    fileprivate var _pinchGesture: UIPinchGestureRecognizer?        // * pinch zoom
    
    fileprivate let _imageView: UIImageView = UIImageView()     // * the image container
    fileprivate var originalPosition: CGPoint = CGPoint.zero     // * to move the image according to touch location inside (natural pan)
    fileprivate var touchPoint: CGPoint?                        // * the point of first touch
    fileprivate var _initialFrame: CGRect = CGRect.zero          // * used to calculate image frame, for pinch gesture
    fileprivate var _initialAngle: CGFloat = 0.0                // * used for rotation gesture
    
    fileprivate func reset() {
        _imageView.transform = CGAffineTransform(rotationAngle: 0.0)
        
        if (_imageView.frame.size.width != _imageView.image?.size.width) {
            _imageView.sizeToFit()
        } else {
            _imageView.frame = self.rectFittingRectInRect(rect: _imageView.frame, containingRect: self.frame, inset: UIEdgeInsetsMake(toolBarHeight, 0.0, 0.0, 0.0))
        }
        
        
        _imageView.center = CGPoint(x: self.bounds.size.width * 0.5, y: toolBarHeight + (self.bounds.size.height - toolBarHeight) * 0.5)
        
    }
    
    private func rectFittingRectInRect(rect f1: CGRect, containingRect f2: CGRect, inset: UIEdgeInsets) -> CGRect {
        var f1 = f1, f2 = f2
        f2.origin.x += inset.left
        f2.origin.y += inset.top
        f2.size.width -= (inset.left + inset.right)
        f2.size.height -= (inset.top + inset.bottom)
        
        if f1.size.width > f2.size.width {
            f1.size.height *= (f2.size.width / f1.size.width)
            f1.size.width = f2.width
        }
        
        if f1.size.height > f2.size.height {
            f1.size.width *= (f2.size.height / f1.size.height)
            f1.size.height = f2.size.height
        }
        
        return f1
    }
    
    
    
}
