//
//  DeltaMetaDetaElement.swift
//  Image Compare
//
//  Created by Vijay Chandran J on 11/03/16.
//  Copyright © 2016 Vijay Chandran J. All rights reserved.
//

import Foundation

/**
 MetaDetaElement subclass that holds the difference value, compared to another *MetaDataElement*
*/

class DeltaMetaDataElement : MetaDataElement {
    
    ///holds the difference metadata (with another *MetaDataElement*)
    var delta: Float?
    
    
    override init(title: String, value: Any) {
        super.init(title: title, value: value)
    }
    
    
}