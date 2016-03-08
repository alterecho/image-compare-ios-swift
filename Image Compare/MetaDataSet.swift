//
//  MetaDataSet.swift
//  Image Compare
//
//  Created by Vijay Chandran J on 08/03/16.
//  Copyright © 2016 Vijay Chandran J. All rights reserved.
//

import Foundation

class MetaDataSet : CustomDebugStringConvertible {
    
    private var _metaDataArray: [MetaData] = [MetaData]()
    
    init(dictionary d: [NSObject : AnyObject]) {
        
        for el in d {
            
            if let metaData = MetaData(dictionaryElement: el) {
                _metaDataArray.append(metaData)
            }
        }
    }
    
    subscript(index: Int) -> MetaData {
        var ret: MetaData
        ret = _metaDataArray[index]
        return ret
    }
    
    var count: Int {
        get {
            return _metaDataArray.count
        }
        
    }
    
    var debugDescription: String {
        get {
            var string: String = ""
            for metaData in _metaDataArray {
                string += metaData.debugDescription + "\n"
            }
            return string
        }
    }
}
