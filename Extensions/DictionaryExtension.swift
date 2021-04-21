//
//  DictionaryExtension.swift
//  MovieMobileTask
//
//  Created by ALY on 08/04/2021.
//

import Foundation

extension Dictionary {
    
    var queryString: String {
        var output: String = ""
        for (key,value) in self {
            if value is String {
                let strValue = value as? String ?? ""
                output +=  "\(key)=\(strValue.addingPercentEncodingForURLQueryValue() ?? "")&"
            }else {
                output +=  "\(key)=\(value)&"
            }
            
        }
        output = String(output.dropLast())
        return output
    }

}
