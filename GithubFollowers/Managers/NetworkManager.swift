//
//  NetworkManager.swift
//  GithubFollowers
//
//  Created by Mary Baptista Martinez on 6/27/22.
//

import UIKit

class NetworkManager {
  static let shared = NetworkManager()
  private let baseUrl = "https://api.github.com/users/"
  let cache = NSCache<NSString, UIImage>()

  private init() {}

  func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void) {
    let endpoint = baseUrl + "\(username)/followers?per_page=100&page=\(page)"
    guard let url = URL(string: endpoint) else {
      completed(.failure(.invalidUsername))
      return
    }
    get(url, completed: completed)
  }

  func getUserInfo(for username: String, completed: @escaping (Result<User, GFError>) -> Void) {
    let endpoint = baseUrl + "\(username)"
    guard let url = URL(string: endpoint) else {
      completed(.failure(.invalidUsername))
      return
    }
    get(url, completed: completed)
  }

  func get<T: Decodable>(_ url: URL, completed: @escaping (Result<T, GFError>) -> Void) {
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      if let _ = error {
        completed(.failure(.unableToComplete))
      }

      guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        completed(.failure(.invalidResponse))
        return
      }

      guard let data = data else {
        completed(.failure(.invalidData))
        return
      }

      do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let data = try decoder.decode(T.self, from: data)
        completed(.success(data))

      } catch {
        completed(.failure(.invalidData))
      }
    }

    task.resume()
  }
}
