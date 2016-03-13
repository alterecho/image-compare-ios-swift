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
    private(set) var value: AnyObject
    convenience init() {
        self.init(title: "", value: "")
    }
    
    init(title: String, value: AnyObject) {
        print("\(title)(\(title.dynamicType)): \(value)\(value.dynamicType))")
        
        self.title = title
        self.value = value

        if let array = value as? Array<NSNumber> {
            var str = ""
            for var i = 0; i < array.count; i++ {
                let obj = array[i]
                str += String(obj)
                if (i < array.count - 1) {
                    str += ", " // * append comma if there are more iterations
                }
            }
           self.valueString = str
        } else {
            self.valueString = String(value)
        }
        
        
    }
    
    var debugDescription: String {
        get {
            return title + ": " + valueString
        }
    }
}

