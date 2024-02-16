//
//  Network.swift
//  GitXplorer
//
//  Created by Saroj Maharjan on 15/02/2024.
//
import Combine
import Foundation

class Network {
    let urlSession: URLSession
    let decoder: JSONDecoder
    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    
    struct DataResponse {
        let value: Data
        let statusCode: Int
    }
    
    var router: Router
    lazy var webService = WebOperation()
    
    init(router: Router) {
        self.router = router
        self.urlSession = URLSession.shared
        self.urlSession.configuration.timeoutIntervalForRequest = TimeInterval(40)
        self.decoder = JSONDecoder()
        self.decoder.dateDecodingStrategy = .iso8601
    }
    
    func request<T: Decodable>() -> AnyPublisher<Response<T>, Error> {
        self.webService.router = router
        guard var request = webService.buildRequest() else { fatalError("Unable to build api request.") }
        request.cachePolicy = .returnCacheDataDontLoad
        if Reachability.isConnectedToNetwork() {
            request.cachePolicy = .reloadRevalidatingCacheData
        }
        return urlSession
            .dataTaskPublisher(for: request)
            .validateStatusCode()
            .tryMap { result -> Response<T> in
                if let response = result.response as? HTTPURLResponse {
                    response.logResponse(router: self.router, data: result.data)
                }
                let value = try self.decoder.decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
