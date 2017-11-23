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
        titleLabel.textAlignment = NSTextAlignment.center
        
        blurOverlay.barTintColor = UIColor.black
        blurOverlay.isTranslucent = true
        
        self.contentView.addSubview(blurOverlay)
        self.contentView.addSubview(titleLabel)
        self.contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.yellow
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
            blurOverlay.frame = CGRect(x: 0.0, y: 0.0, width: super.frame.size.width, height: super.frame.size.height)
            titleLabel.frame = self.bounds.insetBy(dx: 10.0, dy: 10.0)
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
