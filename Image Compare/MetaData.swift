//
//  MetaData.swift
//  Image Compare
//
//  Created by Vijay Chandran J on 08/03/16.
//  Copyright © 2016 Vijay Chandran J. All rights reserved.
//

import Foundation

class MetaData : CustomDebugStringConvertible {
    fileprivate(set) var typeName: String = ""
    
    /** the array of metadata elements this metadata represents. Individual elements can also be accessed through the array subscript ([]) */
    fileprivate(set) var data: [DeltaMetaDataElement] = Array<DeltaMetaDataElement>()
    
    init?(dictionaryElement el: (NSObject, AnyObject)) {
        
        if !(el.0 is String) || !(el.1 is [String : AnyObject]){
            return nil
        }
        
        typeName = el.0 as! String
        typeName = typeName.trimmingCharacters(in: CharacterSet(charactersIn: "{}"))
        for el in el.1 as! [String : AnyObject] {
            let element = DeltaMetaDataElement(title:el.0, value: el.1)
            data.append(element)
        }
        
    }
    
    subscript(index: Int) -> MetaDataElement {
        return data[index]
    }
    
    var count: Int {
        get {
            return data.count
        }
    }
    
    var debugDescription: String {
        get {
            var string = "typeName: " + typeName + "\n"
            for d:MetaDataElement in data {
                string += d.debugDescription + "\n"
            }
            return string
        }
    }
    
}
