//
//  Utils.swift
//  GitXplorer
//
//  Created by Saroj Maharjan on 16/02/2024.
//

import Foundation

class Utils {
    static func countToDisplayLabel(_ value: Int) -> String{
        if value >= 1000000 {
            let result = String(format: "%.2fM", Double(value) / 1000000)
            return result
        } else if value >= 1000 {
            let result = String(format: "%.2fK", Double(value) / 1000)
            return result
        }
        return "\(value)"
    }
}
