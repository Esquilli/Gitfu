//
//  StateView.swift
//  Gitfu
//
//  Created by Pedro Fernandez on 1/14/22.
//

import SwiftUI

struct StateView: View {
    var title: String
    var subtitle: String
    
    var body: some View {
        VStack(spacing: 10) {
            Text(title)
                .font(.system(size: 24, weight: .bold, design: .default))
                .foregroundColor(.primary)
            
            Text(subtitle)
                .font(.system(size: 18, weight: .regular, design: .default))
                .foregroundColor(.secondary)
        }
    }
}

struct StateView_Previews: PreviewProvider {
    static var previews: some View {
        StateView(title: "Example", subtitle: "Writing someting")
    }
}
