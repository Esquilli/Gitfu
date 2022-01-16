//
//  NewsFeedView.swift
//  Newsi
//
//  Created by Pedro Fernandez on 1/7/22.
//

import CoreLocationUI
import SwiftUI

struct HomeView: View {
    @State private var query = ""
    
    var body: some View {
        NavigationView {
            SearchContentView()
            .navigationTitle("Users")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
