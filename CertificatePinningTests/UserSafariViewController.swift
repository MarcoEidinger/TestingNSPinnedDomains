//
//  UserSafariViewController.swift
//  CertificatePinningTests
//
//  Created by Eidinger, Marco on 6/8/21.
//

import Combine
import Foundation
import SafariServices
import SwiftUI

struct UserSafariViewController: View {
    let url: URL
    var body: some View {
        SafariView(url: url)
    }
}

struct UserSafariViewController_Previews: PreviewProvider {
    static var previews: some View {
        UserSafariViewController(url: URL(string: "https://jsonplaceholder.typicode.com/users")!)
    }
}

struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context _: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_: SFSafariViewController, context _: UIViewControllerRepresentableContext<SafariView>) {}
}
