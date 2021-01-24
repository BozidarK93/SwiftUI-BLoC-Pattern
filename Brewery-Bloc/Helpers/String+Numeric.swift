//
//  String+Numeric.swift
//  Brewery-Bloc
//
//  Created by Bozidar Kokot on 20.01.21.
//

import Foundation

extension String {
    
    var isNumeric: Bool{

        let numberRegEx  = ".*[0-9]+.*"
        let testCase = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        return testCase.evaluate(with: self)
    }
}
