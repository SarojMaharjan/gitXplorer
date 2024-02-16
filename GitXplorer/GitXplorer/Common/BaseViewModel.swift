//
//  BaseViewModel.swift
//  GitXplorer
//
//  Created by Saroj Maharjan on 15/02/2024.
//
import Combine
import Foundation

protocol APICallStatusDelegate {
    func onAPICallStateChanged(isLoading: Bool)
}
class BaseViewModel {
    var isLoading = false {
        didSet {
            self.apiCallStateDelegate?.onAPICallStateChanged(isLoading: isLoading)
        }
    }
    var cancellables: Set<AnyCancellable> = []
    
    let apiCallStateDelegate: APICallStatusDelegate?
    
    init(apiCallStateDelegate: APICallStatusDelegate?) {
        self.apiCallStateDelegate = apiCallStateDelegate
    }
    
    func apiRequest<T: Codable>(route: Router, onReceive: @escaping((T?, Error?) -> Void)) {
        self.isLoading = true
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        Network
            .init(router: route)
            .request(jsonDecoder)
            .map{( $0.value as T )}
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    onReceive(nil, error)
                case .finished:
                    break
                }
            }, receiveValue: { response in
                onReceive(response, nil)
            }).store(in: &cancellables)
    }
}
