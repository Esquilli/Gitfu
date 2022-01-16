//
//  UserView.swift
//  Gitfu
//
//  Created by Pedro Fernandez on 1/13/22.
//

import SwiftUI
import SafariServices

struct UserView: View {
    @Binding var user: User
    @State private var showWebView = false
    
    var body: some View {
        Button(action: { self.showWebView = true }) {
            HStack(spacing: 20) {
                ImageView(url: user.avatarURL)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(.tertiary, lineWidth: 0.5))
                
                Text(user.login)
                    .font(.system(size: 20, weight: .regular, design: .default))
            }
            .padding([.top, .bottom], 5)
        }
        .buttonStyle(PlainButtonStyle())
        .sheet(isPresented: $showWebView) {
            WebView(url: URL(string: self.user.htmlURL)!).edgesIgnoringSafeArea(.all)
        }
    }
}

struct WebView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<WebView>) -> SFSafariViewController {
        let webview = SFSafariViewController(url: url)
        return webview
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<WebView>) {
        // No-op
    }
}
