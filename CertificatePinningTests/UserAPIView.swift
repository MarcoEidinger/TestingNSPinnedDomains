//
//  UserAPIView.swift
//  CertificatePinningTests
//
//  Created by Eidinger, Marco on 6/4/21.
//

import Foundation
import SwiftUI

struct UserAPIView: View {
    @State var users: [User] = []

    var body: some View {
        List(users) { user in

            Text(user.username)
                .font(.headline)
            Text(user.name)
                .font(.subheadline)
        }
        .onAppear {
            apiCall().getUsers { users in
                self.users = users
            }
        }
    }
}

struct UserAPIViewPreviews: PreviewProvider {
    static var previews: some View {
        UserAPIView()
    }
}

struct User: Codable, Identifiable {
    let id = UUID()
    let username: String
    let name: String
}

class apiCall {
    func getUsers(completion: @escaping ([User]) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print(error.localizedDescription)
                let fakeUser = User(username: "ERROR", name: error.localizedDescription)
                completion([fakeUser])
                return
            }
            let users = try! JSONDecoder().decode([User].self, from: data!)
            print(users)

            DispatchQueue.main.async {
                completion(users)
            }
        }
        .resume()
    }
}
