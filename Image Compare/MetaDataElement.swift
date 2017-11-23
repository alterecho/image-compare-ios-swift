//
//  MetaData_Element.swift
//  Image Compare
//
//  Created by Vijay Chandran J on 08/03/16.
//  Copyright © 2016 Vijay Chandran J. All rights reserved.
//

import Foundation

class MetaDataElement : CustomDebugStringConvertible {
    fileprivate(set) var title, valueString: String
    fileprivate(set) var value: AnyObject
    convenience init() {
        self.init(title: "", value: "" as AnyObject)
    }
    
    init(title: String, value: AnyObject) {
        print("\(title)(\(type(of: title))): \(value)\(type(of: value)))")
        
        self.title = title
        self.value = value

        if let array = value as? Array<NSNumber> {
            var str = ""
            for i in 0 ..< array.count {
                let obj = array[i]
                str += String(describing: obj)
                if (i < array.count - 1) {
                    str += ", " // * append comma if there are more iterations
                }
            }
           self.valueString = str
        } else {
            self.valueString = String(describing: value)
        }
        
        
    }
    
    var debugDescription: String {
        get {
            return title + ": " + valueString
        }
    }
}

