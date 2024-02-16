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
extension HTTPURLResponse {
    func logResponse(router: Router, data: Data) {
        print("""
            /** Request **/
            URL: \(String.init(describing: router.url))
            Header: \(String.init(describing: router.headers))
            Method: \(String.init(describing: router.method))
            Parameters: \(String.init(describing: router.parameters))
            -------------------------------------------
            /** Response **/
            StatusCode: \(String.init(describing: self.statusCode ))
            Response: \(NetworkUtils.serializeJSON(data: data))
            -------------------------------------------
            """
        )
    }
}
