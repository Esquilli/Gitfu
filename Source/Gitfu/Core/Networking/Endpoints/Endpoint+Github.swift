//
//  Endpoint+News.swift
//  Newsi
//
//  Created by Pedro Fernandez on 1/6/22.
//

import Combine
import Foundation

extension Endpoint {
    struct Github: EndpointProtocol {
        var path: String
        var queryItems: [URLQueryItem] = []
        private static let githubApiKey = "<YOUR API KEY HERE>"
        
        var url: URL {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.github.com"
            components.path = path
            components.queryItems = queryItems
            
            guard let url = components.url else {
                preconditionFailure("Invalid URL components: \(components)")
            }
            
            return url
        }
        
        var headers: [String: Any] {
            return [:]
        }
    }
}

extension Endpoint.Github {
    static func users(query: String, perPage: Int, page: Int) -> Self {
        return Endpoint.Github(path: "/search/users",
                                queryItems: [
                                    URLQueryItem(name: "q", value: query),
                                    URLQueryItem(name: "per_page", value: String(perPage)),
                                    URLQueryItem(name: "page", value: String(page))
        ])
    }
}
