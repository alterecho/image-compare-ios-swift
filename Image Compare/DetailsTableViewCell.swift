//
//  DetailsTableViewCell.swift
//  Image Compare
//
//  Created by Vijay Chandran J on 11/03/16.
//  Copyright © 2016 Vijay Chandran J. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    var metaDataElement: DeltaMetaDataElement? {
        didSet {
            _titleLabel.text = metaDataElement?.title.stringByAppendingString(":")
            _valueLabel.text = metaDataElement?.value as? String
            _deltaLabel.text = "\(metaDataElement?.delta)"
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    override var frame: CGRect {
        didSet {
            let padding = 5.0 as CGFloat
            _titleLabel.frame = CGRectMake(0.0, 0.0, self.frame.size.width * 0.4, self.frame.size.height)
            
            _valueLabel.sizeToFit()
            _valueLabel.frame = CGRectMake(
                _titleLabel.frame.origin.x + _titleLabel.frame.size.width + padding, _titleLabel.frame.origin.y,
                _valueLabel.frame.size.width, self.frame.size.height
            )
            
            _deltaLabel.frame = CGRectMake(
                _valueLabel.frame.origin.x + _valueLabel.frame.size.width, _valueLabel.frame.origin.y,
                self.frame.size.width - (_valueLabel.frame.origin.x + _valueLabel.frame.size.width), self.frame.size.height
            )
        }
    }
    
    //MARK: - private -
    
    private let
    _titleLabel = UILabel(),
    _valueLabel = UILabel(),
    _deltaLabel = UILabel()
    
    /* adds the labels to this view */
    private func addSubviews() {
        self.addSubview(_titleLabel)
        self.addSubview(_valueLabel)
        self.addSubview(_deltaLabel)
    }
    
    private func initialize() {
        _titleLabel.textColor = COLOR_THEME_HIGHLIGHT
        _valueLabel.textColor = COLOR_THEME_HIGHLIGHT
        _deltaLabel.textColor = COLOR_THEME_HIGHLIGHT
        
        _titleLabel.textAlignment = NSTextAlignment.Right
        _valueLabel.textAlignment = NSTextAlignment.Left
        
        self.addSubviews()
    }
}
