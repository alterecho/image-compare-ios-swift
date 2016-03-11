//
//  TableViewHeaderFooterView.swift
//  Image Compare
//
//  Created by Vijay Chandran J on 10/03/16.
//  Copyright © 2016 Vijay Chandran J. All rights reserved.
//

import UIKit

class DetailsTableViewHeaderFooterView: UITableViewHeaderFooterView {
    
    let titleLabel: UILabel = UILabel()
    let blurOverlay = UIToolbar()
    
    override init(reuseIdentifier: String?) {

        super.init(reuseIdentifier: reuseIdentifier)
        
        titleLabel.textColor = COLOR_THEME_HIGHLIGHT
        titleLabel.textAlignment = NSTextAlignment.Center
        
        blurOverlay.barTintColor = UIColor.blackColor()
        blurOverlay.translucent = true
        
        self.contentView.addSubview(blurOverlay)
        self.contentView.addSubview(titleLabel)
        self.contentView.backgroundColor = UIColor.clearColor()
        self.backgroundColor = UIColor.yellowColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //*
    override var frame: CGRect {
        get {
          return super.frame
        }
        
        set(value) {
            super.frame = value
            blurOverlay.frame = CGRectMake(0.0, 0.0, super.frame.size.width, super.frame.size.height)
            titleLabel.frame = CGRectInset(self.bounds, 10.0, 10.0)
        }
    }
    
    override var center: CGPoint {
        get {
            return super.center
        }
        
        set(value) {
            super.center = value
        }
    }
    //*/
}
