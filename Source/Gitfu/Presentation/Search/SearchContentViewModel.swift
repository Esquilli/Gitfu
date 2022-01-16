//
//  SearchContentViewModel.swift
//  Gitfu
//
//  Created by Pedro Fernandez on 1/15/22.
//

import Combine
import Foundation

class SearchContentViewModel: ObservableObject {
    @Published var state: LoadingState = .idle
    @Published var users = [User]()
    
    var totalPages = 0
    var currentPage = 1
    private let perPage = 15
    
    private let githubRepository: GithubWebRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
    private var apiResponse: SearchUsersResponse?
    
    init(githubRepository: GithubWebRepositoryProtocol) {
        self.githubRepository = githubRepository
    }
    
    func fetchUsers(query: String) {
        print(currentPage)
        githubRepository.fetchUsers(query: query, perPage: perPage, page: currentPage)
        .receive(on: DispatchQueue.main)
        .sink { completion in
            switch completion {
            case .finished:
                print("Finished")
            case .failure(_):
                print("Something happened")
            }
            
        } receiveValue: { [weak self] response in
            self?.apiResponse = response
            self?.users += response.items
            self?.currentPage += 1
            
//            response.items.sorted {
//                $0.login < $1.login
//            }
            
            guard let perPage = self?.perPage else { return }
            self?.totalPages = Int((Double(response.totalCount) / Double(perPage)).rounded(.awayFromZero))
        }
        .store(in: &cancellables)
    }
    
    func reset() {
        self.currentPage = 1
        self.users.removeAll()
    }
    
    func moreUsersAvailable() -> Bool {
        return (currentPage + 1) <= totalPages
    }
}
