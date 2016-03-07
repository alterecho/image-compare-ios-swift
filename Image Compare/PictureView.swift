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

/*
    View which holds an imageview, and allows panning and rotation of the imageview
*/
class PictureView: UIView {
    
    /* 
        extracts relevant data (image and metadata) from an info dictionary.
        set the info from the UIImagePickerController delegate method.
    */
    func set(imagePickerControllerMediaInfo info: [String: AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self._imageView.image = image
            self._imageView.sizeToFit()
        }
        
        if let url = info[UIImagePickerControllerReferenceURL] as? NSURL {
            let assetsLibrary = ALAssetsLibrary()
            assetsLibrary.assetForURL(url, resultBlock: { (asset: ALAsset!) -> Void in
                let assetRepresentation: ALAssetRepresentation = asset.defaultRepresentation()
                self.metaData = assetRepresentation.metadata()
                }, failureBlock: { (error: NSError!) -> Void in
                    
            })
        }
    }
    

    private(set) var metaData: [NSObject: AnyObject]?
    var toolBarHeight: CGFloat = 0.0    // * is changed by PictureViewController, when it's frame property is set
    
    

    convenience init() {
        self.init(frame: CGRectZero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.greenColor()
        
        // * gestures
        _panGesture = UIPanGestureRecognizer(target: self, action: "pan:")
        self.addGestureRecognizer(_panGesture!)
        
        _rotationGesture = UIRotationGestureRecognizer(target: self, action: "rotate:")
        self.addGestureRecognizer(_rotationGesture!)
        
        _tapGesture = UITapGestureRecognizer(target: self, action: "tap:")
        _tapGesture?.numberOfTapsRequired = 2
        self.addGestureRecognizer(_tapGesture!)
        
        _pinchGesture = UIPinchGestureRecognizer(target: self, action: "pinch:")
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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        touchPoint = touch?.locationInView(touch?.view)
        super.touchesBegan(touches, withEvent: event)
    }
    
    @IBAction private func pan(gesture: UIPanGestureRecognizer) {
        print(gesture.translationInView(self))
        let t = gesture.translationInView(self)
        if gesture.state == UIGestureRecognizerState.Began {
            originalPosition = _imageView.center
        } else if gesture.state == UIGestureRecognizerState.Ended {
        } else {
            if let tp = touchPoint {
                _imageView.center = CGPointMake(originalPosition.x + t.x, originalPosition.y + t.y)
            }
            
        }
        
    }
    
    @IBAction private func rotate(gesture: UIRotationGestureRecognizer) {
        print(gesture.rotation)
        if gesture.state == UIGestureRecognizerState.Began {
            let transform = _imageView.transform
            _initialAngle = atan2(transform.b, transform.a)
        } else if gesture.state == UIGestureRecognizerState.Changed {
            let transform = CGAffineTransformMakeRotation(_initialAngle + gesture.rotation)
            _imageView.transform = transform
        }
       
    }
    
    @IBAction private func tap(gesture: UITapGestureRecognizer) {
        if gesture.numberOfTapsRequired == 2 {
            self.reset()
        }
    }
    
    @IBAction private func pinch(gesture: UIPinchGestureRecognizer) {
        print(gesture.scale)
        if gesture.state == UIGestureRecognizerState.Began {
            _initialFrame = _imageView.bounds
        } else if gesture.state == UIGestureRecognizerState.Changed {
            let w = _initialFrame.width * gesture.scale
            let h = _initialFrame.height * gesture.scale
            _imageView.bounds = CGRectMake(0.0, 0.0, w, h)
        }
        
    }
    
    
    private var _panGesture: UIPanGestureRecognizer?
    private var _rotationGesture: UIRotationGestureRecognizer?
    private var _tapGesture: UITapGestureRecognizer?
    private var _pinchGesture: UIPinchGestureRecognizer?
    
    private let _imageView: UIImageView = UIImageView()
    private var originalPosition: CGPoint = CGPointZero
    private var touchPoint: CGPoint?
    private var touchDiff: CGPoint = CGPointZero
    private var _initialFrame: CGRect = CGRectZero // * used to calculate image frame, for pinch gesture
    private var _initialAngle: CGFloat = 0.0 // * used for rotation gesture
    
    private func reset() {
        _imageView.transform = CGAffineTransformMakeRotation(0.0)
        
        if (_imageView.frame.size.width != _imageView.image?.size.width) {
            _imageView.sizeToFit()
        } else {
            _imageView.frame = self.rectFittingRectInRect(rect: _imageView.frame, containingRect: self.frame, inset: UIEdgeInsetsMake(toolBarHeight, 0.0, 0.0, 0.0))
            return
        }
        
        
        _imageView.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5)
        
    }
    
    private func rectFittingRectInRect(var rect f1: CGRect, var containingRect f2: CGRect, inset: UIEdgeInsets) -> CGRect {
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
