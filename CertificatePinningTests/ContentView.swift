//
//  ContentView.swift
//  CertificatePinningTests
//
//  Created by Eidinger, Marco on 6/4/21.
//

import SwiftUI

struct ContentView: View {
    @State var selection: Int? = nil
    @State var showSafari = false
    @State var urlString = "https://jsonplaceholder.typicode.com/users"
    var body: some View {
        NavigationView {
            VStack {
                ExplanationView(desc: "App to test SSL Pinning (NSPinnedDomains, iOS 14+)\n\nInfo.Plist contains value for NSPinnedLeafIdentities of jsonplaceholder.typicode.com\n\nUse Charles and enable SSL proxy for domain to test certificate pinning")
                NavigationLink(destination: UserAPIView(), tag: 1, selection: $selection) {
                    Button("API (URLSession.shared.dataTask)") {
                        self.selection = 1
                    }
                }.padding()
                NavigationLink(destination: UserWKWebView(url: URL(string: urlString)!), tag: 2, selection: $selection) {
                    Button("WKWebView") {
                        self.selection = 2
                    }
                }.padding()
                Button(action: {
                    self.showSafari = true
                }) {
                    Text("SafariViewController")
                }
                // summon the Safari sheet
                .sheet(isPresented: $showSafari) {
                    SafariView(url: URL(string: self.urlString)!)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ExplanationView: View {
    var desc = "Use this to..."
    var back = Color.yellow
    var textColor = Color.black

    var body: some View {
        Text(desc)
            .frame(maxWidth: .infinity)
            .padding()
            .background(back)
            .foregroundColor(textColor)
    }
}
