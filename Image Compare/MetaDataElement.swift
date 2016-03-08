//
//  MetaData_Element.swift
//  Image Compare
//
//  Created by Vijay Chandran J on 08/03/16.
//  Copyright © 2016 Vijay Chandran J. All rights reserved.
//

import Foundation

class MetaDataElement : CustomDebugStringConvertible {
    private(set) var title, valueString: String
    private(set) var value: Any
    convenience init() {
        self.init(title: "", value: "")
    }
    
    init(title: String, value: Any) {
        print("\(title)(\(title.dynamicType)): \(value)\(value.dynamicType))")
        
        self.title = title
        self.value = value
        self.valueString = String(value)
        
    }
    
    var debugDescription: String {
        get {
            return title + ": " + valueString
        }
    }
}

