//
//  DetailsTableViewCell.swift
//  Image Compare
//
//  Created by Vijay Chandran J on 11/03/16.
//  Copyright © 2016 Vijay Chandran J. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {
    
    static var cellWidth: CGFloat = 0.0
    
    /** returns the required cell height, to display the contents completely */
    class func heightForMetaDataElement(metaDataElement mde: MetaDataElement) -> CGFloat {
        let fontSize = UIFont.systemFontSize
        let font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        let attributes = [NSFontAttributeName: font]
        
        // * get title rect
        let titleString = mde.title + "    " as NSString
        let r_title = titleString.boundingRect(with: CGSize(width: cellWidth * _RATIO_TITLE, height: CGFloat(Float.greatestFiniteMagnitude)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        // * get value rect
        let valueString = mde.valueString as NSString
        let r_value = valueString.boundingRect(with: CGSize(width: cellWidth * _RATIO_VALUE, height: CGFloat(Float.greatestFiniteMagnitude)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        return r_title.size.height > r_value.size.height ? r_title.size.height * 30.0 / fontSize : r_value.size.height * 30.0 / fontSize
    }
    
    
    var metaDataElement: DeltaMetaDataElement? {
        didSet {
            _titleLabel.text = metaDataElement?.title//.stringByAppendingString(":")
            _valueLabel.text = metaDataElement?.valueString
            
            if let delta = metaDataElement?.delta {
                
                if delta > 0 {
                    
                    _deltaLabel.text = "(+\(delta))"
                    _deltaLabel.textColor = _COLOR_GREATER
                } else if delta < 0 {
                    
                    _deltaLabel.text = "(-\(delta))"
                    _deltaLabel.textColor = _COLOR_LESSER
                } else if delta == 0 {
                    _deltaLabel.text = "\(delta)"
                    _deltaLabel.textColor = _COLOR_EQUAL
                }
            } else {
                
                _deltaLabel.text = nil
                _deltaLabel.textColor = _COLOR_EQUAL
            }
            
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
            DetailsTableViewCell.cellWidth = self.frame.size.width
            
            // * title label
            _titleLabel.numberOfLines = 0
            _titleLabel.frame = CGRect(x: padding, y: 0.0, width: self.frame.size.width * _DTVC._RATIO_TITLE, height: self.frame.size.height)
            
            // * separator label
            _separatorLabel.frame = CGRect(
                x: _titleLabel.frame.origin.x + _titleLabel.frame.size.width + padding, y: _titleLabel.frame.origin.y,
                width: _separatorLabel.frame.size.width, height: _titleLabel.frame.size.height)
            
            // * value label
            _valueLabel.numberOfLines = 0
            _valueLabel.sizeToFit()
            _valueLabel.frame = CGRect(
                x: _separatorLabel.frame.origin.x + _separatorLabel.frame.size.width + padding, y: _titleLabel.frame.origin.y,
                width: self.frame.size.width * _DTVC._RATIO_VALUE, height: _titleLabel.frame.size.height
            )
            
            // * delta label
            _deltaLabel.frame = CGRect(
                x: _valueLabel.frame.origin.x + _valueLabel.frame.size.width, y: _valueLabel.frame.origin.y,
                width: self.frame.size.width - (_valueLabel.frame.origin.x + _valueLabel.frame.size.width), height: self.frame.size.height
            )
            
            if DetailsTableViewController.valueFrame == nil {
                DetailsTableViewController.valueFrame = _valueLabel.frame
            }

        }
    }
    
    /** the cell width ratio each label the labels should occupy*/
    fileprivate static let
    _RATIO_TITLE = 0.45 as CGFloat,
    _RATIO_VALUE = 0.4 as CGFloat
    
    fileprivate typealias _DTVC = DetailsTableViewCell
    
    fileprivate let
    _titleLabel = UILabel(),
    _valueLabel = UILabel(),
    _deltaLabel = UILabel(),
    _separatorLabel = UILabel()
    
    fileprivate let
    _COLOR_GREATER = UIColor.green,
    _COLOR_LESSER = UIColor.red,
    _COLOR_EQUAL = UIColor.white
    
    /* adds the labels to this view */
    fileprivate func addSubviews() {
        self.addSubview(_titleLabel)
        self.addSubview(_separatorLabel)
        self.addSubview(_valueLabel)
        self.addSubview(_deltaLabel)
    }
    
    fileprivate func initialize() {
        _titleLabel.textColor = COLOR_THEME_HIGHLIGHT
        _separatorLabel.textColor = COLOR_THEME_HIGHLIGHT
        _valueLabel.textColor = COLOR_THEME_HIGHLIGHT
        _deltaLabel.textColor = COLOR_THEME_HIGHLIGHT
        
        _titleLabel.textAlignment = NSTextAlignment.right
        _valueLabel.textAlignment = NSTextAlignment.left
        _separatorLabel.textAlignment = NSTextAlignment.center
        
        _separatorLabel.text = ":"
        _separatorLabel.sizeToFit()
        
        self.addSubviews()
    }
    
    
}


