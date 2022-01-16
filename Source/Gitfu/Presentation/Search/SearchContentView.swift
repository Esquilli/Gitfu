//
//  UserListView.swift
//  Gitfu
//
//  Created by Pedro Fernandez on 1/14/22.
//

import SwiftUI

struct SearchContentView: View {
    @ObservedObject private var viewModel = SearchContentViewModel(githubRepository: GithubWebRepository())
    @State private var query: String = ""
    
    var body: some View {
        List {
            ForEach($viewModel.users, id: \.id) { user in
                UserView(user: user)
            }
            
            if viewModel.moreUsersAvailable() {
                HStack {
                    Spacer()
                    ProgressView()
                        .onAppear {
                            viewModel.fetchUsers(query: query)
                        }
                    Spacer()
                }
            }
        }
        .emptyState(viewModel.users.isEmpty, emptyContent: {
            StateView(title: "Find Users", subtitle: "Search all GitHub's users")
        })
        .searchable(text: $query, placement: .automatic, prompt: "Search users")
        .onSubmit(of: .search) {
            viewModel.reset()
            viewModel.fetchUsers(query: query)
        }
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchContentView()
    }
}
