//
//  MetaData.swift
//  Image Compare
//
//  Created by Vijay Chandran J on 08/03/16.
//  Copyright © 2016 Vijay Chandran J. All rights reserved.
//

import Foundation

class MetaData : CustomDebugStringConvertible {
    private(set) var typeName: String = ""
    private(set) var data: [MetaDataElement] = Array<MetaDataElement>()
    
    init?(dictionaryElement el: (NSObject, AnyObject)) {
        
        if !(el.0 is String) || !(el.1 is [String : AnyObject]){
            return nil
        }
        
        typeName = el.0 as! String
        typeName = typeName.stringByTrimmingCharactersInSet(NSCharacterSet(charactersInString: "{}"))
        for el in el.1 as! [String : AnyObject] {
            let element = MetaDataElement(title:el.0, value: el.1)
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