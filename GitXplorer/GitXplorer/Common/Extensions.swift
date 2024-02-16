//
//  Extensions.swift
//  GitXplorer
//
//  Created by Saroj Maharjan on 16/02/2024.
//

import Foundation

extension Date {
    func inFormat(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
