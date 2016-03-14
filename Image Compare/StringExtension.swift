//
//  StringExtension.swift
//  Image Compare
//
//  Created by Vijay Chandran J on 14/03/16.
//  Copyright © 2016 Vijay Chandran J. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "nil")
    }
}