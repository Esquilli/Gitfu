//
//  NewsWebRepository.swift
//  Newsi
//
//  Created by Pedro Fernandez on 1/6/22.
//

import Combine
import CoreLocation
import Foundation

protocol GithubWebRepositoryProtocol: AnyObject {
    func fetchUsers(query: String, perPage: Int, page: Int) -> AnyPublisher<SearchUsersResponse, Error>
}

final class GithubWebRepository: GithubWebRepositoryProtocol {
    private let networker: NetworkServiceProtocol
    
    init(networker: NetworkServiceProtocol = NetworkService()) {
        self.networker = networker
    }
    
    func fetchUsers(query: String, perPage: Int, page: Int) -> AnyPublisher<SearchUsersResponse, Error> {
        let endpoint = Endpoint.Github.users(query: query, perPage: perPage, page: page)
        
        return networker.get(type: SearchUsersResponse.self, url: endpoint.url, headers: endpoint.headers)
    }
}
