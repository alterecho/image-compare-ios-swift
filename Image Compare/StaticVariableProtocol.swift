//
//  StaticVariableProtocol.swift
//  Image Compare
//
//  Created by Vijay Chandran J on 13/03/16.
//  Copyright © 2016 Vijay Chandran J. All rights reserved.
//

import Foundation

/** declare the methods that classes with static variables must adopt */
protocol StaticVariablesProtocol {
    static func initializeStaticVariable()
}