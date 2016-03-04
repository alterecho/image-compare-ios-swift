//
//  PictureView.swift
//  Image Compare
//
//  Created by Vijay Chandran J on 03/03/16.
//  Copyright © 2016 Vijay Chandran J. All rights reserved.
//

import UIKit

/*
    View which holds an imageview, and allows panning and rotation of the imageview
*/
class PictureView: UIView {
    
    var image: UIImage? {
        get {
            return _imageView.image
        }
        
        set(newImage) {
            _imageView.image = newImage
            _imageView.sizeToFit()
        }
    }
    
    

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
        
        self.addSubview(_imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        if let gesture = _rotationGesture {
            self.removeGestureRecognizer(gesture)
        }
        
        if let gesture = _panGesture {
            self.removeGestureRecognizer(gesture)
        }
        
    }
    
    @IBAction private func pan(gesture: UIPanGestureRecognizer) {
        print(gesture.translationInView(self))
    }
    
    @IBAction private func rotate(gesture: UIRotationGestureRecognizer) {
        print(gesture.rotation)
        let transform = CGAffineTransformMakeRotation(gesture.rotation)
        _imageView.transform = transform
    }
    
    private var _panGesture: UIPanGestureRecognizer?
    private var _rotationGesture: UIRotationGestureRecognizer?
    private let _imageView: UIImageView = UIImageView()

}
